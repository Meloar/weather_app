import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.temperature,
    required this.sky,
    required this.pressure,
    required this.windSpeed,
    required this.humidity,
    this.nap,
  });

  final double temperature;
  final String sky;
  final double pressure;
  final double windSpeed;
  final double humidity;
  final int? nap;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<String> napok = [
      'Hétfő',
      'Kedd',
      'Szerda',
      'Csütörtök',
      'Péntek',
      'Szombat',
      'Vasárnap',
    ];
    return Card(
      elevation: 5,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$temperature C°',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Image.network('https://openweathermap.org/img/wn/$sky@2x.png'),
            Text('Légnyomás: ${pressure.toInt()}'),
            Text('Szélsebesség: $windSpeed'),
            Text('Pára: ${humidity.toInt()}'),
            SizedBox(height: 10),
            if (nap != null)
              Text(
                napok[now.weekday + nap! > 6
                    ? now.weekday + nap! - 7
                    : now.weekday + nap!],
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
