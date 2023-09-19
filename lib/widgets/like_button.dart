
import 'package:flutter/material.dart';

import 'favorite_icon.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onPressed;

  const LikeButton({super.key, 
    required this.isLiked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: FavoriteIcon(isLiked: isLiked),
          onPressed: onPressed,
        ),
        // const Text(
        //   'Like',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}
