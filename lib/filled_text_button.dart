import 'package:flutter/material.dart';

class FilledTextButton extends StatelessWidget {
  const FilledTextButton({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  final String text;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: onClicked,
              child: Text(text)
          )
        ],
      ),
    );
  }
}
