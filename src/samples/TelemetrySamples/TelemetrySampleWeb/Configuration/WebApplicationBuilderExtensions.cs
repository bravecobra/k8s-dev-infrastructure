using System.Diagnostics;
using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Diagnostics;

namespace TelemetrySampleWeb.Configuration
{
    public static class WebApplicationBuilderExtensions
    {
        public static WebApplication UseCustomErrorhandling(this WebApplication app)
        {
            app.UseExceptionHandler(appError =>
            {
                appError.Run(async context =>
                {
                    context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                    context.Response.ContentType = "application/json";
                    var contextFeature = context.Features.Get<IExceptionHandlerFeature>();
                    if (contextFeature != null)
                    {
                        await context.Response.WriteAsync(JsonSerializer.Serialize(new
                        {
                            StatusCode = context.Response.StatusCode,
                            Message = contextFeature.Error.Message,
                            TraceID = Activity.Current?.TraceId.ToString(),
                            // Exception = new
                            // {
                            //     Stacktrace = contextFeature.Error.StackTrace,
                            //     InnerTrace = contextFeature.Error.InnerException?.ToString()
                            // }
                        }));
                    }
                });
            });
            return app;
        }
    }
}
