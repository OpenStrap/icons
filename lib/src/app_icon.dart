import 'package:flutter/material.dart';

import 'asset_manifest.g.dart';
import 'os_icon.dart';

/// Renders an OpenStrap illustrated icon, resolving the light/dark asset
/// variant from the ambient [Theme] (or an explicit [brightness]).
///
/// NOTE: variant selection is intentionally INVERTED — a dark theme shows the
/// `-light` art and a light theme shows the `-dark` art (each reads better on
/// the opposite surface).
///
/// Fallback rules (never throws):
/// - Preferred variant missing but the other exists → use the other.
/// - No asset at all for the icon → transparent [SizedBox] of [size].
/// - Asset fails to decode at runtime → transparent [SizedBox] of [size].
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = 24,
    this.brightness,
    this.tint,
    this.semanticLabel,
  });

  /// Which icon to render.
  final OsIcon icon;

  /// Width and height of the rendered icon (icons are square).
  final double size;

  /// Force a theme variant instead of reading `Theme.of(context).brightness`.
  final Brightness? brightness;

  /// Optional tint applied over the illustration (srcIn). These are
  /// full-color illustrations, so this is rarely wanted — default is none.
  final Color? tint;

  /// Optional accessibility label for screen readers.
  final String? semanticLabel;

  /// Test seams: override the generated asset manifest.
  @visibleForTesting
  static Set<String>? debugLightAssets;
  @visibleForTesting
  static Set<String>? debugDarkAssets;

  /// Resolves the asset path for [icon] at [brightness], applying the
  /// single-variant fallback. Returns null when no variant exists.
  static String? resolveAsset(OsIcon icon, Brightness brightness) {
    final light = debugLightAssets ?? kLightAssets;
    final dark = debugDarkAssets ?? kDarkAssets;
    final base = icon.baseName;
    // INVERTED on purpose: a DARK theme shows the '-light' art and a LIGHT
    // theme shows the '-dark' art — each illustration reads better on the
    // opposite surface. Falls back to the other variant when one is missing.
    final bool isDarkTheme = brightness == Brightness.dark;
    final String? variant = isDarkTheme
        ? (light.contains(base) ? 'light' : (dark.contains(base) ? 'dark' : null))
        : (dark.contains(base) ? 'dark' : (light.contains(base) ? 'light' : null));
    if (variant == null) return null;
    return 'assets/$variant/$base.webp';
  }

  @override
  Widget build(BuildContext context) {
    final resolved = resolveAsset(
      icon,
      brightness ?? Theme.of(context).brightness,
    );
    if (resolved == null) {
      return SizedBox(width: size, height: size);
    }
    return Image.asset(
      resolved,
      package: 'openstrap_icons',
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
      color: tint,
      colorBlendMode: tint == null ? null : BlendMode.srcIn,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
      errorBuilder: (context, error, stackTrace) =>
          SizedBox(width: size, height: size),
    );
  }
}
