using System.Diagnostics;
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
using Serilog.Sinks.Grafana.Loki;

namespace TelemetrySampleWeb.Configuration
{
    public static class TelemetryConfigurationExtensions
    {
        internal const string MyApplicationMeterName = "MyApplication";

        public static IServiceCollection AddCustomTracing(this IServiceCollection services,
            IConfiguration configuration, ResourceBuilder resourceBuilder)
        {
            services.AddOpenTelemetryTracing(options =>
            {
                options
                    .SetResourceBuilder(resourceBuilder)
                    .SetSampler(new AlwaysOnSampler())
                    .AddHttpClientInstrumentation()
                    .AddAspNetCoreInstrumentation(instrumentationOptions =>
                    {
                        instrumentationOptions.Enrich = Enrich;
                        instrumentationOptions.RecordException = true;
                    })
                    .AddSource(configuration.GetValue<string>("ServiceName"));
                var tracingExporter = configuration.GetValue<string>("UseTracingExporter").ToLowerInvariant();
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
                        options.AddOtlpExporter(otlpOptions =>
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
            });
            services.Configure<AspNetCoreInstrumentationOptions>(configuration.GetSection("AspNetCoreInstrumentation"));
            return services;

        }

        private static void Enrich(Activity activity, string eventName, object obj)
        {
            if (obj is HttpRequest request)
            {
                var context = request.HttpContext;
                activity.AddTag("http.flavor", GetHttpFlavour(request.Protocol));
                activity.AddTag("http.scheme", request.Scheme);
                activity.AddTag("http.client_ip", context.Connection.RemoteIpAddress);
                activity.AddTag("http.request_content_length", request.ContentLength);
                activity.AddTag("http.request_content_type", request.ContentType);
            }
            else if (obj is HttpResponse response)
            {
                activity.AddTag("http.response_content_length", response.ContentLength);
                activity.AddTag("http.response_content_type", response.ContentType);
            }
        }

        private static string GetHttpFlavour(string protocol)
        {
            if (HttpProtocol.IsHttp10(protocol))
            {
                return "1.0";
            }
            else if (HttpProtocol.IsHttp11(protocol))
            {
                return "1.1";
            }
            else if (HttpProtocol.IsHttp2(protocol))
            {
                return "2.0";
            }
            else if (HttpProtocol.IsHttp3(protocol))
            {
                return "3.0";
            }

            throw new InvalidOperationException($"Protocol {protocol} not recognised.");
        }

        public static WebApplicationBuilder AddCustomLogging(this WebApplicationBuilder builder, 
            IConfiguration configuration, ResourceBuilder resourceBuilder)
        {
            builder.Logging.ClearProviders();
            var logExporter = configuration.GetValue<string>("UseLogExporter").ToLowerInvariant();
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
                        //     filtrationMode:LokiLabelFiltrationMode.Include,
                        //     filtrationLabels:new List<string>{"app"}
                        // )
                        .Enrich.FromLogContext()
                        .Enrich.With(new PropertyEnricher("app", builder.Configuration.GetValue<string>("ServiceName")))
                        .Enrich.WithSpan(new SpanOptions
                            { LogEventPropertiesNames = new SpanLogEventPropertiesNames { TraceId = "traceid" } }) //renamed to let it match with derived fields for OTEL
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
                        .Enrich.With(new PropertyEnricher("app", builder.Configuration.GetValue<string>("ServiceName")))
                        .Enrich.WithSpan(new SpanOptions
                            { LogEventPropertiesNames = new SpanLogEventPropertiesNames { TraceId = "traceid" } })
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
                                new Uri(configuration.GetValue<string>("Otlp:Endpoint") + "/v1/logs");
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

            return builder;
        }

        public static IServiceCollection AddCustomMetrics(this IServiceCollection services,
            IConfiguration configuration, ResourceBuilder resourceBuilder)
        {
            services.AddOpenTelemetryMetrics(options =>
            {
                //var meter = new Meter("MyApplication");

                options.SetResourceBuilder(resourceBuilder)
                    .AddHttpClientInstrumentation()
                    .AddAspNetCoreInstrumentation()
                    .AddMeter("MyApplicationMetrics")
                    .AddMeter(MyApplicationMeterName);

                var metricsExporter = configuration.GetValue<string>("UseMetricsExporter").ToLowerInvariant();
                switch (metricsExporter)
                {
                    case "prometheus":
                        options.AddPrometheusExporter();
                        break;
                    case "otlp":
                        options.AddOtlpExporter(otlpOptions =>
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
            });
            return services;
        }
    }
}
