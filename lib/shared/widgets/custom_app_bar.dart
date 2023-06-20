import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Icon(
        Icons.savings,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
