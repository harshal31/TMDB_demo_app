import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DominantColorFromImage extends StatefulWidget {
  final ImageProvider imageProvider;

  const DominantColorFromImage({
    super.key,
    required this.imageProvider,
  });

  @override
  State<DominantColorFromImage> createState() => _DominantColorState();
}

class _DominantColorState extends State<DominantColorFromImage> {
  late ColorScheme currentColorScheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentColorScheme = context.colorTheme;
    _updateImage(widget.imageProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            currentColorScheme.primary.withOpacity(0.5),
            currentColorScheme.primary.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Future<void> _updateImage(ImageProvider provider) async {
    final ColorScheme newColorScheme = await ColorScheme.fromImageProvider(
      provider: provider,
      brightness: Theme.of(context).brightness,
    );
    setState(() {
      currentColorScheme = newColorScheme;
    });
  }
}
