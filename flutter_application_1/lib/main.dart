import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/notifier.dart'; // Contains all your notifiers
import 'package:flutter_localizations/flutter_localizations.dart'; // Correct localization import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemperatureUnitNotifier()),
        ChangeNotifierProvider(create: (_) => VisibilityUnitNotifier()),
        ChangeNotifierProvider(create: (_) => SavedCitiesNotifier()),
        ChangeNotifierProvider(
            create: (_) => LanguageNotifier()), // Add LanguageNotifier
      ],
      child: Consumer<LanguageNotifier>(
        builder: (context, languageNotifier, child) {
          return MaterialApp(
            locale: languageNotifier.locale, // Use selected locale
            supportedLocales: const [
              Locale('en'), // English
              Locale('es'), // Spanish
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              fontFamily: "Montserrat",
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/home',
            routes: {
              '/home': (context) {
                final args =
                    ModalRoute.of(context)?.settings.arguments as String?;
                return MyHomePage(
                    cityName: args ?? 'Miami'); // Default to Miami
              },
            },
          );
        },
      ),
    );
  }
}
