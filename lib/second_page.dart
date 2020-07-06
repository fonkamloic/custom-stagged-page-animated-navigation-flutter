import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SlidingContainer(transitionAnimation: animation, color: Colors.red, intervalStart: 0, intervalEnd: 0.5, initialOffsetX:1 ),
          ),
          Expanded(
            child: SlidingContainer(transitionAnimation: animation, color: Colors.blue, intervalStart: 0.5, intervalEnd: 1, initialOffsetX: -1 ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: Text('Navigate Back'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SlidingContainer extends StatelessWidget {
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  final Color color;
  const SlidingContainer({
    Key key,
    @required this.transitionAnimation, @required this.initialOffsetX,@required this.intervalStart, @required this.intervalEnd, @required     this.color,
  }) : super(key: key);

  final Animation<double> transitionAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: transitionAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset( initialOffsetX , 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
                  curve: Interval(intervalStart, intervalEnd, curve: Curves.easeOutCubic),
                  parent: transitionAnimation)),
          child: child,
        );
      },
      child: Container(
        color: color,
      ),
    );
  }
}
