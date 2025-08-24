import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'controllers/app_state.dart';
import 'pages/root_nav.dart';
import 'theme/genz_theme.dart';
import 'services/seed_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('user');
  await Hive.openBox('events');
  await Hive.openBox('clubs');
  await Hive.openBox('posts');
  await Hive.openBox('timetable');
  await SeedService.ensureSeed();
  runApp(const UniVerseApp());
}

class UniVerseApp extends StatelessWidget {
  const UniVerseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          final theme = GenZTheme.build(state.seed, state.dark);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'UniVerse – campus superapp',
            theme: theme,
            home: const RootNav(),
          );
        },
      ),
    );
  }
}
