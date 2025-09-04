import deployment.WeatherAPI;

final WeatherAPI:Client weatherapiClient = check new ({key: apiKey}, serviceUrl = weatherURL);