import 'package:collection/collection.dart';
import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TmdbPopMenu extends StatefulWidget {
  final List<PopMenuData> menus;
  final IconData? iconData;
  final double? iconSize;
  final int? currentSelectedIndex;
  final Function(int, String)? onSelectedItem;

  const TmdbPopMenu({
    super.key,
    required this.menus,
    this.iconData,
    this.iconSize,
    this.onSelectedItem,
    this.currentSelectedIndex,
  });

  @override
  State<TmdbPopMenu> createState() => _TmdbPopMenuState();
}

class _TmdbPopMenuState extends State<TmdbPopMenu> {
  late int selectedMenu;

  @override
  void initState() {
    super.initState();
    selectedMenu = widget.currentSelectedIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: Icon(
        widget.iconData,
        size: widget.iconSize,
      ),
      initialValue: selectedMenu,
      onSelected: (int selectedItem) {
        widget.onSelectedItem?.call(selectedItem, widget.menus[selectedItem].name);
        setState(() {
          selectedMenu = selectedItem;
        });
      },
      itemBuilder: (BuildContext context) {
        return widget.menus.mapIndexed(
          (index, element) {
            return PopupMenuItem<int>(
              value: index,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: element.data != null,
                    child: Icon(
                      element.data,
                      size: widget.iconSize,
                    ),
                  ),
                  Text(
                    element.name,
                    style: context.textTheme.titleMedium,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )
                ],
              ),
            );
          },
        ).toList();
      },
    );
  }
}

class PopMenuData {
  final String name;
  final IconData? data;

  PopMenuData({required this.name, this.data});

  factory PopMenuData.create({required String name, IconData? data}) {
    return PopMenuData(name: name, data: data);
  }
}
