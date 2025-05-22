import 'package:flutter/material.dart';
import 'dart:math' as math;

class CountdownTimer extends StatefulWidget {
  final Color pageColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;

  const CountdownTimer({
    Key? key,
    this.pageColor = Colors.red,
    this.backgroundColor = Colors.black12,
    this.foregroundColor = Colors.white,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inSeconds}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    controller.duration = const Duration(seconds: 4);
    controller.reverse(from: 4);
  }

  @override
  Widget build(BuildContext context) {
    print("Countdown timer shown");
    return Scaffold(
      body: Container(
        color: widget.pageColor,
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: FractionalOffset.center,
                                child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: CustomPaint(
                                            painter: CustomTimerPainter(
                                              animation: controller,
                                              backgroundColor:
                                              widget.backgroundColor,
                                              color: widget.foregroundColor,
                                            )),
                                      ),
                                      Align(
                                        alignment: FractionalOffset.center,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              timerString,
                                              style: TextStyle(
                                                  fontSize: 112.0,
                                                  color: widget.textColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
