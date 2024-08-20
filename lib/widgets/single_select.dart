import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleSelect extends StatefulWidget {
  final List<Map> items;
  final String label;
  final bool invert;
  final ValueChanged<String> onTap;
  final String value;

  const SingleSelect({
    super.key,
    required this.items,
    required this.label,
    this.invert = false,
    required this.onTap,
    this.value = "",
  });

  @override
  State<SingleSelect> createState() => _SingleSelectState();
}

class _SingleSelectState extends State<SingleSelect> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        widget.invert ? Colors.white : const Color(0xFF222425)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        selectedItemBuilder: (_) {
          return widget.items.map((e) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                e['name'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: widget.invert ? Colors.white : null),
                // overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList();
        },
        items: widget.items
            .map((dynamic item) => DropdownMenuItem<String>(
                  value: item["${widget.value}"],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      if (widget.items.indexOf(item) < widget.items.length - 1)
                        const Divider(
                          height: 0,
                          color: Color(0x33FFFFFF),
                        )
                    ],
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          widget.onTap(value!);
        },
        buttonStyleData: ButtonStyleData(
          height: widget.invert ? 42 : 48,
          padding: const EdgeInsets.only(left: 0, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.invert ? HexColor("#FF724C") : Colors.white,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          iconSize: 24,
          iconEnabledColor: widget.invert ? Colors.white : Colors.black,
          iconDisabledColor: widget.invert ? Colors.white : Colors.black,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          // padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xEFFF724C),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: Color(0x1A000000)),
              ]),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 42,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
