using System.Reflection;
using OpenTelemetry.Resources;

namespace TelemetrySampleWeb.Configuration
{
    public static class ResourceBuilderFactory
    {
        public static ResourceBuilder CreateResourceBuilder(WebApplicationBuilder builder)
        {
            var entryAssembly = Assembly.GetEntryAssembly();
            var entryAssemblyName = entryAssembly?.GetName();
            var versionAttribute = entryAssembly?.GetCustomAttributes(false)
                .OfType<AssemblyInformationalVersionAttribute>()
                .FirstOrDefault();
            var serviceName = entryAssemblyName?.Name;
            var serviceVersion = versionAttribute?.InformationalVersion ?? entryAssemblyName?.Version?.ToString();
            var attributes = new Dictionary<string, object>
            {
                ["host.name"] = Environment.MachineName,
                ["os.description"] = System.Runtime.InteropServices.RuntimeInformation.OSDescription,
                ["deployment.environment"] = builder.Environment.EnvironmentName.ToLowerInvariant()
            };

            return ResourceBuilder.CreateDefault()
                .AddService(serviceName, serviceVersion, serviceInstanceId: Environment.MachineName)
                .AddAttributes(attributes)
                .AddTelemetrySdk()
                .AddEnvironmentVariableDetector();
        }
    }
}
