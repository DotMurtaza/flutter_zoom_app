import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_app_flutter/Utils/color.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: Size(Get.width, 50),
        ),
        onPressed: widget.onTap,
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
