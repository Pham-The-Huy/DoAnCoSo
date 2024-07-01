import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Thông Tin",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? CustomLoader()  // Hiển thị loader khi dữ liệu đang tải
                    : Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //profile icon
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize:
                                  Dimensions.height45 + Dimensions.height30,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //name
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.person,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text:
                                                userController.userModel.name)),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //phone
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.phone,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel.phone)),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //email
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.email,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel.email)),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //address
                                    GetBuilder<LocationController>(builder: (locationController){
                                      if(_userLoggedIn&&locationController.addressList.isEmpty){
                                        return GestureDetector(
                                          onTap: (){
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize: Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText:
                                              BigText(text: "Na/Na")
                                          ),
                                        );
                                      }else{
                                        return GestureDetector(
                                          onTap: (){
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize: Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText:
                                              BigText(text: "Địa chỉ của bạn")
                                          ),
                                        );
                                      }
                                    }),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //message
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Tin nhắn")),
                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //message
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          print("Ban da dang xuat");
                                        }
                                      },
                                      child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.logout,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: "Đăng Xuất")),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                : Container(
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20*8,
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/empty-cart.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20*5,
                            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(child: BigText(text: "Đăng nhập", color: Colors.white,size: Dimensions.font26,)),
                          ),
                        ),
                      ],
                    )),
                  );
          },
        ));
  }
}
