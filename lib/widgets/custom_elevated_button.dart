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
        shape: RoundedRectangleBorder(
          side: isEnabled
              ? BorderSide.none
              : const BorderSide(color: Color.fromRGBO(216, 223, 230, 1)),
          borderRadius: BorderRadius.circular(3),
        ),
        backgroundColor:
            isEnabled ? const Color.fromRGBO(33, 136, 255, 1) : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isEnabled
                ? Colors.white
                : const Color.fromRGBO(119, 129, 140, 1),
          ),
          Text(
            text,
            style: TextStyle(
              color: isEnabled
                  ? Colors.white
                  : const Color.fromRGBO(119, 129, 140, 1),
            ),
          )
        ],
      ),
    );
  }
}
