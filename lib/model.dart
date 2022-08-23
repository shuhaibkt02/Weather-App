class Weather {
  String? cityName;
  double? temperature;
  double? feelslike;
  int? pressure;
  int? humidity;
  double? wind;

  Weather(
      {this.cityName,
      this.feelslike,
      this.pressure,
      this.humidity,
      this.temperature,
      this.wind});

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temperature = json["main"]["temp"];
    feelslike = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    wind = json["wind"]["speed"];
  }
}
