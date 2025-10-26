import 'package:flutter/material.dart';

class Fourth extends StatefulWidget {
  const Fourth({super.key});

  @override
  State<Fourth> createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          child: const Center(
            child: Text(
            'Fourht screen',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.red
                ),
              ),
            ),
        );
  }
}