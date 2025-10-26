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

  Future<void> fetchNumberFact() async {
    try {
      final response = await http.get(Uri.parse('http://numbersapi.com/random'));
      if (response.statusCode == 200) {
        setState(() {
          numberFact = response.body;
        });
      } else {
        throw Exception('Failed to load number fact');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e - happened when trying connect to API');
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
