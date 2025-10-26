import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle

class Attraction {
  final String name;
  final String description;
  final String url;
  final String alt;

  Attraction({required this.name, required this.description, required this.url, required this.alt});

  // make a contructor that creates an Attraction from a map -----
  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
    name: json['name'] ?? 'no name',
    description: json['description'] ?? 'no game',
    url: json[''] ?? 'no fame', // use pictureUrl for online images
    alt: json['alternatePictureUrl'] ?? 'only shame',
  );
}


Future<List<Attraction>> fetchAttractions() async {
  // loads json as a string
  final jsonString = await rootBundle.loadString('assets/attractions.json');
  
  // decodes the json string into a list of key:element maps (each attraction object)
  final List<dynamic> jsonList = json.decode(jsonString);

  // use constructor instead -----
  List<Attraction> attractions = jsonList.map((jsonMap) => Attraction.fromJson(jsonMap)).toList();
  
  return attractions;


  
  
  // goes through each map in jsonList and looks at each using jsonMap as an iterable
  // then for each of the maps it creates an attraction object by linking the field names
  // List<Attraction> attractions = jsonList.map((jsonMap) {
  //   return Attraction(
  //     name: jsonMap['name'], 
  //     description: jsonMap['description'],
  //     url: jsonMap['pictureUrl'],
  //     alt: jsonMap['alternatePictureUrl'],
  //   );
  // }).toList();

}



class AttractionCard extends StatelessWidget {
  final Attraction attraction;

  const AttractionCard({super.key, required this.attraction});

  @override
  Widget build(BuildContext context) {
    return Card( //could potentially put padding here with child card instead for consistent wrapping.
      elevation: 10.0,
      color: Colors.white,
      child: ListTile(
        title: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.black, width: 4.0),
              ),
              width: 300.0,
              height: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  fit: BoxFit.cover, // potentially BoxFit.cover instead?
                  image: NetworkImage(attraction.url),
                  errorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      'assets/rides/${attraction.alt}',
                      errorBuilder: (context, error, stackTrace) => 
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error),
                          Text('Cannot load', style: TextStyle(fontSize: 8.0)),
                        ],
                      ),
                    ),
                ),
              ),
            ),
            Text(attraction.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text(attraction.description),
          ],
        ),
      ),
    );
  }
}
