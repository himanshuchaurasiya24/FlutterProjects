import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:plant_app_ui/colors.dart';
import 'package:plant_app_ui/planet_detail_page.dart';
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
          child: Padding(
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
                SizedBox(
                  height: 675,
                  child: Swiper(
                    itemCount: planets.length,
                    physics: const BouncingScrollPhysics(),
                    itemHeight: 675,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        size: 20.0,
                        activeSize: 30.0,
                        activeColor: firstGradientColor,
                      ),
                    ),
                    itemWidth: double.infinity,
                    layout: SwiperLayout.TINDER,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlanetDetailPage(
                                    planetInfo: planets[index]);
                              },
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 130,
                                        ),
                                        Text(
                                          planets[index].name,
                                          style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                Color.fromARGB(255, 71, 69, 95),
                                          ),
                                        ),
                                        Text(
                                          'Solar System',
                                          style: TextStyle(
                                            fontSize: 25,
                                            // fontWeight: FontWeight.w900,
                                            color: primaryTextColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Know More',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: secondaryTextColor),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                //
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                size: 25,
                                                color: secondaryTextColor,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                                right: 50,
                                left: 50,
                                child: Image.asset(planets[index].iconImage)),
                            Positioned(
                              right: 100,
                              bottom: 160,
                              child: Text(
                                planets[index].id.toString(),
                                style: TextStyle(
                                  fontSize: 260,
                                  fontWeight: FontWeight.bold,
                                  color: primaryTextColor.withOpacity(0.1),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        //
                      },
                      icon: Image.asset('assets/images/img/menu_icon.png')),
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
