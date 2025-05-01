import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LedControlApp());
}

class LedControlApp extends StatelessWidget {
  const LedControlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LedControlScreen(),
    );
  }
}

class LedControlScreen extends StatefulWidget {
  const LedControlScreen({Key? key}) : super(key: key);

  @override
  _LedControlScreenState createState() => _LedControlScreenState();
}

class _LedControlScreenState extends State<LedControlScreen> {
  bool _isLedOn = false;

  // Function to toggle LED state
  Future<void> _toggleLed(bool state) async {
    final String url = 'http://192.168.137.179:3000/set-led-state?state=${state ? 1 : 0}';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _isLedOn = state;
        });
      } else {
        // Handle error
        print('Failed to change LED state. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LED Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _isLedOn ? Icons.lightbulb : Icons.lightbulb_outline,
              color: _isLedOn ? Colors.yellow : Colors.grey,
              size: 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _toggleLed(true), // Turn on
              child: const Text('Turn On'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _toggleLed(false), // Turn off
              child: const Text('Turn Off'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
