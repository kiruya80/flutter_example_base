import 'package:flutter/material.dart';

class RouterMoveItem extends StatelessWidget {
  String title;
  String? btnTitle;
  bool? isError;
  Function()? onPress;

  RouterMoveItem(this.title, this.onPress, {super.key, this.btnTitle = 'Go', this.isError = false});

  @override
  Widget build(BuildContext context) {
    // QcLog.d('title : $title , btnTitle : $btnTitle , isError : $isError , ');

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:Theme.of(context).textTheme.titleMedium ,
                  // style: TextStyle(
                  //   color: isError == true ? Colors.red : Colors.black,
                  // ),
                ),
              ),
              // ElevatedButton
              OutlinedButton(onPressed: onPress, child: Text(btnTitle ?? 'Go')),
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              // color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
