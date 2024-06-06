import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final String text;
  final bool isEnabled;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        backgroundColor: Colors.blue,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
