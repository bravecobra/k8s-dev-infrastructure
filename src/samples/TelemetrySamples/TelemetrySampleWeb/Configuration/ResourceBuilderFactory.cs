using System.Reflection;
using OpenTelemetry.Resources;

namespace TelemetrySampleWeb.Configuration
{
    public static class ResourceBuilderFactory
    {
        public static ResourceBuilder CreateResourceBuilder(ResourceBuilder resourceBuilder)
        {
            var entryAssembly = Assembly.GetEntryAssembly();
            var entryAssemblyName = entryAssembly?.GetName();
            var versionAttribute = entryAssembly?.GetCustomAttributes(false)
                .OfType<AssemblyInformationalVersionAttribute>()
                .FirstOrDefault();
            var serviceName = entryAssemblyName?.Name ?? "unknown";
            var serviceVersion = versionAttribute?.InformationalVersion ?? entryAssemblyName?.Version?.ToString();
            var attributes = new Dictionary<string, object>
            {
                ["host.name"] = Environment.MachineName,
                ["os.description"] = System.Runtime.InteropServices.RuntimeInformation.OSDescription,
                ["deployment.environment"] = (Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production").ToLowerInvariant()
            };
            resourceBuilder.AddService(serviceName, serviceVersion, serviceInstanceId: Environment.MachineName)
                .AddAttributes(attributes)
                .AddTelemetrySdk()
                .AddEnvironmentVariableDetector();

            return resourceBuilder;

        }
    }
}
