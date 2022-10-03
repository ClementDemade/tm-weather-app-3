import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';
import 'package:weather_app_3/views/weather_home.dart';

void main() async {
  await initIntlAndLocale();
  runApp(const MyApp());
}

Future<void> initIntlAndLocale() async {
  Intl.defaultLocale = 'fr_FR';
  await findSystemLocale();
  await initializeDateFormatting(Intl.defaultLocale!, null);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const WeatherHome(),
    );
  }
}
