import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matbook/src/db/data_store.dart';
import 'package:matbook/src/features/home/presentation/home_screen.dart';
import 'package:matbook/src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Klasa, w której są operacje związane z Hive
  final dataStore = DataStore();
  // inicjacja Hive i boxów
  await dataStore.init();
  runApp(
    ProviderScope(
      overrides: [
        // w związku z tym, że dataStore musi być utworzone zanim inna klasa
        // pobrałaby jej referencję z providera Riverpod nadpisujemy ten obiekt
        // w tym miejscu obiektem utworzonym w metodzie main()
        dataStoreProvider.overrideWithValue(dataStore),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Theming.getLightThemeFromFlexColor(),
      themeMode: ThemeMode.dark,
      darkTheme: Theming.getDarkThemeFromFlexColor(),
      home: const HomeScreen(),
    );
  }
}
