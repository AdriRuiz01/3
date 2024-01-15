import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const _title = 'Shopping List';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            _title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal.shade400,
        ),
        body: Stack(
          children: [
            // Fondo con la imagen
            Positioned.fill(
              child: Image.asset(
                'assets/image/fondo/fondoApp.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const LoginScreen(),
          ],
        ),
      ),
    );
  }
}
