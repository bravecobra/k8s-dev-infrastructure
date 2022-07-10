using System.Diagnostics;
using Microsoft.Extensions.Primitives;

namespace TelemetrySampleWeb.Configuration;

public class LogContextMiddleware
{
    private readonly RequestDelegate _next;

    public LogContextMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public Task InvokeAsync(HttpContext context)
    {
        //Append the TraceID to the response headers
        context.Response.Headers.Add("TraceID", new StringValues(Activity.Current?.TraceId.ToString()));
        return _next(context);
    }
}