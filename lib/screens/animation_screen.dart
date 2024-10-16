

import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _upDownAnimation;
  late Animation<double> _fadeAnimation;



  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _upDownAnimation = Tween<double>(begin: 0, end: 100).animate(_controller);

    // _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _controller,curve: Curves.fastEaseInToSlowEaseOut
    //
    //   ),
    // );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Animation'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/images/adharr.webp',
                fit: BoxFit.contain,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: _upDownAnimation.value,
                  // child: FadeTransition(
                  //   opacity: _fadeAnimation,
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.withOpacity(0.3),
                          border: Border.all(color: Colors.orangeAccent, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
