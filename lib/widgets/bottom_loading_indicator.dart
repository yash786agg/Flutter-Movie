import 'package:flutter/material.dart';
import 'app_state_container.dart';

class BottomLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100.0,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            accentColor: AppStateContainer.of(context).theme.primaryColor,
          ),
          child: new CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
