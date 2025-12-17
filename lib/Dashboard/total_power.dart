import 'package:flutter/material.dart';

class TotalPowerRing extends StatelessWidget {
  final String valueText;
  final String unitText;

  const TotalPowerRing({
    super.key,
    required this.valueText,
    required this.unitText,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 140,
        maxHeight: 140,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CircularProgressIndicator(
                value: 1,
                strokeWidth: 20,
                valueColor: const AlwaysStoppedAnimation(
                  Color(0xFF2E86C1),
                ),
                backgroundColor: const Color(0xFFD7E6F7),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Total Power",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "$valueText $unitText",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
