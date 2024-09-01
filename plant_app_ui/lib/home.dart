import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:plant_app_ui/colors.dart';
import 'package:plant_app_ui/universe_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondGradientColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              firstGradientColor,
              secondGradientColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Solar System',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                            color: Colors.white60,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            //
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.pink[200],
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 675,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Swiper(
                        itemCount: planets.length,
                        physics: const BouncingScrollPhysics(),
                        itemHeight: 675,
                        itemWidth: double.infinity,
                        layout: SwiperLayout.TINDER,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 35,
                                          vertical: 35,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 100,
                                            ),
                                            Text(
                                              planets[index].name,
                                              style: const TextStyle(
                                                fontSize: 50,
                                                fontWeight: FontWeight.w900,
                                                color: Color.fromARGB(
                                                    255, 71, 69, 95),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: navBarColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        //
                      },
                      icon: Image.asset('assets/images/img/menu_icon.png')),
                  const SizedBox(
                    width: 80,
                  ),
                  IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Text(
                      'Explore',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  //
                },
                icon: const Icon(
                  Icons.search,
                  size: 45,
                  color: Colors.white70,
                ),
              ),
              IconButton(
                onPressed: () {
                  //
                },
                icon: const Icon(
                  Icons.person_outlined,
                  size: 45,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
