import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key? key,
    required this.isLiked,
  }) : super(key: key);

  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isLiked ? Icons.favorite : Icons.favorite_border,
      color: isLiked ? Colors.red : Colors.white,
    );
  }
}