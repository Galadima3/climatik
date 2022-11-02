import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenPage extends ConsumerWidget {
  const ScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Hero(
          tag: 'TransitTag',
          
          child: Icon(Icons.search, size: 50,)
        ),
      ),
    ));
  }
}
