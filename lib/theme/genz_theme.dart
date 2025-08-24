import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenZTheme {
  static const seeds = <int, Color>{
    0: Color(0xFF7C3AED),
    1: Color(0xFF06B6D4),
    2: Color(0xFFFF2E63),
    3: Color(0xFF10B981),
    4: Color(0xFFFF8A00),
  };

  static ThemeData build(int seedIndex, bool dark) {
    final seed = seeds[seedIndex % seeds.length] ?? const Color(0xFF7C3AED);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: dark ? Brightness.dark : Brightness.light,
    );
    final base = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      textTheme: GoogleFonts.soraTextTheme(),
    );
    return base.copyWith(
      scaffoldBackgroundColor: dark
          ? const Color(0xFF0B0B12)
          : const Color(0xFFF8F8FF),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0.8,
        color: scheme.surface.withOpacity(dark ? 0.35 : 0.9),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withOpacity(dark ? 0.3 : 0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        side: BorderSide.none,
        showCheckmark: false,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class GZBackground extends StatelessWidget {
  final Widget child;
  const GZBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primary.withOpacity(0.22),
            cs.tertiary.withOpacity(0.14),
            cs.secondaryContainer.withOpacity(0.10),
          ],
        ),
      ),
      child: child,
    );
  }
}

class GZAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final String? logoAsset; // NEW

  const GZAppBar({
    super.key,
    required this.titleText,
    this.actions,
    this.logoAsset,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primary.withOpacity(0.30),
            cs.secondary.withOpacity(0.15),
          ],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (logoAsset != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(logoAsset!, height: 22),
              ),
            Text(titleText),
          ],
        ),
        actions: actions,
      ),
    );
  }
}
