import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onBellTap;
  final bool showBellDot;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onBack,
    required this.onBellTap,
    this.showBellDot = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              const SizedBox(width: 8),
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF0C1B3A),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0C1B3A),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 52,
                child: GestureDetector(
                  onTap: onBellTap,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        size: 26,
                        color: Color(0xFF0C1B3A),
                      ),
                      if (showBellDot)
                        const Positioned(
                          right: 14,
                          top: 14,
                          child: CircleAvatar(
                            radius: 4.5,
                            backgroundColor: Color(0xFFE53935),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
