import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts.dart';
import 'package:flutter_application_1/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:provider/provider.dart';

import 'notifier.dart';

class MyHomePage extends StatefulWidget {
  final String cityName;

  const MyHomePage({super.key, required this.cityName});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    _wf.currentWeatherByCityName(widget.cityName).then((w) {
      setState(() {
        _weather = w;
      });
    }).catchError((error) {
      // Show error dialog if weather data fetching fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to fetch weather data.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ${widget.cityName}',
          style:
              const TextStyle(color: Colors.white), // Set text color to white
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF08243C), // AppBar color
        iconTheme: const IconThemeData(
            color: Colors.white), // Set hamburger icon color
        actionsIconTheme:
            const IconThemeData(color: Colors.white), // Set action icon color
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: () {
              Provider.of<SavedCitiesNotifier>(context, listen: false)
                  .saveCity(widget.cityName);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('City saved!')),
              );
            },
          ),
        ],
      ),
      drawer: const Sidebar(),
      body: Container(
        color: Colors.blue, // Fixed blue background for body
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
          _simpleBox(), // Add the simple box here
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
          _extraInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.001,
          ),
        ],
      ),
    );
  }

  Widget _currentTemp() {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add padding inside the box
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Semi-transparent background
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: const Offset(0, 5), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
            style: const TextStyle(
              fontSize: 48.0,
              color: Colors.white, // White text for contrast
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "${_weather?.weatherDescription ?? ''}",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _simpleBox() {
    return Container(
      height:
          MediaQuery.sizeOf(context).height * 0.3, // Adjust height for content
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Semi-transparent background
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 5), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align labels to the top-left
        children: [
          Text(
            "${widget.cityName} Today:", // Dynamic city name
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(), // Add spacing between title and content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_weather?.date != null) ...[
                const Text(
                  "Date of Observation:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat("EEEE, MMMM d, y - hh:mm a")
                      .format(_weather!.date!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
              const SizedBox(height: 8.0),
              if (_weather?.cloudiness != null) ...[
                const Text(
                  "Level of Cloudiness (0-9 Okta):",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${_weather!.cloudiness!.toStringAsFixed(1)} Okta",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
              const SizedBox(height: 8.0),
              if (_weather?.pressure != null) ...[
                const Text(
                  "Pressure (Pascal):",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${_weather!.pressure!.toStringAsFixed(1)} Pa",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Box 1
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Feels Like:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer<TemperatureUnitNotifier>(
                  builder: (context, notifier, child) {
                    final feelsLikeTemp =
                        notifier.unit == TemperatureUnit.celsius
                            ? _weather?.tempFeelsLike?.celsius
                            : _weather?.tempFeelsLike?.fahrenheit;

                    final unitLabel =
                        notifier.unit == TemperatureUnit.celsius ? "C" : "F";

                    return Text(
                      "${feelsLikeTemp?.toStringAsFixed(0)}° $unitLabel",
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 24),
                    );
                  },
                ),
              ],
            ),
          ),
          // Box 2
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Visibility:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Consumer<VisibilityUnitNotifier>(
                  builder: (context, notifier, child) {
                    final visibilityInKm = (_weather?.visibility ?? 0) / 1000;
                    final visibility =
                        notifier.unit == VisibilityUnit.kilometers
                            ? visibilityInKm
                            : visibilityInKm * 0.621371; // Convert to miles

                    final unitLabel = notifier.unit == VisibilityUnit.kilometers
                        ? "KM"
                        : "MI";

                    return Text(
                      "${visibility.toStringAsFixed(2)} $unitLabel",
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 24),
                    );
                  },
                ),
              ],
            ),
          ),

          // Box 3
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Humidity:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 24),
                    "${_weather?.humidity?.toStringAsFixed(0)}%"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
