import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../explore/explore_screen.dart';
import '../favorites/favorites_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => MainShellState();
}

class MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void switchTab(int index) {
    if (index >= 0 && index < 5) setState(() => _currentIndex = index);
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    _MessagesTab(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
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
                color: isActive ? AppColors.primary : AppColors.primary.withValues(alpha: 0.08),
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

class _MessagesTab extends StatelessWidget {
  const _MessagesTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Messages', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.secondary)),
              const SizedBox(height: 4),
              Text('Your conversations', style: TextStyle(fontSize: 12, color: AppColors.grey600)),
              const SizedBox(height: 24),
              ..._chats.map(_buildChat),
            ],
          ),
        ),
      ),
    );
  }

  static const _chats = [
    _ChatItem('BMW Luxury Drive', 'Your test drive is confirmed for tomorrow at 10:30 AM.', '2m'),
    _ChatItem('Mercedes Showroom', 'We have a special offer on the AMG GT this week!', '1h'),
    _ChatItem('Nissan Premium', 'Thank you for visiting. How was your experience?', '3h'),
    _ChatItem('Audi Centre', 'The RS7 you reserved is ready for pickup.', '1d'),
  ];

  Widget _buildChat(_ChatItem chat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.storefront_rounded, size: 22, color: AppColors.secondary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(chat.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                    ),
                    Text(chat.time, style: TextStyle(fontSize: 11, color: AppColors.grey400)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(chat.message, style: TextStyle(fontSize: 12, color: AppColors.grey600), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatItem {
  const _ChatItem(this.name, this.message, this.time);
  final String name;
  final String message;
  final String time;
}
