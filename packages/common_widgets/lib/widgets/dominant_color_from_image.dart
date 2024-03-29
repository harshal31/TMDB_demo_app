import 'package:common_widgets/theme/theme_util.dart';
import 'package:flutter/material.dart';

class DominantColorFromImage extends StatefulWidget {
  final ImageProvider imageProvider;
  final Widget? dominantChild;

  const DominantColorFromImage({
    super.key,
    required this.imageProvider,
    this.dominantChild,
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
    return AnimatedContainer(
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            currentColorScheme.primary.withOpacity(1.0),
            currentColorScheme.primary.withOpacity(0.1),
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
      child: widget.dominantChild,
    );
  }

  Future<void> _updateImage(ImageProvider provider) async {
    final ColorScheme newColorScheme = await ColorScheme.fromImageProvider(
      provider: provider,
    );
    setState(() {
      currentColorScheme = newColorScheme;
    });
  }
}
