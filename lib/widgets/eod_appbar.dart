import 'package:flutter/material.dart';

class EodAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EodAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF5F5F5),
        titleSpacing: 20,
        title: const Text(
          "EOD Tracker",
          style: TextStyle(
          color: Color(0xffF47C20),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        actions: [
          /// Notification icon with dot
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black54),
                onPressed: () {},
              ),

              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),

          /// Settings
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {},
          ),

          /// Profile avatar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xffF47C20),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )
    );
  }
}