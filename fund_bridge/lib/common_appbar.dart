import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.white,
      elevation: 2,       
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          tooltip: 'Go to Profile',
          onPressed: () {
            Navigator.pushNamed(context, '/Profile');
          },
        ),
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Go to Home',
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    );
  }

  // Required when implementing PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
