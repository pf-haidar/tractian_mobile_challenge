import 'package:flutter/material.dart';
import 'package:tractian_mobile_challange/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assets Managment',
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
          horizontalTitleGap: 6,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(23, 25, 45, 1),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color.fromRGBO(23, 25, 45, 1),
        // ),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
