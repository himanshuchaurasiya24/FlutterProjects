import 'package:flutter/material.dart';

class MySliverAppbar extends StatelessWidget {
  const MySliverAppbar({
    super.key,
    required this.title,
    required this.child,
  });
  final Widget title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      // pinned: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_outlined,
          ),
        ),
      ],
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Sunset Dinner'),
      flexibleSpace: FlexibleSpaceBar(
        background: child,
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(
          left: 0,
          right: 0,
          top: 0,
        ),
        expandedTitleScale: 2,
      ),
    );
  }
}
