import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openstrap_icons/openstrap_icons.dart';

Widget _host(Widget child, Brightness brightness) {
  return MaterialApp(
    theme: ThemeData(brightness: brightness),
    home: Scaffold(body: Center(child: child)),
  );
}

String? _assetNameOf(WidgetTester tester) {
  final image = tester.widget<Image>(find.byType(Image));
  final provider = image.image;
  if (provider is AssetImage) return provider.assetName;
  return null;
}

void main() {
  tearDown(() {
    AppIcon.debugLightAssets = null;
    AppIcon.debugDarkAssets = null;
  });

  testWidgets('inverted: light theme renders the dark variant', (tester) async {
    await tester.pumpWidget(
      _host(const AppIcon(OsIcon.heart), Brightness.light),
    );
    expect(_assetNameOf(tester), 'assets/dark/heart.webp');
    final image = tester.widget<Image>(find.byType(Image));
    expect((image.image as AssetImage).package, 'openstrap_icons');
  });

  testWidgets('inverted: dark theme renders the light variant', (tester) async {
    await tester.pumpWidget(
      _host(const AppIcon(OsIcon.heart), Brightness.dark),
    );
    expect(_assetNameOf(tester), 'assets/light/heart.webp');
  });

  testWidgets('explicit brightness overrides the theme (inverted)',
      (tester) async {
    await tester.pumpWidget(
      _host(
        const AppIcon(OsIcon.heart, brightness: Brightness.dark),
        Brightness.light,
      ),
    );
    // Forced dark brightness → inverted → light art (differs from the light
    // host, proving the override takes effect).
    expect(_assetNameOf(tester), 'assets/light/heart.webp');
  });

  testWidgets('single-variant icon (hrv, light-only) serves both themes',
      (tester) async {
    await tester.pumpWidget(_host(const AppIcon(OsIcon.hrv), Brightness.dark));
    expect(_assetNameOf(tester), 'assets/light/hrv.webp');

    await tester.pumpWidget(_host(const AppIcon(OsIcon.hrv), Brightness.light));
    expect(_assetNameOf(tester), 'assets/light/hrv.webp');
  });

  testWidgets('dark-only icon serves the dark asset under a light theme',
      (tester) async {
    AppIcon.debugLightAssets = const {};
    AppIcon.debugDarkAssets = const {'heart'};
    await tester.pumpWidget(
      _host(const AppIcon(OsIcon.heart), Brightness.light),
    );
    expect(_assetNameOf(tester), 'assets/dark/heart.webp');
  });

  testWidgets('icon with no asset renders an empty box of the given size',
      (tester) async {
    AppIcon.debugLightAssets = const {};
    AppIcon.debugDarkAssets = const {};
    await tester.pumpWidget(
      _host(const AppIcon(OsIcon.heart, size: 40), Brightness.light),
    );
    expect(find.byType(Image), findsNothing);
    final box = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(box.width, 40);
    expect(box.height, 40);
  });

  testWidgets('applies requested size to the image', (tester) async {
    await tester.pumpWidget(
      _host(const AppIcon(OsIcon.sleep, size: 56), Brightness.light),
    );
    final image = tester.widget<Image>(find.byType(Image));
    expect(image.width, 56);
    expect(image.height, 56);
    expect(image.fit, BoxFit.contain);
  });

  test('every OsIcon member resolves to at least one shipped asset', () {
    for (final icon in OsIcon.values) {
      expect(
        AppIcon.resolveAsset(icon, Brightness.light),
        isNotNull,
        reason: '${icon.name} has no asset in either variant',
      );
    }
  });
}
