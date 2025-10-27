import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fixed/pages/first.dart';

class Trivia extends StatefulWidget {
  const Trivia({super.key});

  @override
  State<Trivia> createState() => _TriviaState();
}

class _TriviaState extends State<Trivia> {
  String numberFact = '';
  int counter = 1;

  Future<void> fetchNumberFact() async {
    try {
      // final response = http.Response(
      //   'Error with API, retry later or something idk', // body 
      //   204, // status code
      // ); 
      final response = await http
       .get(Uri.parse('http://numbersapi.com/random')) // <-- real API call
       .timeout(const Duration(seconds:2)); // <-- timeout for slow connections
      if (response.statusCode == 200) {
        setState(() {
          numberFact = "HELPPPPP MEEEEE"; //response.body;
        });
      } else {
        setState(() {
          numberFact = "error: couldn't get a fact";
        });
        throw Exception('Failed to load number fact');
      }
    } on TimeoutException { 
      print('The connection has timed out, Please try again!');
      if (!mounted) return; 
      setState(() {
          numberFact = "Request Timed out! ${counter++}";
        });
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e - happened when trying connect to API');
      if (!mounted) return; 
      setState(() {
          numberFact = "Exception on API call.";
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Trivia Page!!!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: fetchNumberFact,
              style: customButtonStyle(),
              child: const Text('Press me!', style: TextStyle(fontWeight: FontWeight.bold))
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                numberFact,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                )
              ),
            ),
            const SizedBox(
              height: 80.0,
            ),
            SizedBox(
              width: 200.0,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                  },
                style: customButtonStyle(),
                child: const Center(
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Go Back'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
