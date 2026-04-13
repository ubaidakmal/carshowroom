import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../home/home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    _PlaceholderTab(icon: Icons.explore_outlined, label: 'Explore'),
    _PlaceholderTab(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
    _PlaceholderTab(icon: Icons.favorite_border_rounded, label: 'Favorites'),
    _PlaceholderTab(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final items = <IconData>[
      Icons.home_filled,
      Icons.explore_outlined,
      Icons.chat_bubble_outline_rounded,
      Icons.favorite_border_rounded,
      Icons.person_outline_rounded,
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (i) {
          final isActive = _currentIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: isActive ? 52 : 44,
              height: isActive ? 52 : 44,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                items[i],
                size: 22,
                color: isActive ? AppColors.secondary : AppColors.primary.withValues(alpha: 0.5),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: AppColors.grey400),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 16, color: AppColors.grey400)),
          ],
        ),
      ),
    );
  }
}
