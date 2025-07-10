import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  String title;

  ItemTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          // color: Colors.deepPurple,
          fontWeight: FontWeight.w600,
        ),
        // style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.start,
      ),
    );
  }
}
