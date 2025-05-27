import 'dart:math';

import 'package:expense_tracker/utilities/extensions.dart/string_extension.dart';
import 'package:flutter/material.dart';

import '../utilities/app_theme.dart';

/// Custom bottom sheet calling method with feature of dynamic value selection from list type T
void valueSelectionBottomSheet<T>(
  BuildContext context, {
  required String headingText,
  required String valueKey,
  required String? selectedValue,
  String? selectedValueID,
  required void Function(Object)? onTap,
  required ValueNotifier<List<T>> filterList,
  final Widget Function(Object)? widgetItemBuilder,
  final Widget Function(List<T>)? listBuilder,
  required Size size,
  String? leadingValueKey,
  double? sheetHeight,
  bool showLeading = false,
  VisualDensity? tileVisualDensity = VisualDensity.compact,
  EdgeInsetsGeometry? tilePadding,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    backgroundColor: AppTheme.lightColor,
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return CustomBottomModalSheet(
        headingText: headingText,
        valueKey: valueKey,
        selectedValue: selectedValue,
        selectedValueID: selectedValueID,
        filterList: filterList,
        onTap: onTap,
        widgetItemBuilder: widgetItemBuilder,
        listBuilder: listBuilder,
        size: size,
        leadingValueKey: leadingValueKey,
        sheetHeight: sheetHeight,
        showLeading: showLeading,
        visualDensityTile: tileVisualDensity,
      );
    },
  );
}

/// Custom bottom sheet with feature of dynamic value selection from list
class CustomBottomModalSheet<T> extends StatelessWidget {
  final String headingText;
  final String valueKey;
  final String? selectedValue;
  final String? selectedValueID;
  final ValueNotifier<List<T>> filterList;
  final void Function(Object)? onTap;
  final Widget Function(Object)? widgetItemBuilder;
  final Widget Function(List<T>)? listBuilder;
  final Size size;
  final String? leadingValueKey;
  final double? sheetHeight;
  final bool showLeading;
  final VisualDensity? visualDensityTile;
  final EdgeInsetsGeometry? paddingTile;

  const CustomBottomModalSheet({
    super.key,
    required this.headingText,
    required this.valueKey,
    required this.selectedValue,
    this.selectedValueID,
    required this.filterList,
    required this.onTap,
    this.widgetItemBuilder,
    this.listBuilder,
    required this.size,
    this.leadingValueKey,
    this.sheetHeight,
    this.showLeading = false,
    this.visualDensityTile,
    this.paddingTile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: DraggableScrollableSheet(
        initialChildSize: sheetHeight ?? 0.75,
        snap: true,
        expand: false,
        builder: (_, controller) {
          return ValueListenableBuilder(
            valueListenable: filterList,
            builder: (context, filterList, widget) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.45, vertical: 8.0),
                  child: const Divider(
                    color: AppTheme.grey300Color,
                    thickness: 4,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    color: AppTheme.grey200Color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 5, start: 28, end: 10, bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        headingText,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppTheme.darkColor),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                filterList.isNotEmpty
                    ? Expanded(
                        child: Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: RawScrollbar(
                          thumbVisibility: true,
                          thumbColor: AppTheme.greyTextColor,
                          child: listBuilder != null
                              ? listBuilder!(filterList)
                              : ListView.builder(
                                  itemCount: filterList.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  itemBuilder: (context, index) {
                                    dynamic element = filterList[index];
                                    if (widgetItemBuilder != null) {
                                      return widgetItemBuilder!(element);
                                    }
                                    bool isSelectedValue = false;
                                    bool elementTypeString = false;
                                    try {
                                      if (element is String || element.runtimeType == String) {
                                        elementTypeString = true;
                                        isSelectedValue = selectedValue.isNotNullAndNotEmptyAndEquals(element);
                                      } else if (selectedValueID.isNotNullAndNotEmpty) {
                                        isSelectedValue = selectedValueID.isNotNullAndNotEmptyAndEquals(element.id);
                                      } else {
                                        isSelectedValue = selectedValue.isNotNullAndNotEmptyAndEquals(element.name);
                                      }
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }

                                    return isSelectedValue
                                        ? Padding(
                                            padding: paddingTile ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                            child: Material(
                                              elevation: 10,
                                              shadowColor: AppTheme.grey200Color.withOpacity(0.5),
                                              color: AppTheme.lightColor,
                                              child: ListTile(
                                                titleAlignment: ListTileTitleAlignment.center,
                                                title: Text(
                                                  "${elementTypeString ? element : element.name}",
                                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppTheme.darkColor),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                trailing: const Icon(
                                                  Icons.check,
                                                  color: AppTheme.accentColor,
                                                ),
                                                contentPadding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                                                onTap: onTap != null ? () => onTap!(element) : null,
                                                visualDensity: visualDensityTile,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: paddingTile ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            child: ListTile(
                                              contentPadding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                                              titleAlignment: ListTileTitleAlignment.center,
                                              title: Text(
                                                "${elementTypeString ? element : element.name}",
                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppTheme.darkColor),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: onTap != null ? () => onTap!(element) : null,
                                              visualDensity: visualDensityTile,
                                            ),
                                          );
                                  }),
                        ),
                      ))
                    : const Expanded(
                        child: Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 18, color: AppTheme.greyTextColor),
                        ),
                      ))
              ],
            ),
          );
        },
      ),
    );
  }
}
