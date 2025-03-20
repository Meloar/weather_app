import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controller/geolocator/bloc/geolocator_bloc.dart';
import 'package:weather_app/controller/weather/bloc/weather_bloc.dart';
import 'package:weather_app/view/widgets/weather_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String cityName;
  final cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GeolocatorBloc>().add(GeolocatorFetched());
  }

  @override
  void dispose() {
    super.dispose();
    cityController.dispose();
  }

  void getCityWeather(String newCityName) {
    context.read<WeatherBloc>().add(
      WeatherFetchedByLocation(cityName: newCityName),
    );
    cityName = newCityName;
    cityController.clear();
  }

  void refreshWeatherData() {
    context.read<WeatherBloc>().add(
      WeatherFetchedByLocation(cityName: cityName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Weather App',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: refreshWeatherData,
          ),
        ],
      ),
      body: BlocListener<GeolocatorBloc, GeolocatorState>(
        listener: (context, state) {
          if (state is GeolocatorSuccess) {
            context.read<WeatherBloc>().add(
              WeatherFetchedByLocation(cityName: state.currentLocation),
            );
            cityName = state.currentLocation;
          }
        },
        child: BlocBuilder<GeolocatorBloc, GeolocatorState>(
          builder: (context, state) {
            if (state is GeolocatorFailure) {
              return Center(child: Text(state.error));
            }
            if (state is! GeolocatorSuccess) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherFailure) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: cityController,
                          decoration: InputDecoration(
                            hintText: 'Írj be egy város nevét!',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () => getCityWeather(cityController.text),
                        child: Text('Lekérdezés'),
                      ),
                    ],
                  );
                }
                if (state is! WeatherSuccess) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mai időjárás',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              cityName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: WeatherCard(
                            temperature: state.weatherModelList[0].temperature,
                            sky: state.weatherModelList[0].icon,
                            pressure: state.weatherModelList[0].pressure,
                            windSpeed: state.weatherModelList[0].windSpeed,
                            humidity: state.weatherModelList[0].humidity,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Heti előrejelzés',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.weatherModelList.length - 1,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: WeatherCard(
                                  temperature:
                                      state
                                          .weatherModelList[index + 1]
                                          .temperature,
                                  sky: state.weatherModelList[index + 1].icon,
                                  pressure:
                                      state
                                          .weatherModelList[index + 1]
                                          .pressure,
                                  windSpeed:
                                      state
                                          .weatherModelList[index + 1]
                                          .windSpeed,
                                  humidity:
                                      state
                                          .weatherModelList[index + 1]
                                          .humidity,
                                  nap: index,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Column(
                            children: [
                              TextField(
                                controller: cityController,

                                decoration: InputDecoration(
                                  hintText: 'Írj be egy város nevét!',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              ElevatedButton(
                                onPressed:
                                    () => getCityWeather(cityController.text),
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.black,
                                ),

                                child: Text('Lekérdezés'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
