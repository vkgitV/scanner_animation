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

  late double imageWidth ;
  late double imageHeight  ;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _upDownAnimation = Tween<double>(begin: -50, end: 50).animate(_controller);

    _getImageSize();
  }

  void _getImageSize() {
    Image image = Image.asset('assets/images/adharr.jpg');
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          imageWidth = info.image.width.toDouble();
          imageHeight = info.image.height.toDouble();
        });
      }),
    );
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
               Image.asset(
                'assets/images/adharr.jpg',
                fit: BoxFit.contain,
              ),

              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    top: _upDownAnimation.value,
                    child: Container(
                      width: imageWidth + 20,
                      height: imageHeight ,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.3),
                        border: Border.all(color: Colors.orangeAccent, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
