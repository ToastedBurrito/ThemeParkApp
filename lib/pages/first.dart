import 'package:flutter/material.dart';
import 'package:flutter_fixed/pages/checkout.dart';
import 'package:flutter_fixed/pages/trivia.dart';


class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            'Welcome to the Home Screen!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20), // Add spacing between text and buttons
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Text(
            "Welcome to Robbie's Rodeo, where adventure awaits at every turn! Nestled in the heart of the Wild West, our theme park offers an unforgettable experience for thrill-seekers of all ages.",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20), // Add spacing between description and buttons
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add onPressed logic for the first button
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BasketScreen()),
                    );
                  },
                  style: customButtonStyle(),
                  child: const Text('Checkout'),
                ),
                const SizedBox(width: 40), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Add onPressed logic for the second button
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Trivia()),
                    );
                  },
                  style: customButtonStyle(),
                  child: const Text('Trivia'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

ButtonStyle customButtonStyle() {
    return ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Change the background color of the button
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Adjust the padding to increase the button size
                  textStyle: const TextStyle(fontSize: 20), // Adjust the text size
                );
  }
