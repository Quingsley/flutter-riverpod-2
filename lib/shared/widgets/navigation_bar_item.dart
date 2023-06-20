import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onPress;
  final bool isSelected;
  const BottomBarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPress,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          100,
        ),
      ),
      onPressed: onPress,
      minWidth: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
