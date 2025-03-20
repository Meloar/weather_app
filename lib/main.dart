import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controller/geolocator/bloc/geolocator_bloc.dart';
import 'package:weather_app/controller/geolocator/data_provider/geolocator_data_provider.dart';
import 'package:weather_app/controller/geolocator/repository/geolocator_repository.dart';
import 'package:weather_app/controller/weather/bloc/weather_bloc.dart';
import 'package:weather_app/controller/weather/data_provider/weather_data_provider.dart';
import 'package:weather_app/controller/weather/repository/weather_repository.dart';
import 'package:weather_app/view/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepository(WeatherDataProvider()),
        ),
        RepositoryProvider(
          create: (context) => GeolocatorRepository(GeolocatorDataProvider()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(context.read<WeatherRepository>()),
          ),
          BlocProvider(
            create:
                (context) =>
                    GeolocatorBloc(context.read<GeolocatorRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const MyHomePage(title: 'Weather App'),
        ),
      ),
    );
  }
}
