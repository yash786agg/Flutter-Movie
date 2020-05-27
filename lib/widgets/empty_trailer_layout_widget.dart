import 'package:flutter/material.dart';

class EmptyTrailerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "No trailer available",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }
}
