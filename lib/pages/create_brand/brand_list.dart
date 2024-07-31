import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orange_doctor_dashboard/constants/text_style.dart';
import 'package:orange_doctor_dashboard/controllers/brand_controller.dart';
import 'package:orange_doctor_dashboard/pages/create_brand/components/brand_list_card.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  TextEditingController brandNameController = TextEditingController();

  BrandController brandController = Get.put(BrandController());
  FToast? fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFF724C),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/back.png",
            height: 30,
            width: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                "assets/images/menu.png",
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => brandController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            "Create Brand",
                            style: CustomFonts.poppins24W700(
                                color: const Color(0XFF222425)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          decoration: const BoxDecoration(
                              color: Color(0XFFFFE8BF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 20),
                                child: TextFormField(
                                  controller: brandNameController,
                                  decoration: InputDecoration(
                                      hintText: "Brand Name",
                                      filled: true,
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 20, bottom: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _submit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0XFFFFFFFF),
                                      backgroundColor: const Color(0XFFFF724C),
                                      padding: EdgeInsets.zero),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    child: Text("Save"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            "Brand Name List (${brandController.brandModel.value.data.length})",
                            style: CustomFonts.poppins24W700(
                                color: const Color(0XFF222425)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.only(top: 15, bottom: 43),
                          decoration: const BoxDecoration(
                            color: Color(0XFFFFF7E9),
                            border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0XFFF8E3BD)),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                brandController.brandModel.value.data.length,
                            itemBuilder: (context, index) {
                              var listdata =
                                  brandController.brandModel.value.data[index];
                              return BrandListCard(
                                brandId: (index + 1).toString(),
                                brandName: listdata.name,
                                createdOn: listdata.createdAt.toString(),
                                deleteFun: () {
                                  _delete(listdata.id, fToast);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _submit() {
    brandController.createBrandList(brandNameController.text, fToast!);
  }

  void _delete(brandId, fToast) {
    brandController.deleteList(brandId, fToast);
  }
}
