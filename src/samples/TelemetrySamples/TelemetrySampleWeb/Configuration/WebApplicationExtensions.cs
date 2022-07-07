namespace TelemetrySampleWeb.Configuration
{
    public static class WebApplicationExtensions
    {
        public static WebApplication AddMetricsEndpoint(this WebApplication app)
        {
            var metricsExporter = app.Configuration.GetValue<string>("UseMetricsExporter").ToLowerInvariant();

            if (metricsExporter == "prometheus")
            {
                app.UseOpenTelemetryPrometheusScrapingEndpoint();
            }
            return app;
        }
    }
}
