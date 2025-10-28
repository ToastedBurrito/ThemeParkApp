import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Ticket {
  final String imageURL;
  final String altURL;
  final String title;
  final String description;
  final double price;

  Ticket({
    required this.imageURL,
    required this.altURL,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      imageURL: json['imageURL'],
      altURL: json['alt'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'imageURL': imageURL,
      'alt': altURL,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}

class BasketUtils {
  static const _key = 'basket';

  static Future<void> addToBasket(Ticket ticket) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> basket = prefs.getStringList(_key) ?? [];
      basket.add(jsonEncode(ticket.toJson()));
      await prefs.setStringList(_key, basket);
      print('Added ${ticket.title}');
    } catch (e) {
      print('Error adding to basket: $e');
      // Handle the error gracefully, e.g., show an error message to the user.
    }
  }

  static Future<List<Ticket>> getBasketItems() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? basket = prefs.getStringList(_key);
      if(basket == null) {
        return [];
      }
      return basket.map((item) => Ticket.fromJson(jsonDecode(item))).toList();
        } catch (e) {
      print('Error getting basket items: $e');
      // Handle the error gracefully, e.g., show an error message to the user.
      return [];
    }
  }
  Future<void> resetSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // This will remove all key-value pairs from SharedPreferences
  }
}