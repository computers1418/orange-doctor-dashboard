import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppbar extends StatelessWidget {
  final scaffoldKey;
  final bool showback;
  final Widget? title;
  final bool showDrawer;

  const CustomAppbar(
      {Key? key,
      required this.showback,
      required this.scaffoldKey,
      this.title,
      this.showDrawer = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#FF724C"),
      padding: const EdgeInsets.only(top: 30, bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showback
                ? InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "assets/images/back.png",
                      height: 30,
                      width: 30,
                    ),
                  )
                : SizedBox(),
            if (title != null)
              Expanded(
                child: title ?? const SizedBox(),
              ),
            showDrawer
                ? InkWell(
                    onTap: () => scaffoldKey.currentState.openEndDrawer(),
                    child: Image.asset(
                      "assets/images/menu.png",
                      height: 30,
                      width: 30,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
