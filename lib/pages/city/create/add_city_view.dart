import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:orange_doctor_dashboard/pages/city/components/count_info.dart';
import 'package:orange_doctor_dashboard/pages/city/components/doctor_info_card.dart';
import 'package:orange_doctor_dashboard/pages/city/components/filters.dart';
import 'package:orange_doctor_dashboard/pages/city/components/search_input.dart';
import 'package:orange_doctor_dashboard/widgets/single_select_city.dart';

import '../../../constants/text_style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/pagination.dart';
import '../../../widgets/single_select.dart';

class AddCityView extends StatefulWidget {
  const AddCityView({super.key});

  @override
  State<AddCityView> createState() => _AddCityViewState();
}

class _AddCityViewState extends State<AddCityView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPage = 1;
  final TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  callback(page) {
    setState(() {
      currentPage = page;
    });
  }

  List<String> _cities = [
    'Default',
    'Bangalore',
    'Mumbai',
    'Hyderabad',
    'Pune',
    'Delhi',
    'NCR',
    'Kolkata',
    'Chennai'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(showback: true, scaffoldKey: scaffoldKey),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add City",
                        style: CustomFonts.poppins20W600(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: HexColor("#FF724C"),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Text(
                              "Minimize",
                              style: CustomFonts.poppins14W600(
                                  color: Colors.white),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_up_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor("#FFE8BF"),
                    ),
                    child: Column(
                      children: [
                        SingleSelect(
                          label: "Brand",
                          items: const [
                            {'_id': "1", 'name': "Default"},
                            {'_id': "2", 'name': "Orange Brand"},
                            {'_id': "3", 'name': "Precilo"},
                            {'_id': "4", 'name': "Nutrelis"},
                          ],
                          onTap: (String value) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SingleSelect(
                          label: "Specialization",
                          items: const [
                            {'_id': "1", 'name': "Default"},
                            {'_id': "2", 'name': "Dental"},
                            {'_id': "3", 'name': "Homeopathy"},
                            {'_id': "4", 'name': "Orthopedics"},
                          ],
                          onTap: (String value) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SingleSelectCity(
                          label: "View City",
                          items: _cities,
                          onEditName: (String newName, int index) {
                            _cities[index] = newName;
                            setState(() {
                              _cities = _cities;
                            });
                            print("Cities: $_cities");
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  hintText: "Add City",
                                  hintStyle: CustomFonts.poppins14W500(
                                      color: HexColor("#222425")),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 37,
                            width: 100,
                            decoration: BoxDecoration(
                              color: HexColor("#FF724C"),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Done',
                                style: CustomFonts.poppins14W700(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Filters(),
                  const SizedBox(
                    height: 15,
                  ),
                  SearchInput(
                    controller: _searchController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Doctor Details(147)",
                            style: CustomFonts.poppins20W600(),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Pagination(
                            pagesLenght: 10,
                            currentPage: currentPage,
                            callback: callback,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CountInfo(),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: HexColor("#FFF7E9"),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        for (int index = 0; index < 10; index++)
                          DoctorInfoCard(
                            index: index,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
