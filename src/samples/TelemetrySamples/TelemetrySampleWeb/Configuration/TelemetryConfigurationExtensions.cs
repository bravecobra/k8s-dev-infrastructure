using System.Diagnostics;
using System.Reflection;
using OpenTelemetry;
using OpenTelemetry.Exporter;
using OpenTelemetry.Instrumentation.AspNetCore;
using OpenTelemetry.Logs;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using Serilog;
using Serilog.Core.Enrichers;
using Serilog.Enrichers.Span;

namespace TelemetrySampleWeb.Configuration
{
    public static class TelemetryConfigurationExtensions
    {
        internal const string MyApplicationMeterName = "MyApplication";

        public static void AddCustomTelemetry(this IServiceCollection services,
            IConfiguration configuration, ResourceBuilder resourceBuilder)
        {
            services.AddOpenTelemetry()
                .WithTracing(options =>
                {
                    options
                        .SetResourceBuilder(resourceBuilder)
                        .SetSampler(new AlwaysOnSampler())
                        .AddHttpClientInstrumentation()
                        .AddAspNetCoreInstrumentation(instrumentationOptions =>
                        {
                            instrumentationOptions.EnrichWithHttpRequest = EnrichWithHttpRequest;
                            instrumentationOptions.EnrichWithHttpResponse = EnrichWithHttpResponse;
                            instrumentationOptions.RecordException = true;
                        })
                        .AddSource(Assembly.GetEntryAssembly()?.GetName().Name);
                    var tracingExporter = configuration.GetValue<string>("UseTracingExporter")?.ToLowerInvariant();
                    switch (tracingExporter)
                    {
                        case "jaeger":
                            options.AddJaegerExporter();
                            services.Configure<JaegerExporterOptions>(configuration.GetSection("Jaeger"));

                            // Customize the HttpClient that will be used when JaegerExporter is configured for HTTP transport.
                            services.AddHttpClient("JaegerExporter", configureClient: client => client.DefaultRequestHeaders.Add("X-MyCustomHeader", "value"));
                            break;

                        // case "zipkin":
                        //     options.AddZipkinExporter();
                        //
                        //     builder.Services.Configure<ZipkinExporterOptions>(builder.Configuration.GetSection("Zipkin"));
                        //     break;

                        case "otlp":
                            options.AddOtlpExporter("traces", otlpOptions =>
                            {
                                otlpOptions.Protocol = OtlpExportProtocol.HttpProtobuf;
                                otlpOptions.Endpoint = new Uri(configuration.GetValue<string>("Otlp:Endpoint") + "/v1/traces");
                                otlpOptions.ExportProcessorType = ExportProcessorType.Simple;
                            });
                            break;

                        default:
                            options.AddConsoleExporter();

                            break;
                    }
                })
                .WithMetrics(options =>
                {
                    options.SetResourceBuilder(resourceBuilder)
                        .AddHttpClientInstrumentation()
                        .AddAspNetCoreInstrumentation()
                        .AddMeter(MyApplicationMeterName);

                    var metricsExporter = configuration.GetValue<string>("UseMetricsExporter")?.ToLowerInvariant();
                    switch (metricsExporter)
                    {
                        case "prometheus":
                            options.AddPrometheusExporter();
                            break;
                        case "otlp":
                            options.AddOtlpExporter("metrics", otlpOptions =>
                            {
                                otlpOptions.Protocol = OtlpExportProtocol.HttpProtobuf;
                                otlpOptions.Endpoint = new Uri(configuration.GetValue<string>("Otlp:Endpoint") + "/v1/metrics");
                                otlpOptions.ExportProcessorType = ExportProcessorType.Simple;
                            });
                            break;
                        default:
                            options.AddConsoleExporter();
                            break;
                    }
                })
                .StartWithHost();
            services.Configure<AspNetCoreInstrumentationOptions>(configuration.GetSection("AspNetCoreInstrumentation"));
        }

        private static void EnrichWithHttpResponse(Activity activity, HttpResponse response)
        {
            activity.AddTag("http.response_content_length", response.ContentLength);
            activity.AddTag("http.response_content_type", response.ContentType);
        }

        private static void EnrichWithHttpRequest(Activity activity, HttpRequest request)
        {
            var context = request.HttpContext;
            activity.AddTag("http.flavor", GetHttpFlavour(request.Protocol));
            activity.AddTag("http.scheme", request.Scheme);
            activity.AddTag("http.client_ip", context.Connection.RemoteIpAddress);
            activity.AddTag("http.request_content_length", request.ContentLength);
            activity.AddTag("http.request_content_type", request.ContentType);
        }

        private static string GetHttpFlavour(string protocol)
        {
            if (HttpProtocol.IsHttp10(protocol))
            {
                return "1.0";
            }

            if (HttpProtocol.IsHttp11(protocol))
            {
                return "1.1";
            }

            if (HttpProtocol.IsHttp2(protocol))
            {
                return "2.0";
            }

            if (HttpProtocol.IsHttp3(protocol))
            {
                return "3.0";
            }

            throw new InvalidOperationException($"Protocol {protocol} not recognised.");
        }

        public static void AddCustomLogging(this WebApplicationBuilder builder, ResourceBuilder resourceBuilder)
        {
            builder.Logging.ClearProviders();
            var logExporter = builder.Configuration.GetValue<string>("UseLogExporter")?.ToLowerInvariant();
            switch (logExporter)
            {
                case "loki":
                {
                    var logger = new LoggerConfiguration()
                        .ReadFrom.Configuration(builder.Configuration)
                        //.MinimumLevel.Debug()
                        //.WriteTo.Console()
                        // .WriteTo.GrafanaLoki(builder.Configuration.GetValue<string>("Loki:Endpoint"), 
                        //     textFormatter: new LokiJsonTextFormatter(),
                        // )
                        .Enrich.FromLogContext()
                        .Enrich.With(new PropertyEnricher("app", Assembly.GetEntryAssembly()?.GetName().Name!))
                        .Enrich.WithAssemblyInformationalVersion()
                        .Enrich.WithAssemblyName()
                        .Enrich.WithAssemblyVersion(true)
                        .Enrich.WithEnvironmentName()
                        .Enrich.WithEnvironmentUserName()
                        //.Enrich.WithMachineName()
                        .Enrich.WithProcessId()
                        .Enrich.WithProcessName()
                        .Enrich.WithMemoryUsage()
                        .Enrich.WithThreadId()
                        .Enrich.WithThreadName()
                        .Enrich.WithSpan(new SpanOptions
                        {
                            IncludeBaggage = true,
                            IncludeTags = true,
                            LogEventPropertiesNames = new SpanLogEventPropertiesNames
                            {
                                TraceId = "traceid"
                            }
                        }) //renamed to let it match with derived fields for OTEL
                        .CreateLogger();
                    builder.Logging.AddSerilog(logger);
                    break;
                }
                case "seq":
                {
                    var logger = new LoggerConfiguration()
                        .ReadFrom.Configuration(builder.Configuration)
                        .WriteTo.Seq("http://localhost:5341")
                        .Enrich.FromLogContext()
                        .Enrich.With(new PropertyEnricher("app", Assembly.GetEntryAssembly()?.GetName().Name!))
                        .Enrich.WithAssemblyInformationalVersion()
                        .Enrich.WithAssemblyName()
                        .Enrich.WithAssemblyVersion(true)
                        .Enrich.WithEnvironmentName()
                        .Enrich.WithEnvironmentUserName()
                        //.Enrich.WithMachineName()
                        .Enrich.WithProcessId()
                        .Enrich.WithProcessName()
                        .Enrich.WithMemoryUsage()
                        .Enrich.WithThreadId()
                        .Enrich.WithThreadName()
                        .Enrich.WithSpan(new SpanOptions
                            { LogEventPropertiesNames = new SpanLogEventPropertiesNames
                            {
                                TraceId = "traceid"
                            } })
                        .CreateLogger();
                    builder.Logging.AddSerilog(logger);
                    break;
                }
                case "otlp":
                {
                    builder.Logging.AddOpenTelemetry(options =>
                    {
                        options.SetResourceBuilder(resourceBuilder);
                        options.AddOtlpExporter(otlpOptions =>
                        {
                            otlpOptions.Protocol = OtlpExportProtocol.HttpProtobuf;
                            otlpOptions.Endpoint =
                                new Uri(builder.Configuration.GetValue<string>("Otlp:Endpoint") + "/v1/logs");
                            otlpOptions.ExportProcessorType = ExportProcessorType.Simple;
                        });
                    });
                    builder.Services.Configure<OpenTelemetryLoggerOptions>(opt =>
                    {
                        opt.IncludeScopes = true;
                        opt.ParseStateValues = true;
                        opt.IncludeFormattedMessage = true;
                    });
                    break;
                }
                default:
                    builder.Logging.AddOpenTelemetry(options =>
                    {
                        options.SetResourceBuilder(resourceBuilder);
                        options.AddConsoleExporter();
                    });
                    builder.Services.Configure<OpenTelemetryLoggerOptions>(opt =>
                    {
                        opt.IncludeScopes = true;
                        opt.ParseStateValues = true;
                        opt.IncludeFormattedMessage = true;
                    });
                    break;
            }
        }
    }
}
