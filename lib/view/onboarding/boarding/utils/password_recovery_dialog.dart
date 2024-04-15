import 'package:flutter/material.dart';

class AlertDialogClass {
  static Widget buildPasswordRecoveryDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Forgot Password?'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please contact the authority to recover your password:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Contact No: 9596939298',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Email: support@sportme.com',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  static passwordRecoveryDialog(BuildContext context) {}
}
