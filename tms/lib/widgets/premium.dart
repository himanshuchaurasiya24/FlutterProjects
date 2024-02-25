import 'package:flutter/material.dart';
import 'package:tms/widgets/constants.dart';

class GoPremium extends StatefulWidget {
  const GoPremium({super.key});

  @override
  State<GoPremium> createState() => _GoPremiumState();
}

class _GoPremiumState extends State<GoPremium> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(height * 0.004),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              height * 0.02,
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xfffdc830),
                Color(0xfff37335),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                height * 0.02,
              ),
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.all(height * 0.012),
            child: Row(
              children: [
                Container(
                  height: height * 0.05,
                  width: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.02),
                    color: Colors.grey[300],
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 224, 224, 224).withOpacity(0.6),
                      BlendMode.srcATop,
                    ),
                    child: const Icon(
                      Icons.workspace_premium_outlined,
                      size: 30,
                      color: MyThemeColor.textColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Go Premium',
                      style: TextStyle(
                        color: Color.fromARGB(255, 22, 23, 22),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Get access to all the features\nand unlimited downloads',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
