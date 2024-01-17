import 'package:flutter/material.dart';

class SwitchIcon {
  static MaterialStateProperty<Icon?> trendingSwitchIcon = MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.today);
      }
      return const Icon(Icons.view_week);
    },
  );

  static MaterialStateProperty<Icon?> latestSwitchIcon = MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.movie);
      }
      return const Icon(Icons.tv);
    },
  );


}
