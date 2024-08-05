import 'package:flutter/material.dart';
import '../../../../utilities/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
        backgroundColor: backgroundColor,
      ),
      body: const Center(
        child: Text(
          "Welcome to Home Page",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 99, 99, 99),
          ),
        ),
      ),
    );
  }
}
