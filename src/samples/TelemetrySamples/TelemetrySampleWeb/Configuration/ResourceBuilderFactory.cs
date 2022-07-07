using System.Reflection;
using OpenTelemetry.Resources;

namespace TelemetrySampleWeb.Configuration
{
    public static class ResourceBuilderFactory
    {
        public static ResourceBuilder CreateResourceBuilder(IConfiguration configuration)
        {
            var serviceName = configuration.GetValue<string>("ServiceName");
            // OpenTelemetry
            var assemblyVersion = Assembly.GetExecutingAssembly().GetName().Version?.ToString() ?? "unknown";
            //var tracingExporter = configuration.GetValue<string>("UseTracingExporter").ToLowerInvariant();

            return ResourceBuilder.CreateDefault().AddService(serviceName, serviceVersion: assemblyVersion, serviceInstanceId: Environment.MachineName)
                .AddTelemetrySdk()
                .AddEnvironmentVariableDetector();

            // var resourceBuilder = tracingExporter switch
            // {
            //     "jaeger" => ResourceBuilder.CreateDefault()
            //         .AddService(configuration.GetValue<string>("ServiceName"), serviceVersion: assemblyVersion, serviceInstanceId: Environment.MachineName)
            //         .AddTelemetrySdk()
            //         .AddEnvironmentVariableDetector(),
            //     "zipkin" => ResourceBuilder.CreateDefault()
            //         .AddService(configuration.GetValue<string>("ServiceName"), serviceVersion: assemblyVersion, serviceInstanceId: Environment.MachineName)
            //         .AddTelemetrySdk()
            //         .AddEnvironmentVariableDetector(),
            //     "otlp" => ResourceBuilder.CreateDefault()
            //         .AddService(configuration.GetValue<string>("ServiceName"), serviceVersion: assemblyVersion, serviceInstanceId: Environment.MachineName)
            //         .AddTelemetrySdk()
            //         .AddEnvironmentVariableDetector()
            //     //.AddAttributes(new[] { new KeyValuePair<string, object>("app", "test-app") })
            //     ,
            //     _ => ResourceBuilder.CreateDefault()
            //         .AddService(serviceName, serviceVersion: assemblyVersion, serviceInstanceId: Environment.MachineName)
            //         .AddTelemetrySdk()
            //         .AddEnvironmentVariableDetector(),
            // };
            // return resourceBuilder;
        }
    }
}
