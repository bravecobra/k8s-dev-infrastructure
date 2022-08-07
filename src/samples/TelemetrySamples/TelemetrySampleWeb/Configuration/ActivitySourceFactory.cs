using System.Diagnostics;
using System.Reflection;

namespace TelemetrySampleWeb.Configuration;

public static class ActivitySourceFactory
{
    public static ActivitySource CreateActivitySource()
    {
        return new ActivitySource(Assembly.GetEntryAssembly()?.GetName().Name!);
    }
}