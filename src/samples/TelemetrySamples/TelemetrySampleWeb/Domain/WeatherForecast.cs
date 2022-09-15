namespace TelemetrySampleWeb.Domain
{
    public class WeatherForecast
    {
        public DateTime Date { get; set; }

        public int TemperatureC { get; set; }

        private int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

        public string? Summary { get; set; }

        public override string ToString()
        {
            return $"Forcast: Date {Date}, TemperatureC: {TemperatureC}, TemperatureF: {TemperatureF}, Summary: {Summary}";
        }
    }
}