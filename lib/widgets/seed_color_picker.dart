
import 'package:flutter/material.dart'; import '../theme/genz_theme.dart'; import 'package:provider/provider.dart'; import '../controllers/app_state.dart';
class SeedColorPicker extends StatelessWidget {
  const SeedColorPicker({super.key});
  @override Widget build(BuildContext context){
    final state = context.watch<AppState>();
    return Wrap(spacing:10, runSpacing:10, children: GenZTheme.seeds.entries.map((e){
      final selected = e.key == state.seed;
      return GestureDetector(onTap: ()=>context.read<AppState>().setSeed(e.key), child: Container(width: selected?42:36, height: selected?42:36, decoration: BoxDecoration(color: e.value, shape: BoxShape.circle, border: Border.all(color: Colors.white30, width:2)), child: selected? const Icon(Icons.check, color: Colors.white): null));
    }).toList());
  }
}
