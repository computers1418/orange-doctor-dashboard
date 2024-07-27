import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandListCard extends StatelessWidget {
  final String brandId;
  final String brandName;
  final String createdOn;
  final Function deleteFun;
  const BrandListCard(
      {super.key,
      required this.brandId,
      required this.brandName,
      required this.createdOn,
      required this.deleteFun});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0XFFF8E3BD)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("No.",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF222425).withOpacity(.5))),
                      Text("$brandId .",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF222425)))
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Brand.",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF222425).withOpacity(.5))),
                      Text(brandName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0XFF222425)))
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  children: [
                    Text(
                      "Created on ",
                      style: GoogleFonts.poppins(
                          color: const Color(0XFF222425).withOpacity(.5),
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      createdOn,
                      style: GoogleFonts.poppins(
                          color: const Color(0XFF222425),
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              deleteFun();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0XFFFFFFFF),
              backgroundColor: const Color(0XFFFF724C),
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
              child: Text(
                "Delete",
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFFFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
