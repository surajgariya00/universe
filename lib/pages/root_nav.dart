import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/app_state.dart';
import '../theme/genz_theme.dart';
import 'feed_page.dart';
import 'campus_gate.dart';
import 'schedule_page.dart';
import 'events_page.dart';
import 'marketplace_page.dart';
import 'profile_page.dart';

class RootNav extends StatefulWidget {
  const RootNav({super.key});
  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int index = 0;
  final pages = const [
    FeedPage(),
    SchedulePage(),
    EventsPage(),
    MarketplacePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return CampusGate(
      next: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo/universe_moto.png', height: 24),
              const SizedBox(width: 8),
              const Text('UniVerse'),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => context.read<AppState>().toggleDark(),
              icon: const Icon(Icons.brightness_6_rounded),
            ),
          ],
        ),
        body: GZBackground(child: pages[index]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() => index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.schedule_rounded),
              label: 'Schedule',
            ),
            NavigationDestination(
              icon: Icon(Icons.event_rounded),
              label: 'Events',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_rounded),
              label: 'Market',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
