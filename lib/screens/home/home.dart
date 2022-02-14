import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxonetime/screens/chat/chatbody.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pictures = [
    'assets/swiper/download1.jpg',
    'assets/swiper/download2.jpg',
    'assets/swiper/download3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF41729F),
          elevation: 0,
        ),
        body: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: pictures.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      i,
                      fit: BoxFit.fill,
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(const ChatPage());
          },
          label: const Text('CHAT'),
          icon: const Icon(Icons.chat),
          backgroundColor: const Color(0xFF41729F),
        ),
      ),
    );
  }
}
