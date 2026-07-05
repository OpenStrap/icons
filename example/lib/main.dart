import 'package:flutter/material.dart';
import 'package:openstrap_icons/openstrap_icons.dart';

void main() => runApp(const IconGalleryApp());

class IconGalleryApp extends StatelessWidget {
  const IconGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStrap Icons',
      theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: const GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OpenStrap Icons')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: OsIcon.values.length,
        itemBuilder: (context, i) => _IconCard(icon: OsIcon.values[i]),
      ),
    );
  }
}

/// Shows one icon on a light and a dark surface side by side, so both
/// variants (and the single-variant fallback) are reviewable at a glance.
class _IconCard extends StatelessWidget {
  const _IconCard({required this.icon});

  final OsIcon icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ColoredBox(
                    color: Colors.white,
                    child: Center(
                      child: AppIcon(
                        icon,
                        size: 64,
                        brightness: Brightness.light,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ColoredBox(
                    color: const Color(0xFF14161A),
                    child: Center(
                      child: AppIcon(
                        icon,
                        size: 64,
                        brightness: Brightness.dark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(icon.name, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
