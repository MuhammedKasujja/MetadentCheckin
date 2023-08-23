import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    this.onPressed,
    required this.label,
    this.height = 42,
  }) : super(key: key);
  final String label;
  final Function()? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height),
        side: BorderSide(
          width: 1.5,
          color: Theme.of(context).primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
