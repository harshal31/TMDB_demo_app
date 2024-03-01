import 'package:common_widgets/theme/theme_util.dart';
import 'package:common_widgets/widgets/extended_image_creator.dart';
import 'package:flutter/material.dart';

class TmdbHorizontalList extends StatelessWidget {
  final List<String> imageUrls;
  final Function()? onViewAllClick;
  final Function(int index)? onItemClick;
  final double? width;
  final double? height;

  const TmdbHorizontalList({
    super.key,
    required this.imageUrls,
    this.onViewAllClick,
    this.onItemClick,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 225,
      child: ListView.builder(
        itemCount: imageUrls.isNotEmpty ? (imageUrls.length + 1) : 0,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          if (index == imageUrls.length) {
            return Visibility(
              visible: imageUrls.length >= 10,
              child: Container(
                key: ValueKey(index),
                alignment: Alignment.center,
                width: width ?? 150,
                height: height ?? 225,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 40,
                  ),
                  onPressed: () {
                    onViewAllClick?.call();
                  },
                ),
              ),
            );
          }
          return Padding(
            key: ValueKey(imageUrls[index]),
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: context.colorTheme.background,
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ExtendedImageCreator(
                    imageUrl: imageUrls[index],
                    width: width ?? 150,
                    height: height ?? 225,
                    fit: BoxFit.fill,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        onItemClick?.call(index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
