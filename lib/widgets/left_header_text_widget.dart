import 'package:flutter/material.dart';

class LeftHeaderTextWidget extends StatelessWidget {
  final String header;
  final String text;

  const LeftHeaderTextWidget({
    Key key,
    this.header,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}