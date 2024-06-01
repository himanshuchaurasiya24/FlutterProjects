import 'package:animation_hero/model.dart';
import 'package:flutter/material.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

final person = [
  Person(
    name: 'Himanshu Chaurasiya',
    age: 24,
    emoji: '😊',
  ),
  Person(
    name: 'Shishir Chaurasiya',
    age: 21,
    emoji: '😂',
  ),
  Person(
    name: 'Anuj Chaurasiya',
    age: 24,
    emoji: '❤️',
  ),
  Person(
    name: 'Ankit Chaurasiya',
    age: 21,
    emoji: '👍',
  ),
];

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: person.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: person[index].emoji,
              child: Text(
                person[index].emoji,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            title: Text(person[index].name),
            subtitle: Text(
              person[index].age.toString(),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailsPage(person: person[index]);
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(
                          begin: 0.0,
                          end: 10.0,
                        ).chain(
                          CurveTween(
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      child: toHeroContext.widget),
                );

              case HeroFlightDirection.pop:
                return Material(
                    color: Colors.transparent, child: fromHeroContext.widget);
            }
          },
          tag: person.emoji,
          child: Text(
            person.emoji,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(person.name),
            Text(
              person.age.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
