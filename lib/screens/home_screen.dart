import 'dart:async';

import 'package:bleach/core/api.dart';
import 'package:bleach/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../common/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  WeatherModel? weatherModel;
  bool isLoading = false;
  String? errorMessage;

  /// For search bar
  TextEditingController searchController = TextEditingController();

  /// Timer for error message
  Timer? errorTimer;

  /// For background color
  List<Color> pallete = [
    const Color(0xFFFFA500),
    const Color(0xFF8A2BE2).withOpacity(0.6),
    const Color(0xFF000000),
  ];

  /// Function to get weather data
  getWeatherData(String location) async{
    isLoading = true;
    errorMessage = null;
    weatherModel = null;
    errorTimer?.cancel();
    setState(() {
    });

    try{
      WeatherModel model = await WeatherApi().getCurrentWeatherLocation(location);
      weatherModel = model;
      isLoading = false;
      setState(() {

      });
    } catch (e){
      isLoading = false;
      errorMessage = e.toString();
      errorTimer = Timer(const Duration(seconds: 5), () {
        errorMessage = null;
      },);
      setState(() {

      });
    }
  }

  /// Function to show weather data
  buildWeatherInfo(WeatherModel weatherModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(weatherModel.location.name,
                style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white
                )),
            Column(
              children: [
                Text('${weatherModel.current.tempC} °C',
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white
                    )),
                Image.network(
                  'https:${weatherModel.current.condition.icon}',
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image not available');
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: h*0.05),
        Text(weatherModel.current.condition.text,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white
            )),
        Text('Region: ${weatherModel.location.region}',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            )),
        Text('Country: ${weatherModel.location.country}',
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white
            )),
        SizedBox(height: h*0.05),
        Container(
          height: h*0.4,
          width: w*0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w*0.02),
            color: Colors.grey.withOpacity(0.4)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textRow('Feels like', '${weatherModel.current.feelsLikeC}%'),
              textRow('Humidity', '${weatherModel.current.humidity}%'),
              textRow('Wind Speed', '${weatherModel.current.windKph}%'),
              textRow('Wind Direction', '${weatherModel.current.windDir}%'),
              textRow('UV Index', '${weatherModel.current.uv}%'),
              textRow('Visibility', '${weatherModel.current.visibilityKm}%'),
              textRow('Pressure', '${weatherModel.current.pressureMb}%'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: h*0.05,
            left: w*0.02,
            right: w*0.02
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: pallete,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on),
                  hintText: "Search your location",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (value) {
                  getWeatherData(value);
                },
              ),
              SizedBox(height: h*0.05),
              Column(
                children: [
                  if(searchController.text.isEmpty)
                  Lottie.asset("assets/lottie/Animation - 1730812983846.json"),
                  if(searchController.text.isEmpty)
                  const Text("Search your location....",style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60
                  ),),
                  if(isLoading)
                    buildShimmer(),
                  if(errorMessage !=null)
                    Center(
                        child: Text(errorMessage!,style: const TextStyle(
                          color: Colors.white
                        ))),
                  if(weatherModel != null)
                    buildWeatherInfo(weatherModel!)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
