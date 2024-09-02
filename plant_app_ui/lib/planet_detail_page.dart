import 'package:flutter/material.dart';
import 'package:plant_app_ui/colors.dart';
import 'package:plant_app_ui/universe_model.dart';

class PlanetDetailPage extends StatefulWidget {
  const PlanetDetailPage({super.key, required this.planetInfo});
  final PlanetInfo planetInfo;
  @override
  State<PlanetDetailPage> createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends State<PlanetDetailPage> {
  bool isExpandedText = false;
  void toggleExpansion() {
    setState(() {
      isExpandedText = !isExpandedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 280,
                      ),
                      Text(
                        widget.planetInfo.name,
                        style: TextStyle(
                          fontSize: 60,
                          color: primaryTextColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Solar System',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 30,
                        ),
                      ),
                      Divider(
                        color: primaryTextColor,
                      ),
                      Text(
                        widget.planetInfo.description,
                        maxLines: isExpandedText ? null : 5,
                        overflow: isExpandedText
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: contentTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        // iconAlignment: IconAlignment.start,
                        onPressed: () {
                          toggleExpansion();
                        },
                        child: Text(
                          isExpandedText ? 'Read Less' : "Read More",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: primaryTextColor,
                      ),
                    ],
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 25,
                      color: primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.planetInfo.images.length,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                widget.planetInfo.images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -42,
            child: Hero(
              tag: widget.planetInfo.id,
              child: Image.asset(
                widget.planetInfo.iconImage,
              ),
            ),
          ),
          Positioned(
            // left: 40,
            child: Text(
              widget.planetInfo.id.toString(),
              style: TextStyle(
                fontSize: 260,
                fontWeight: FontWeight.bold,
                color: primaryTextColor.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
