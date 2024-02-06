import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  final String title;
  final bool defaultValue;
  final ValueChanged<bool> onChanged;

  const ToggleSwitch({super.key, 
    required this.title,
    required this.defaultValue,
    required this.onChanged,
  });

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
