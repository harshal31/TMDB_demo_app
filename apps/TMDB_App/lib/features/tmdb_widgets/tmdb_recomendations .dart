import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TmdbRecomendations extends StatelessWidget {
  final imageUrls = [
    "https://image.tmdb.org/t/p/original/Ag3D9qXjhJ2FUkrlJ0Cv1pgxqYQ.jpg",
    "https://image.tmdb.org/t/p/original/3b8VyzOHZKBTnbLGR7PriCV1C06.jpg",
    "https://image.tmdb.org/t/p/original/vpuuFM032yiX8tox4L84Wl9MGjG.jpg",
    "https://image.tmdb.org/t/p/original/9GBhzXMFjgcZ3FdR9w3bUMMTps5.jpg",
    "https://image.tmdb.org/t/p/original/Ag3D9qXjhJ2FUkrlJ0Cv1pgxqYQ.jpg",
    "https://image.tmdb.org/t/p/original/3b8VyzOHZKBTnbLGR7PriCV1C06.jpg",
    "https://image.tmdb.org/t/p/original/vpuuFM032yiX8tox4L84Wl9MGjG.jpg",
    "https://image.tmdb.org/t/p/original/9GBhzXMFjgcZ3FdR9w3bUMMTps5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 141,
      child: ListView.builder(
        itemCount: imageUrls.length + 1,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          if (index == imageUrls.length) {
            return Container(
              key: ValueKey(index),
              alignment: Alignment.center,
              width: 250,
              height: 141,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_double_arrow_right_sharp,
                  size: 40,
                ),
                onPressed: () {},
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ExtendedImage.network(
              imageUrls[index],
              width: 250,
              height: 141,
              fit: BoxFit.fill,
              cache: true,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              cacheMaxAge: Duration(hours: 1),
            ),
          );
        },
      ),
    );
  }
}
