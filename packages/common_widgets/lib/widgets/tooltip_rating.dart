import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TooltipRating extends StatefulWidget {
  final double? iconSize;
  final double rating;
  final String? hoverMessage;
  final Function(double)? onRatingUpdate;

  const TooltipRating({
    super.key,
    required this.rating,
    this.onRatingUpdate,
    this.iconSize,
    this.hoverMessage,
  });

  @override
  State<TooltipRating> createState() => _TooltipRatingState();
}

class _TooltipRatingState extends State<TooltipRating> {
  final SuperTooltipController _controller = SuperTooltipController();
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    rating = rating;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _controller.showTooltip();
      },
      child: Tooltip(
        message: widget.hoverMessage ?? "",
        decoration: BoxDecoration(color: context.colorTheme.background),
        textStyle: context.textTheme.titleMedium,
        child: SuperTooltip(
          controller: _controller,
          hideTooltipOnTap: true,
          child: Material(
            color: context.colorTheme.background,
            shape: const CircleBorder(),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.star,
                color: rating != 0 ? Colors.amber : context.colorTheme.onBackground,
                size: widget.iconSize ?? 30,
              ),
            ),
          ),
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: RatingBar.builder(
              itemSize: (widget.iconSize ?? 20) + 10,
              initialRating: rating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              tapOnlyMode: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                widget.onRatingUpdate?.call(rating);
                setState(() {
                  this.rating = rating;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
