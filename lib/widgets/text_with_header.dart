import 'package:flutter/material.dart';

class TextWithHeader extends StatelessWidget {
  final String header;
  final String text;

  const TextWithHeader({
    Key key,
    this.header,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Container(
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              header,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}