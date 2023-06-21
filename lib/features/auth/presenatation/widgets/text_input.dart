import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.onChange,
    required this.hintText,
    this.obscureText = false,
    this.focusNode,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final IconData icon;
  final Function(String) onChange;
  final String hintText;
  final bool? obscureText;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
          focusNode: focusNode,
          controller: controller,
          obscureText: obscureText!,
          keyboardType: hintText == 'Email'
              ? TextInputType.emailAddress
              : hintText == 'Amount' || hintText == 'Account Number'
                  ? TextInputType.number
                  : TextInputType.text,
          obscuringCharacter: '*',
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            contentPadding: const EdgeInsets.only(
              left: 20,
              top: 11,
              bottom: 11,
              right: 15,
            ),
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hintText,
          ),
          onChanged: onChange,
          onSubmitted: onSubmitted),
    );
  }
}
