import 'package:flutter/material.dart';

class PortraitAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PortraitAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150.0,
      centerTitle: true,
      elevation: 100.0,
      backgroundColor: Colors.amber,
      title: const SizedBox(
          height: 150,
          child: CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('assets/RobbieLogoo.png'),
            ),
        ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}


class LandscapeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const LandscapeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
    );
  }

  @override
    Size get preferredSize => const Size.fromHeight(2);
}
