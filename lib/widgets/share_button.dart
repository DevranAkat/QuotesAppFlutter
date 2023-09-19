
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors
  const ShareButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: onPressed,
        ),
        // const Text(
        //   'Share',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}
