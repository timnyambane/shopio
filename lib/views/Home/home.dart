import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/grid.dart';
import '../Profile/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> color = [
      const Color(0xffEDFAFF),
      const Color(0xffFFF6ED),
      const Color(0xffEAFFEA),
      const Color(0xffEAFFEA),
      const Color(0xffEDFAFF),
      const Color(0xffFFF6ED),
      const Color(0xffFFF6ED),
      const Color(0xffEAFFEA),
      const Color(0xffEDFAFF),
      const Color(0xffEAFFEA),
      const Color(0xffEDFAFF),
      const Color(0xffFFF6ED),
    ];

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(() => const ProfileScreen());
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/placeholder.png'),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Demo Shop",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Free plan",
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 0.9,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: List.generate(
                    gridIcons.length,
                    (index) => InkWell(
                          onTap: () {
                            Get.to(() => gridIcons[index].screen);
                          },
                          child: Card(
                            color: color[index],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(gridIcons[index].icon, width: 80),
                                  const SizedBox(height: 10),
                                  Text(
                                    gridIcons[index].title,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ));
  }
}
