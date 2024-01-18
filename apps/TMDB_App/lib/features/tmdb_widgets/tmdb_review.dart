import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TmdbReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorTheme.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  backgroundColor: context.colorTheme.primary,
                  // Replace with actual image or initial
                  child: Text(
                    'P',
                    style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorTheme.onPrimary, fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A review by pimpskitters',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: context.colorTheme.primary,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: context.colorTheme.onPrimary,
                                  size: 15,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '3.0',
                                  style: context.textTheme.titleSmall?.copyWith(
                                      color: context.colorTheme.onPrimary,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Written by pimpskitters on January 17, 2024',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Its not just that Larson is deeply uncharismatic, or that now the whole marvel '
              'thing reeks of try hard desperation to restart the previous two decades longest running gravy train. '
              'Its mostly that all of the marvel movies always have been, low grade cartoons for lame brained adults. '
              'The fuckheads who slurped it all are now pretending like this is any worse, it isn\'t. '
              'Its the same thing, and you wasted a lifetime of watching hours on all the other marvel nonsense, you lose.',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
