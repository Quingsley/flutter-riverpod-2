import 'package:flutter/material.dart';

class FlutterBankMainButton extends StatelessWidget {
  const FlutterBankMainButton({
    super.key,
    this.label,
    this.enabled = true,
    this.onTap,
    this.icon,
    this.iconColor = Colors.white,
    this.labelColor = Colors.white,
  });
  final String? label;
  final bool? enabled;
  final Function? onTap;

  final Color? iconColor;
  final Color? labelColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            color: enabled!
                ? Theme.of(context).colorScheme.primary
                : label == 'Register'
                    ? Colors.grey[200]
                    : Theme.of(context).colorScheme.primary.withOpacity(.2),
            child: InkWell(
              highlightColor: Colors.white.withOpacity(.2),
              splashColor: Colors.white.withOpacity(.1),
              onTap: enabled!
                  ? () {
                      onTap!();
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: icon != null,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Icon(
                          icon,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      label!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: labelColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
