// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/consts.dart';
// import 'package:intl/intl.dart';
// import 'package:weather/weather.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

//   Weather? _weather;

//   @override
//   void initState() {
//     super.initState();
//     _wf.currentWeatherByCityName("Miami").then((w) {
//       setState(() {
//         _weather = w;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildUI(),
//     );
//   }

//   Widget _buildUI() {
//     if (_weather == null) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     return SizedBox(
//       width: MediaQuery.sizeOf(context).width,
//       height: MediaQuery.sizeOf(context).height,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           _locationHeader(),
//           SizedBox(
//             height: MediaQuery.sizeOf(context).height * 0.20,
//           ),
//           _currentTemp(),
//           SizedBox(
//             height: MediaQuery.sizeOf(context).height * 0.02,
//           ),
//           _weatherIcon(),
//           SizedBox(
//             height: MediaQuery.sizeOf(context).height * 0.02,
//           ),
//           _dateTimeInfo(),
//           SizedBox(
//             height: MediaQuery.sizeOf(context).height * 0.05,
//           ),
//           _extraInfo(),
//         ],
//       ),
//     );
//   }

//   Widget _locationHeader() {
//     return Text(_weather?.areaName ?? "",
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w500,
//         ));
//   }

//   Widget _dateTimeInfo() {
//     DateTime now = _weather!.date!;
//     return Column(
//       children: [
//         Text(
//           DateFormat("h:mm a").format(now),
//           style: const TextStyle(
//             fontSize: 35,
//           ),
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               DateFormat("EEEE").format(now),
//               style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Text(
//               "  ${DateFormat("d.m.y").format(now)}",
//               style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }

//   Widget _weatherIcon() {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: MediaQuery.sizeOf(context).height * 0.20,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
//         ),
//       ],
//     );
//   }

//   Widget _currentTemp() {
//     return Column(
//       mainAxisSize:
//           MainAxisSize.min, // Keeps the column only as large as its content
//       children: [
//         // Existing Temperature Text
//         Text(
//           "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
//           style: const TextStyle(
//             fontSize: 18.0, // Set font size for temperature text
//             color: Colors.black87, // Optional: Set text color
//           ),
//         ),
//         const SizedBox(
//             height: 8.0), // Adds some space between temperature and "Hello"

//         // New "Hello" Text Below
//         Text(
//           "${_weather?.weatherDescription}",
//           style: const TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _extraInfo() {
//     return Container(
//       height: MediaQuery.sizeOf(context).height * 0.15,
//       width: MediaQuery.sizeOf(context).width * 0.80,
//       decoration: BoxDecoration(
//         color: Colors.deepPurpleAccent,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Box 1
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Feels Like:",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text(
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w800, fontSize: 24),
//                     "${_weather?.tempFeelsLike?.celsius?.toStringAsFixed(0)}° C"),
//               ],
//             ),
//           ),
//           // Box 2
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       const Text("Visibility:",
//             //           style: TextStyle(fontWeight: FontWeight.bold)),
//             //   //     Text(
//             //   //         style: const TextStyle(
//             //   //             fontWeight: FontWeight.w800, fontSize: 24),
//             //   //         // "${(_weather?.visibility ?? 0) / 1000} KM"),
//             //   //   ],
//             //   // ),
//           ),
//           // Box 3
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Humidity:",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text(
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w800, fontSize: 24),
//                     "${_weather?.humidity?.toStringAsFixed(0)}%"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherFactory _wf = WeatherFactory(
      'f00262333177a34dd2798285ffac2099'); // Replace with your API key

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Davie").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundImage(),
          if (_weather == null)
            const Center(child: CircularProgressIndicator())
          else
            _weatherContent(),
        ],
      ),
    );
  }

  Widget _backgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D47A1), // Deep blue at the top
            Color(0xFF283593), // Slightly lighter blue in the middle
            Color(0xFF1A237E), // Dark blue at the bottom
          ],
        ),
      ),
    );
  }

  Widget _weatherContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            const SizedBox(height: 35),
            _currentTemperature(),
            const SizedBox(height: 50),
            _hourlyForecast(),
            const SizedBox(height: 25),
            _additionalDetails(),
            const SizedBox(height: 25),
            _WindDetails(
              windSpeed: _weather?.windSpeed ?? 0.0,
              windDegree: _weather?.windDegree ?? 0.0,
              windGust: _weather?.windGust ?? 0.0,
            ),
            const SizedBox(height: 25),
            _weeklyForecast(),
          ],
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      child: Text(
        "${_weather?.areaName ?? "Davie"}, Florida",
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _currentTemperature() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? "--"}°C",
              style: const TextStyle(
                fontSize: 64,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              _weather?.weatherDescription?.toUpperCase() ??
                  "Cloudy, Expected Rain",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hourlyForecast() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _HourlyWeatherCard("Now", "", "25°"),
          _HourlyWeatherCard("10 PM", "", "24°"),
          _HourlyWeatherCard("11 PM", "", "23°"),
          _HourlyWeatherCard("12 PM", "", "23°"),
        ],
      ),
    );
  }

  Widget _additionalDetails() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoBox("Feels like",
              "${_weather?.tempFeelsLike?.celsius?.toStringAsFixed(0) ?? "--"}°C"),
          // _infoBox("Visibility", "${(_weather?.visibility ?? 0) / 1000} Mi"),
          _infoBox(
              "Humidity", "${_weather?.humidity?.toStringAsFixed(0) ?? "--"}%"),
        ],
      ),
    );
  }

  Widget _weeklyForecast() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _DayForecast("30°", "Today"),
          _DayForecast("29°", "Sept. 9"),
          _DayForecast("32°", "Sept. 10"),
          _DayForecast("33°", "Sept. 11"),
          // _ViewMoreButton(),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _HourlyWeatherCard extends StatelessWidget {
  final String time;
  final String iconPath;
  final String temp;

  const _HourlyWeatherCard(this.time, this.iconPath, this.temp);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Image.asset(iconPath, height: 40),
        const SizedBox(height: 8),
        Text(
          temp,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}

class _DayForecast extends StatelessWidget {
  final String temp;
  final String date;

  const _DayForecast(this.temp, this.date);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          temp,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}

class _WindDetails extends StatelessWidget {
  final double windSpeed;
  final double windDegree;
  final double windGust;

  _WindDetails(
      {required this.windSpeed,
      required this.windDegree,
      required this.windGust});

  String _getWindDirection(double degree) {
    if (degree >= 337.5 || degree < 22.5) return "N";
    if (degree >= 22.5 && degree < 67.5) return "NE";
    if (degree >= 67.5 && degree < 112.5) return "E";
    if (degree >= 112.5 && degree < 157.5) return "SE";
    if (degree >= 157.5 && degree < 202.5) return "S";
    if (degree >= 202.5 && degree < 247.5) return "SW";
    if (degree >= 247.5 && degree < 292.5) return "W";
    if (degree >= 292.5 && degree < 337.5) return "NW";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    String windDirection = _getWindDirection(windDegree);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Wind Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Speed",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$windSpeed m/s",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Direction",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    windDirection,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Gusts",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${windGust!.toStringAsFixed(1)} m/s",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// class _ViewMoreButton extends StatelessWidget {
//   const _ViewMoreButton();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: const Text(
//         "View more",
//         style: TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     );
//   }
// }
