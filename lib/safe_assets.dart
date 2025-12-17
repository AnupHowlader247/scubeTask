import 'package:flutter/material.dart';

class SafeAssetIcon extends StatelessWidget {
  final String path;
  final double size;
  final IconData fallbackIcon;

  const SafeAssetIcon({
    Key? key,
    required this.path,
    required this.size,
    required this.fallbackIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) =>
          Icon(fallbackIcon, size: size),
    );
  }
}

