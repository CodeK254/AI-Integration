import "package:flutter/material.dart";

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String cancel;
  final String okay;
  final Widget content;
  final void Function()? onCancel;
  final void Function()? onOkay;
  const CustomAlertDialog({super.key, required this.title, required this.content, required this.cancel, required this.okay, this.onCancel, this.onOkay});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: content,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onCancel, 
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
                ),
                child: Text(
                  cancel,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: onOkay, 
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green.shade300,
                ),
                child: Text(
                  okay,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}