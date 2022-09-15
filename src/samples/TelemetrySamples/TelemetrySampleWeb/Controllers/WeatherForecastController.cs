using System.Diagnostics;
using System.Diagnostics.Metrics;
using Microsoft.AspNetCore.Mvc;
using TelemetrySampleWeb.Configuration;
using TelemetrySampleWeb.Domain;

namespace TelemetrySampleWeb.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] Summaries = {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;
        private readonly IConfiguration _configuration;
        private static readonly HttpClient HttpClient = new();

        public WeatherForecastController(ILogger<WeatherForecastController> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        [HttpGet(Name = "GetWeatherForecast")]
        public async Task<IEnumerable<WeatherForecast>> Get()
        {
            using var scope = _logger.BeginScope("{Id}", Guid.NewGuid().ToString("N")); //Adding a LogScope
            // Making an http call here to serve as an example of
            // how dependency calls will be captured and treated
            // automatically as child of incoming request.
            _logger.LogInformation($"Starting with {nameof(WeatherForecastController)}");

            //Adding some metrics
            var meter = new Meter(TelemetryConfigurationExtensions.MyApplicationMeterName);
            
            meter.CreateObservableGauge("ThreadCount", () => new[] { new Measurement<int>(ThreadPool.ThreadCount) });

            //Count the requests to GetWeatherForecast
            var counter = meter.CreateCounter<int>("Requests");
            counter.Add(1, KeyValuePair.Create<string, object?>("name", "GetWeatherForecast"));

            // Measure the duration in ms of requests and includes the host in the tags
            var histogram = meter.CreateHistogram<float>("RequestDuration", unit: "ms");
            var stopwatch = Stopwatch.StartNew();
            var res = HttpClient.GetStringAsync("http://google.com").Result;
            stopwatch.Stop();
            histogram.Record(stopwatch.ElapsedMilliseconds, tag: KeyValuePair.Create<string, object?>("Host", "google.com"));

            //Adding extra Activity/Span       
            using (var activity = ActivitySourceFactory.CreateActivitySource().StartActivity(nameof(Get)))
            {
                activity?.SetTag("foo", "foo");
                activity?.SetTag("bar", "bar");
                await StepOne();
                activity?.AddEvent(new ActivityEvent("Part way there"));
                await StepTwo();
                activity?.AddEvent(new ActivityEvent("Done now"));
            }

            //Providing a Forecast response
            var forecast=  Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateTime.Now.AddDays(index),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            }).ToArray();

            _logger.LogInformation(
                "WeatherForecasts generated {count}: {forecasts}",
                forecast.Length,
                forecast);
            return forecast;
        }

        [HttpGet("/except", Name = "ThrowException")]
        public IActionResult ThrowException()
        {
            throw new ArgumentException("This is a custom AppException");
        }

        static async Task StepOne()
        {
            await Task.Delay(200);
        }

        static async Task StepTwo()
        {
            await Task.Delay(100);
        }
    }
}