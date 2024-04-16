import 'package:flutter/material.dart';
import 'package:food_delivery_mitch/components/constants.dart';
import 'package:food_delivery_mitch/models/food_model.dart';
import 'package:gap/gap.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key, required this.model});
  final FoodModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              model.imagePath,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              model.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            Text(
              '\$${model.price.toString()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              model.description,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            Gap(defaultPadding),
            Divider(
              endIndent: defaultPadding,
              indent: defaultPadding,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Text(
              'Add-ons',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(defaultPadding),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(defaultPadding * 2),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      model.availableAddon[index].name,
                    ),
                    subtitle: Text(
                        '\$${model.availableAddon[index].price.toString()}'),
                    value: false,
                    onChanged: (value) {},
                  );
                },
                itemCount: model.availableAddon.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
