import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  @override
  initState() {
    readData().then((value) {
      setState(() {
        count = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('my count value is $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count++;
            saveData(count);
          });
        },
      ),
    );
  }

  saveData(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', count);
  }

  Future<int> readData() async {
    final prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('counter');
    return counter ?? 0;
  }
}
