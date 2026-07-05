# openstrap_icons

The OpenStrap illustrated icon set: soft-3D full-color icons with transparent
backgrounds, shipped as 512 px WebP (alpha preserved), in light and dark theme
variants, with a drop-in `AppIcon` widget that picks the right variant from the
ambient `Theme`.

## Install

Path dependency (monorepo):

```yaml
dependencies:
  openstrap_icons:
    path: ../openstrap_icons
```

or a git dependency:

```yaml
dependencies:
  openstrap_icons:
    git:
      url: <repo-url>
      path: openstrap_icons
```

## Usage

```dart
import 'package:openstrap_icons/openstrap_icons.dart';

// Theme-aware (light asset in light theme, dark asset in dark theme):
AppIcon(OsIcon.heart, size: 28)

// Force a variant:
AppIcon(OsIcon.sleep, size: 48, brightness: Brightness.dark)

// Accessibility label:
AppIcon(OsIcon.recovery, semanticLabel: 'Recovery')

// Optional tint (rarely wanted — these are full-color illustrations):
AppIcon(OsIcon.add, tint: Colors.white)
```

Fallback behavior (never crashes):

- If an icon only has one variant (e.g. `hrv` is light-only today), that
  variant is used for both brightnesses.
- If an `OsIcon` has no asset at all yet, a transparent `SizedBox` of `size`
  is rendered — so screens can reference icons before the art lands.

## Adding a new icon

1. Drop `{base}-light.png` and/or `{base}-dark.png` (1024×1024, transparent
   background) into the raw art folder (default: `../openstrap-icons`).
2. Run the converter from the package root:

   ```sh
   tool/convert.sh              # or: tool/convert.sh /path/to/art
   ```

   It downscales to 512 px (`sips`), encodes WebP with alpha
   (`cwebp -q 90 -alpha_q 100`), writes `assets/{light,dark}/{base}.webp`,
   and regenerates `lib/src/asset_manifest.g.dart`.
3. Add the matching member to the `OsIcon` enum in `lib/src/os_icon.dart`,
   mapping to the base name (e.g. `heartRate('heart-rate')`).
4. `flutter test` — a test asserts every enum member resolves to an asset.

## Example

`example/` contains a review app showing every icon in a grid, rendered on
both light and dark surfaces side by side.
