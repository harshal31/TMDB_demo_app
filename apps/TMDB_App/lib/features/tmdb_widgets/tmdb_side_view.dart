import 'package:common_widgets/localizations/localized_extension.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TmdbSideView extends StatelessWidget {
  final tags = [
    'hero',
    'space travel',
    'sequel',
    'superhero',
    'based on comic',
    'teenage girl',
    'aftercreditsstinger',
    'duringcreditsstinger',
    'marvel cinematic universe (mcu)',
    'space adventure',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.status,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            "Released",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.originalLanguage,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            "En",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.budget,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            "\$2000",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.revenue,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            "\$1000",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr.keywords,
            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 8.0, // gap between lines
            children: List<Widget>.generate(tags.length, (int index) {
              return ActionChip(
                onPressed: () {},
                label: Text(
                  tags[index],
                  style: context.textTheme.titleSmall,
                ),
                backgroundColor: context.colorTheme.surface,
              );
            }),
          ),
        ],
      ),
    );
  }
}
