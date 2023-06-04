import 'package:alpha/core/app_route.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('home-screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushNamed(context, AppRoute.spendingScreen);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
