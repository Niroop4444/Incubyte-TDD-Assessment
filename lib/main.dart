import 'package:flutter/material.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDD Calculator',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const TDDCalculatorApp(),
    );
  }
}

class TDDCalculatorApp extends StatefulWidget {
  const TDDCalculatorApp({super.key});

  @override
  State<TDDCalculatorApp> createState() => _TDDCalculatorAppState();
}

class _TDDCalculatorAppState extends State<TDDCalculatorApp> {
  final TextEditingController numberFieldController = TextEditingController();

  String additionResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("String Calculator TDD Kata")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: numberFieldController,
                  decoration: InputDecoration(hintText: "Enter the Numbers to be added"),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final calculator = StringCalculator();
                      try {
                        final result = calculator.add(numberFieldController.text);
                        setState(() {
                          additionResult = result.toString();
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text("Add"),
                  ),
                ),

                RichText(
                  text: TextSpan(
                    text: 'Result is : ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: additionResult, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
