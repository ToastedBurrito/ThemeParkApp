import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fixed/basket.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class Third extends StatefulWidget {
  const Third({super.key});

  @override
  State<Third> createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  late List<Map<String, dynamic>> tickets = [];


  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();
  //something to show the snackbar

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    try {
      String jsonData = await rootBundle.loadString('assets/tickets.json');
      tickets = jsonDecode(jsonData).cast<Map<String, dynamic>>();
      setState(() {});
    } catch (e) {
      print('Error loading tickets: $e');
    }
  }

  void _addToBasket(Ticket ticket) async {
    await BasketUtils.addToBasket(ticket);
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('${ticket.title} added to basket'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      //for the snackbar ^^

      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: tickets.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticketData = Ticket.fromJson(tickets[index]); // same as below but much much neater
                // final ticket = tickets[index];
                // final ticketData = Ticket(
                //   imageURL: ticket['imageURL'],
                //   altURL: ticket['alt'],
                //   title: ticket['title'],
                //   description: ticket['description'],
                //   price: ticket['price'],
                // );

                return ListTile(
                  leading: Image.network(
                    ticketData.imageURL, width: 50, height: 50, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/tickets/${ticketData.altURL}", width: 50, height: 50, fit: BoxFit.cover),
                    loadingBuilder: (context, child, loadingProgress) => 
                      loadingProgress == null ? child : CircularProgressIndicator(),
                  ), 
                  title: Text(ticketData.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ticketData.description),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${ticketData.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _addToBasket(ticketData);
                            },
                            child: const Text('Add'),
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
