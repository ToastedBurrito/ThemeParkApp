import 'package:flutter/material.dart';
import 'package:flutter_fixed/basket.dart';
import 'package:flutter_fixed/custom_appbar.dart';
import 'package:flutter_fixed/pages/first.dart';
import 'package:flutter_fixed/pages/second.dart';
import 'package:flutter_fixed/pages/third.dart';
import 'package:flutter_fixed/pages/fourth.dart';
import 'package:flutter_fixed/custom_navbar.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  BasketUtils basketutils = BasketUtils();
  @override
  void initState() {
    super.initState();
    basketutils.resetSharedPreferences();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _selectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const First();
      case 1:
        return const Second();
      case 2:
        return const Third();
      case 3:
        return const Fourth();
      default:
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: const Center(
              child: Text('Default route'),
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation){
        if(orientation == Orientation.portrait){
          return Scaffold(
        appBar: const PortraitAppBar(),
        
        body: _selectedScreen(),
      
        bottomNavigationBar: CustomNav(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
        ),  
      );
        } else{
          return Scaffold(
        appBar: const LandscapeAppBar(),
        body: _selectedScreen(),
      
        bottomNavigationBar: CustomNav(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
        ),  
      );
        }
      }
    );
  }
}
