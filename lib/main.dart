import 'package:fakestore_dhyonemolina/src/pages/error_page.dart';
import 'package:fakestore_dhyonemolina/src/pages/home_page.dart';
import 'package:fakestore_dhyonemolina/src/pages/products/favorites_page.dart';
import 'package:fakestore_dhyonemolina/src/pages/products/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromRGBO(255, 255, 255, 1),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromRGBO(240,241,242,100),
        ),
      ),
      routes: {
        '/': (context) => const ErrorPage(),
        '/home_products': (context) => const HomePage(),
        '/product': (context) => const ProductsPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/error': (context) => const ErrorPage(),
      }
    );
  }
}
