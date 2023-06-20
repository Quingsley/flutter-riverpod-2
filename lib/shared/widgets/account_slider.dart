import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSlider extends ConsumerWidget {
  final String sliderLabel;
  final double sliderInitialValue;
  final double sliderMaxValue;
  final double sliderAmountDisplay;
  final Function(double value) sliderOnChangeFunction;
  const AccountSlider({
    required this.sliderLabel,
    required this.sliderInitialValue,
    required this.sliderMaxValue,
    required this.sliderAmountDisplay,
    required this.sliderOnChangeFunction,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sliderLabel,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          '\$${sliderAmountDisplay.toInt().toString()}',
          style: TextStyle(
            fontSize: 60,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        Slider(
          value: sliderInitialValue,
          thumbColor: Theme.of(context).colorScheme.primary,
          max: sliderMaxValue,
          inactiveColor: Colors.grey.withOpacity(.5),
          onChanged: sliderOnChangeFunction,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
