import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit }

class TemperatureUnitNotifier extends ChangeNotifier {
  TemperatureUnit _unit = TemperatureUnit.celsius;

  TemperatureUnit get unit => _unit;

  void toggleUnit(int index) {
    _unit = index == 0 ? TemperatureUnit.celsius : TemperatureUnit.fahrenheit;
    notifyListeners();
  }
}

enum VisibilityUnit { kilometers, miles }

class VisibilityUnitNotifier extends ChangeNotifier {
  VisibilityUnit _unit = VisibilityUnit.kilometers;

  VisibilityUnit get unit => _unit;

  void toggleUnit(int index) {
    _unit = index == 0 ? VisibilityUnit.miles : VisibilityUnit.kilometers;
    notifyListeners();
  }
}

class SavedCitiesNotifier extends ChangeNotifier {
  List<String> _savedCities = [];

  List<String> get savedCities => _savedCities;

  SavedCitiesNotifier() {
    _loadSavedCities();
  }

  Future<void> _loadSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    _savedCities = prefs.getStringList('saved_cities') ?? [];
    notifyListeners();
  }

  Future<void> saveCity(String cityName) async {
    if (!_savedCities.contains(cityName)) {
      _savedCities.add(cityName);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('saved_cities', _savedCities);
      notifyListeners();
    }
  }

  Future<void> removeCity(String cityName) async {
    _savedCities.remove(cityName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_cities', _savedCities);
    notifyListeners();
  }
}

class LanguageNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void toggleLanguage(int index) {
    _locale = (index == 0) ? const Locale('en') : const Locale('es');
    notifyListeners();
  }

  Map<String, String> getLabels() {
    return _locale.languageCode == 'en'
        ? {
            'home': 'Home',
            'search_city': 'Search City',
            'enter_city_name': 'Enter city name',
            'saved_cities': 'Saved Cities',
            'no_saved_cities': 'No saved cities.',
            'set_language': 'Set your language',
            'close': 'Close',
            'cancel': 'Cancel',
            'search': 'Search'
          }
        : {
            'home': 'Inicio',
            'search_city': 'Buscar Ciudad',
            'enter_city_name': 'Ingrese el nombre de la ciudad',
            'saved_cities': 'Ciudades Guardadas',
            'no_saved_cities': 'No hay ciudades guardadas.',
            'set_language': 'Elija su idioma',
            'close': 'Cerrar',
            'cancel': 'Cancelar',
            'search': 'Buscar'
          };
  }
}
