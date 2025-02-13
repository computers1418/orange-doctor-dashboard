import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/text_style.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchInput({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: HexColor("#FFF7E9"),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: "Search here",
                hintStyle:
                    CustomFonts.poppins14W500(color: HexColor("#40664D21")),
                border: InputBorder.none,
              ),
              controller: controller,
              onChanged: onChanged,
            ),
            Positioned(
              right: 0,
              height: 34,
              width: 34,
              child: CircleAvatar(
                backgroundColor: HexColor("#FF724C"),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
