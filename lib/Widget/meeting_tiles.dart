import 'package:flutter/material.dart';
import 'package:zoom_app_flutter/Utils/color.dart';

class MeetingTiles extends StatelessWidget {
  const MeetingTiles(
      {super.key,
      required this.text,
      required this.isMute,
      required this.onChange});
  final String text;
  final bool isMute;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Switch.adaptive(value: isMute, onChanged: onChange)
          ],
        ),
      ),
    );
  }
}
