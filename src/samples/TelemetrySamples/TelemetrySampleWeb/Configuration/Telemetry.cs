using System.Diagnostics;

namespace TelemetrySampleWeb.Configuration;

public static class Telemetry
{
    public static ActivitySource CreateActivitySource(IConfiguration configuration)
    {
        return new ActivitySource(configuration.GetValue<string>("ServiceName"));
    }
}