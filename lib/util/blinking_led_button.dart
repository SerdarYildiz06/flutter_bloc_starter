import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SensorBlinkingButton extends StatefulWidget {
  Color color;

  SensorBlinkingButton({Key? key, required this.color}) : super(key: key);

  @override
  _SensorBlinkingButtonState createState() => _SensorBlinkingButtonState();
}

class _SensorBlinkingButtonState extends State<SensorBlinkingButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
