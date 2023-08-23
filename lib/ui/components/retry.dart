import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final Function()? onRetry;
  final String error;
  const RetryWidget({
    Key? key,
    required this.onRetry,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(
              "RETRY",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Text(error),
        ],
      ),
    );
  }
}
