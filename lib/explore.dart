import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 35.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
