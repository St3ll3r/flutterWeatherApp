import 'package:flutter/material.dart';
import 'package:flutter_application_1/notifier.dart'; // Import your notifier
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<LanguageNotifier>(context)
        .getLabels(); // Fetch dynamic labels

    return Drawer(
      child: Container(
        color: const Color(0xFF08243C), // Set the background color to #08243C
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0A3A5D), // Optional: darker shade for header
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Elemental",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: Text(labels['home']!,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.search, color: Colors.white),
              title: Text(labels['search_city']!,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                _showSearchCityDialog(
                    context, labels); // Open Search City Dialog
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark, color: Colors.white),
              title: Text(labels['saved_cities']!,
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<SavedCitiesNotifier>(
                      builder: (context, notifier, _) {
                        return AlertDialog(
                          title:
                              Text(labels['saved_cities']!), // Localized title
                          content: notifier.savedCities.isEmpty
                              ? Text(labels[
                                  'no_saved_cities']!) // Localized empty message
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: notifier.savedCities.map((city) {
                                    return ListTile(
                                      title: Text(city),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          notifier.removeCity(city);
                                        },
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/home',
                                          arguments: city,
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                  labels['close']!), // Localized Close button
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
            const Divider(
              color: Colors.white, // Divider color
              thickness: 1.0, // Thickness of the divider
              indent: 16.0, // Optional: Add margin to the left
              endIndent: 16.0, // Optional: Add margin to the right
            ),
            Column(
              children: [
                ToggleSwitch(
                  initialLabelIndex: 0, // Default selection
                  totalSwitches: 2, // Number of switches
                  labels: const ['C°', 'F°'], // Switch labels
                  activeBgColor: const [
                    Colors.blue
                  ], // Active switch background color
                  activeFgColor: Colors.white, // Active switch text color
                  inactiveBgColor:
                      Colors.grey.shade800, // Inactive switch background color
                  inactiveFgColor: Colors.white, // Inactive switch text color
                  minWidth: 90.0, // Minimum width per button
                  cornerRadius: 20.0, // Optional: Add rounded corners
                  onToggle: (index) {
                    Provider.of<TemperatureUnitNotifier>(context, listen: false)
                        .toggleUnit(index!);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleSwitch(
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: const ['MI', 'KM'], // Distance unit labels
                  activeBgColor: const [Colors.blue],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade800,
                  inactiveFgColor: Colors.white,
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  onToggle: (index) {
                    Provider.of<VisibilityUnitNotifier>(context, listen: false)
                        .toggleUnit(index!);
                  },
                ),
                const Divider(
                  color: Colors.white, // Divider color
                  thickness: 1.0, // Thickness of the divider
                  indent: 16.0, // Optional: Add margin to the left
                  endIndent: 16.0, // Optional: Add margin to the right
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    labels['set_language']!, // Localized Set Language text
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ToggleSwitch(
                  initialLabelIndex: Provider.of<LanguageNotifier>(context)
                              .locale
                              .languageCode ==
                          'en'
                      ? 0
                      : 1,
                  totalSwitches: 2,
                  labels: const ['English', 'Spanish'], // Language labels
                  activeBgColor: const [Colors.blue],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey.shade800,
                  inactiveFgColor: Colors.white,
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  onToggle: (index) {
                    Provider.of<LanguageNotifier>(context, listen: false)
                        .toggleLanguage(index!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchCityDialog(BuildContext context, Map<String, String> labels) {
    final TextEditingController cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(labels['search_city']!), // Localized title
          content: TextField(
            controller: cityController,
            decoration: InputDecoration(hintText: labels['enter_city_name']),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(labels['cancel']!), // Localized Cancel button
            ),
            TextButton(
              onPressed: () {
                final city = cityController.text.trim();
                if (city.isNotEmpty) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                    arguments: city,
                  );
                }
              },
              child: Text(labels['search']!), // Localized Search button
            ),
          ],
        );
      },
    );
  }
}
