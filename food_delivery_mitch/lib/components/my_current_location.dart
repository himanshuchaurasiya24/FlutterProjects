import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver Now',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          Row(
            children: [
              Text(
                'Gulal Saray, Ghazipur',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ],
          )
        ],
      ),
    );
  }
}
