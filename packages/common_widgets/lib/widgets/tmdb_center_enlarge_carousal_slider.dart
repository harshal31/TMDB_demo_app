import 'package:carousel_slider/carousel_slider.dart';
import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:common_widgets/widgets/wrapped_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class TmdbCenterEnlargeCarousalSlider extends StatefulWidget {
  final List<String> images;
  final Function onClose;
  final int initialIndex;

  const TmdbCenterEnlargeCarousalSlider({
    super.key,
    required this.images,
    required this.onClose,
    required this.initialIndex,
  });

  @override
  State<StatefulWidget> createState() {
    return _TmdbCenterEnlargeCarousalSliderState();
  }
}

class _TmdbCenterEnlargeCarousalSliderState extends State<TmdbCenterEnlargeCarousalSlider> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: CarouselSlider.builder(
              itemCount: widget.images.length,
              options: CarouselOptions(
                initialPage: widget.initialIndex,
                height: kIsWeb
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height * 0.8,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                onPageChanged: (i, c) {
                  currentIndex = i + 1;
                  setState(() {});
                },
              ),
              itemBuilder: (context, index, realIdx) {
                return Container(
                  child: Center(
                    child: PhotoView(
                      imageProvider: ExtendedImageCreator.getImage(
                        widget.images[index],
                        fit: BoxFit.fill,
                        width: double.infinity,
                        borderRadius: BorderRadius.zero,
                      ).image,
                      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                WrappedText(
                  "$currentIndex / ${widget.images.length}",
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    widget.onClose();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: context.colorTheme.onBackground,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
