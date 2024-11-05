import 'package:bleach/core/api.dart';
import 'package:bleach/model/weather_model.dart';
import 'package:flutter/material.dart';

class EgScreen extends StatefulWidget {
  const EgScreen({super.key});

  @override
  State<EgScreen> createState() => _EgScreenState();
}

class _EgScreenState extends State<EgScreen> {
  WeatherModel? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator(),
              if (_errorMessage != null)
                Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              if (_weatherData != null)
                _buildWeatherInfo(_weatherData!), // Display weather info
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SearchBar(
      hintText: 'Search location',
      onSubmitted: (value) {
        _getWeatherData(value);
      },
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      _isLoading = true; // Set loading state to true
      _errorMessage = null; // Clear previous error messages
    });

    try {
      WeatherModel response = await WeatherApi().getCurrentWeatherLocation(location);
      setState(() {
        _weatherData = response; // Save the fetched weather data
        _isLoading = false; // Set loading state to false
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading state to false
        _errorMessage = e.toString(); // Store the error message
      });
    }
  }

  Widget _buildWeatherInfo(WeatherModel weatherData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location: ${weatherData.location!.name}', style: TextStyle(fontSize: 18)),
        Text('Temperature: ${weatherData.current!.tempC} °C', style: TextStyle(fontSize: 18)),
        Text('Condition: ${weatherData.current!.condition!.text}', style: TextStyle(fontSize: 18)),
        Image.network(
          'https:${weatherData.current!.condition?.icon ?? ''}',
          width: 64, // Set the width as per your design
          height: 64, // Set the height as per your design
          errorBuilder: (context, error, stackTrace) {
            return Text('Icon not available');
          },
        ),
      ],
    );
  }
}