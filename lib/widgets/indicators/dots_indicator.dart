import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DelayedAnimation(
          animationController: _animationController,
          delay: const Duration(milliseconds: 0),
          child: const Dot(),
        ),
        DelayedAnimation(
          animationController: _animationController,
          delay: const Duration(milliseconds: 200),
          child: const Dot(),
        ),
        DelayedAnimation(
          animationController: _animationController,
          delay: const Duration(milliseconds: 400),
          child: const Dot(),
        ),
      ],
    );
  }
}

class DelayedAnimation extends StatefulWidget {
  final AnimationController animationController;
  final Duration delay;
  final Widget child;

  const DelayedAnimation({
    super.key,
    required this.animationController,
    required this.delay,
    required this.child,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          widget.delay.inMilliseconds / 1000,
          (widget.delay.inMilliseconds + 200) / 1000,
          curve: Curves.easeInOut,
        ),
      ),
    );
    widget.animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: const BoxDecoration(
        color: Color(0xff5669FF),
        shape: BoxShape.circle,
      ),
    );
  }
}
