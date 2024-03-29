using OpenTelemetry.Resources;
using TelemetrySampleWeb.Configuration;

namespace TelemetrySampleWeb
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            //If your application is targeting .NET Core 3.1, and you are using an insecure (HTTP) endpoint,
            //the following switch must be set before adding OtlpExporter.
            AppContext.SetSwitch("System.Net.Http.SocketsHttpHandler.Http2UnencryptedSupport", true); 
            var builder = WebApplication.CreateBuilder(args);
            var resourceBuilder = ResourceBuilderFactory.CreateResourceBuilder(ResourceBuilder.CreateDefault());
            // Add Logging
            builder.AddCustomLogging(resourceBuilder);
            // Add Traces
            builder.Services.AddCustomTelemetry(builder.Configuration, resourceBuilder);

            builder.Services.AddHealthChecks();

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();
            app.UseMiddleware<LogContextMiddleware>();
            app.UseCustomErrorhandling();

            app.UseSwagger();
            app.UseSwaggerUI();

            app.UseRouting();
            app.UseAuthorization();

            app.MapHealthChecks("/health/startup");
            app.MapHealthChecks("/healthz");
            app.MapHealthChecks("/ready");
            app.MapControllers();

            app.AddMetricsEndpoint();
            app.Run();
        }
    }
}