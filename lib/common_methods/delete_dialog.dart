import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/text_style.dart';

class DeleteDialog extends StatefulWidget {
  final VoidCallback onTap;
  final String? text;

  const DeleteDialog(
      {super.key,
      required this.onTap,
      this.text = "Are you sure want to delete?"});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 30,
                  offset: Offset(0, -10))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/icon.png",
              height: 68,
              width: 68,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.text!.isEmpty
                  ? "Are you sure want to delete?"
                  : widget.text!,
              style: CustomFonts.poppins16W600(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: HexColor("#222425"),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Cancel",
                        style: CustomFonts.poppins14W500(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: HexColor("#FF724C"),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Okay",
                        style: CustomFonts.poppins14W500(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: widget.onTap,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 47,
            ),
          ],
        ));
  }
}
