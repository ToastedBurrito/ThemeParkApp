import 'package:flutter/material.dart';
import 'package:flutter_fixed/basket.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late List<Ticket> basketItems = [];

  @override
  void initState() {
    super.initState();
    _loadBasketItems();
  }
  
  Future<void> _loadBasketItems() async {
    try {
      List<Ticket> items = await BasketUtils.getBasketItems();
      setState(() {
        basketItems = items;
      });
    } catch (e) {
      print('Error loading basket items: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
      ),
      body: basketItems.isEmpty
          ? const Center(
              child: Text('No items in the basket'),
            )
          : ListView.builder(
              itemCount: basketItems.length,
              itemBuilder: (context, index) {
                final ticket = basketItems[index];
                return ListTile(
                  leading: Image.network(ticket.imageURL),
                  title: Text(ticket.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticket.description),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${ticket.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              await BasketUtils.removeFromBasket(ticket);
                              //remove from basket button goes here
                              setState((){
                                basketItems.remove(ticket);
                              });
                            },
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
