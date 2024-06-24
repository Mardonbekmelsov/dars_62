import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ExternalAnimation());
}

class ExternalAnimation extends StatefulWidget {
  const ExternalAnimation({super.key});

  @override
  State<ExternalAnimation> createState() => _ExternalAnimationState();
}

class _ExternalAnimationState extends State<ExternalAnimation>
    with SingleTickerProviderStateMixin {
 
  bool isON = false;

  final List<String> imgList = [
    'images/sky.png',
    'images/road1.png',
  ];

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  int _currentPage = 0;
  // ignore: unused_field
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < imgList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Tashqi animatsiyalar"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 180.0,
                child: PageView.builder(
                  pageSnapping: true,
                  // allowImplicitScrolling: false,
                  // padEnds: false,
                  controller: _pageController,
                  itemCount: imgList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imgList[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
              AnimatedContainer(
                // padding: EdgeInsets.all(5),
                duration: const Duration(seconds: 1),
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        image: isON
                            ? const AssetImage(
                                "images/sky.png",
                              )
                            : const AssetImage("images/road1.png"),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(seconds: 1),
                      alignment:
                          isON ? Alignment.centerRight : Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          isON = !isON;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isON ? Colors.black : Colors.white,
                          ),
                          child: Icon(
                            CupertinoIcons.airplane,
                            color: isON ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
       
      ),
    );
  }
}
