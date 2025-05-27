import 'package:flutter/material.dart';
import 'package:flutter_example_base/utils/print_log.dart';

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
                  style: TextStyle(color: isError == true ? Colors.red : Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: onPress,
                child: Text(
                  btnTitle ?? 'Go',
                  style: TextStyle(color: isError == true ? Colors.red : Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Divider(color: Colors.blueGrey.withValues(alpha: 0.5), thickness: 1.0),
          ),
        ],
      ),
    );
  }
}
