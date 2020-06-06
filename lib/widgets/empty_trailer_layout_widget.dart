import 'package:flutter/material.dart';

import 'app_state_container.dart';

class EmptyTrailerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "No trailer available",
          style: TextStyle(
            color: AppStateContainer.of(context).theme.accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }
}
