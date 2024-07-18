import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/app/app_constants.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/app/styles.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;
  PaymentPage({required this.orderModel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedBank;
  String accountNumber = '';
  String accountName = '';
  String amount = '';
  String transferContent = '';

  List<String> banks = [
    'MBBank (MB)',
    'Vietinbank (CTG)',
    'BIDV',
    'Agribank (VBA)',
    'Vietcombank (VCB)',
    'VPBank (VPB)',
    'VIB',
    'SHB',
    'Eximbank (EIB)',
    'TPBank (TPB)',
    'Cake by VP',
  ];

  bool _isSuccess = false;
  bool _isFailed = false;
  bool _isCancel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BigText(
          text: "Thanh toán",
          color: AppColors.blackColor,
        ),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
          onPressed: () {
            Get.toNamed(RouteHelper.getCartPage());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: "Nhập thông tin"),
                SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Ngân hàng',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: AppColors.mainColor, width: 2.0),
                    ),
                    // focusedErrorBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8.0),
                    //   borderSide:
                    //       BorderSide(color: AppColors.mainColor, width: 2.0),
                    // ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.radius20),
                                  topRight:
                                      Radius.circular(Dimensions.radius20)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height10 / 2,
                                  left: Dimensions.width10 / 2,
                                  bottom: Dimensions.height10 / 2),
                              child: ListView.builder(
                                itemCount: banks.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20 / 4),
                                            // color: Theme.of(context).cardColor,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[200]!,
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                              )
                                            ]),
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: Dimensions.width10,
                                                right: Dimensions.width10,
                                                top: Dimensions.height10,
                                                bottom: Dimensions.height10),
                                            child: Text(
                                              banks[index],
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions.font16),
                                            ))),
                                    onTap: () {
                                      setState(() {
                                        selectedBank = banks[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            ));
                      },
                    );
                  },
                  validator: (value) {
                    if (selectedBank == null) {
                      return 'Vui lòng chọn ngân hàng';
                    }
                    return null;
                  },
                  controller: TextEditingController(text: selectedBank),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Số tài khoản',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: AppColors.mainColor, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      accountNumber = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số tài khoản';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tên tài khoản',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: AppColors.mainColor, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      accountName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên tài khoản';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission here
                        Get.offNamed(RouteHelper.getOrderSuccessPage(
                            widget.orderModel.id.toString(), 'success'));
                      }
                    },
                    child: Text('Tiếp tục',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
