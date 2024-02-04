import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final MaterialStateProperty<Icon?> switchIcon;
  final bool? switchState;
  final Function(bool) onChanged;

  const SwitchWidget({
    super.key,
    required this.switchIcon,
    required this.onChanged,
    this.switchState,
  });

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool switchState;

  @override
  void initState() {
    super.initState();
    switchState = widget.switchState ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbIcon: widget.switchIcon,
      value: switchState,
      onChanged: (s) {
        setState(() {
          switchState = s;
        });
        widget.onChanged(s);
      },
    );
  }
}
