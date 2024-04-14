import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.onTap,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultPadding),
      hoverDuration: const Duration(microseconds: 100),
      hoverColor: Theme.of(context).colorScheme.primary,
      focusColor: Theme.of(context).colorScheme.primary,
      splashColor: Theme.of(context).colorScheme.tertiary,
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            defaultPadding,
          ),
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
