//?Splash Page

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  _startAnimation() async {
    await Future.delayed(const Duration(seconds: 7)); // Initial delay

    // Navigate to the main page after animation is complete
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Background color
      body: Center(
        child: AnimatedText(
          text: "FLUSHOES",
          style: GoogleFonts.dmSans(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const AnimatedText({super.key, required this.text, required this.style});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  late List<Widget> _blocks;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() {
    List<Widget> blocks = [];
    for (int i = 0; i < widget.text.length; i++) {
      blocks.add(
        MinecraftBlock(
          char: widget.text[i],
          duration: const Duration(milliseconds: 500),
        ),
      );
      blocks.add(const SizedBox(width: 1));
    }

    setState(() {
      _blocks = blocks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _blocks,
    );
  }
}

class MinecraftBlock extends StatefulWidget {
  final String char;
  final Duration duration;

  const MinecraftBlock({super.key, required this.char, required this.duration});

  @override
  _MinecraftBlockState createState() => _MinecraftBlockState();
}

class _MinecraftBlockState extends State<MinecraftBlock> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(widget.duration);

    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: _opacity,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red[600], // Block color
          border: Border.all(color: Colors.black), // Block border
        ),
        child: Center(
          child: Text(
            widget.char,
            style: GoogleFonts.dmSans(
              color: Colors.black, // Text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
