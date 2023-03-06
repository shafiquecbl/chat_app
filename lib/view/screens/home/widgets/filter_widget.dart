import 'package:chat_app/controller/search_controller.dart';
import 'package:chat_app/utils/icons.dart';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.filter_list_rounded,
                color: Theme.of(context).primaryColor),
            const SizedBox(width: 5),
            Text('Filter',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: fontWeightBold,
                    color: Theme.of(context).primaryColor)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            _dropDownText(
                'Sex',
                (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('All'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Male'),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Text('Female'),
                      ),
                      const PopupMenuItem(
                        value: 4,
                        child: Text('Other'),
                      ),
                    ], (value) {
              SearchController.to.filterUsersBySex(value);
            }),
            const SizedBox(width: 10),
            _dropDownText(
                'Age',
                (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('All'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('18-25'),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Text('25-35'),
                      ),
                      const PopupMenuItem(
                        value: 4,
                        child: Text('35-45'),
                      ),
                      const PopupMenuItem(
                        value: 5,
                        child: Text('45-55'),
                      ),
                      const PopupMenuItem(
                        value: 6,
                        child: Text('55-65'),
                      ),
                      const PopupMenuItem(
                        value: 7,
                        child: Text('65+'),
                      ),
                    ], (value) {
              SearchController.to.filterUserByAgeRange(value);
            }),
            const SizedBox(width: 10),
            _dropDownText(
                'Location',
                (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Option 1'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Option 2'),
                      ),
                    ],
                (value) {}),
          ],
        ),
      ],
    );
  }

  _dropDownText(
          String text,
          List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder,
          void Function(dynamic)? onSelected) =>
      PopupMenuButton(
        itemBuilder: itemBuilder,
        onSelected: onSelected,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Wrap(
            spacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(text, style: const TextStyle(fontSize: 12)),
              Icon(FFIcons.downArrow,
                  size: 15, color: Theme.of(context).hintColor),
            ],
          ),
        ),
      );
}
