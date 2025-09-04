import ballerina/log;
import deployment.WeatherAPI;

public function main() returns error? {
    // Get current weather for London
    WeatherAPI:inline_response_200 weatherResponse = check weatherapiClient->/current\.json(q = "London");
    
    // Extract location and current weather information
    WeatherAPI:location? location = weatherResponse.location;
    WeatherAPI:current? current = weatherResponse.current;
    
    if location is WeatherAPI:location && current is WeatherAPI:current {
        string locationName = location.name ?: "Unknown";
        string country = location.country ?: "Unknown";
        string region = location.region ?: "Unknown";
        decimal tempC = current.temp_c ?: 0.0;
        decimal tempF = current.temp_f?: 0.0;
        string conditionText = current.condition?.text ?: "Unknown";
        decimal humidity = current.humidity ?: 0.0;
        decimal windKph = current.wind_kph ?: 0.0;
        string windDir = current.wind_dir ?: "Unknown";
        
        // Log the weather information
        log:printInfo(string `Weather in ${locationName}, ${region}, ${country}:`);
        log:printInfo(string `Temperature: ${tempC}°C (${tempF}°F)`);
        log:printInfo(string `Condition: ${conditionText}`);
        log:printInfo(string `Humidity: ${humidity}%`);
        log:printInfo(string `Wind: ${windKph} km/h ${windDir}`);
    } else {
        log:printError("Failed to retrieve weather data for London");
    }
}