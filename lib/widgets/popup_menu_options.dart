import 'package:flutter/material.dart';

import 'app_state_container.dart';

enum OptionsMenu { settings }

class PopUpMenuOptions extends StatelessWidget {
  PopUpMenuOptions({@required this.onSelected});

  final Function onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OptionsMenu>(
      child: Icon(
        Icons.more_vert,
        size: 24.0,
        color: AppStateContainer.of(context).theme.accentColor,
      ),
      onSelected: (OptionsMenu result) {
        onSelected(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<OptionsMenu>>[
        const PopupMenuItem<OptionsMenu>(
          value: OptionsMenu.settings,
          child: Text("Settings"),
        ),
      ],
    );
  }
}
