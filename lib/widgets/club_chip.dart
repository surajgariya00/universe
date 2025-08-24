
import 'package:flutter/material.dart'; import '../models/club.dart';
class ClubChip extends StatelessWidget {
  final Club club; const ClubChip({super.key, required this.club});
  @override Widget build(BuildContext context){ return Chip(avatar: const Icon(Icons.group), label: Text(club.name)); }
}
