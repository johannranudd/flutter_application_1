class WeatherModel {
  final String tempC;
  final String weatherDescription;
  final String uvIndex;

  WeatherModel({
    required this.tempC,
    required this.weatherDescription,
    required this.uvIndex,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final currentCondition = json['data']['current_condition'][0];
    return WeatherModel(
      tempC: currentCondition['temp_C'],
      weatherDescription: currentCondition['weatherDesc'][0]['value'],
      uvIndex: currentCondition['uvIndex'].toString(),
    );
  }
}
