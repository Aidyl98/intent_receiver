import 'dart:async';

import 'package:flutter/material.dart' hide Intent;
import 'package:intent_receiver/send_data.dart';
import 'package:receive_intent/receive_intent.dart';

void main() {
  runApp(const MyApp());
}

/// Example app widget for the plugin.
class MyApp extends StatefulWidget {
  /// Constructor of MyApp widget.
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Intent? _initialIntent;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final receivedIntent = await ReceiveIntent.getInitialIntent();

    if (!mounted) return;

    setState(() {
      _initialIntent = receivedIntent;
    });
  }

  Widget _buildFromIntent(Intent? intent) {
    SendData data = intent == null || intent.extra == null
        ? SendData(
            package: "", JSON: "")
        : SendData.fromJson(intent.extra!);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Intent Action Name:",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            intent == null || intent.action == null
                ? "Not intent started yet"
                : intent.action!,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Text(
          "Package Received:",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            data.package ?? "No information sent.",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        const Text(
          "JSON Received:",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            data.JSON ?? "No information sent.",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Receive Intent App'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: _buildFromIntent(_initialIntent),
        ),
      ),
    );
  }
}
