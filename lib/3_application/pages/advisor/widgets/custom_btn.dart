import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, this.onTap});

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);
    return InkResponse(
      //always use a function instead of giving triger here it is easy to test
      onTap: onTap,
      child: Material(
        elevation: 25,
        borderRadius: BorderRadius.circular(20),
        color: themData.colorScheme.onPrimary,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text("Get Advice", style: themData.textTheme.bodyMedium),
        ),
      ),
    );
  }
}
