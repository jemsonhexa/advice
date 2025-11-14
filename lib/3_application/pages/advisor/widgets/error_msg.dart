// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String errMsg;
  const ErrorMsg({super.key, required this.errMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.redAccent, size: 40),
        SizedBox(height: 10),
        Text(errMsg, textAlign: TextAlign.center),
      ],
    );
  }
}
