import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GasPumpAnimation extends StatefulWidget {
  const GasPumpAnimation({Key? key}) : super(key: key);

  @override
  _GasPumpAnimationState createState() => _GasPumpAnimationState();
}

class _GasPumpAnimationState extends State<GasPumpAnimation> {
  late RiveAnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Hey, que tal abastecer?",
            style: Theme.of(context).textTheme.headline3,
          ),
          Container(
            constraints: const BoxConstraints.expand(
              width: 300,
              height: 300,
            ),
            child: const RiveAnimation.asset('assets/rive/gaspump.riv'),
            // child: Image.asset(
            //   "assets/images/fuelempty.png",
            //   fit: BoxFit.fill,
            // ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
  }
}
