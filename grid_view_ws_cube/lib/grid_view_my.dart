import 'package:flutter/material.dart';

class GridViewMy extends StatelessWidget {
  const GridViewMy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GridView.extent(
      //   mainAxisSpacing: 10,
      //   crossAxisSpacing: 10,
      //   maxCrossAxisExtent: 100,
      //   children: [
      //     for (int i = 0; i < 20; i++)
      //       Container(
      //         color: Colors.redAccent,
      //       ),
      //   ],
      // ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.redAccent,
          );
        },
      ),
    );
  }
}

class SliverGridDelegateWithMaxCrossAxisCount {
  const SliverGridDelegateWithMaxCrossAxisCount();
}
