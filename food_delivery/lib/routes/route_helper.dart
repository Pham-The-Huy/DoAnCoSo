import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/address/add_address_page.dart';
import '../pages/address/pick_address_map.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";

  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage()=> '$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';

  static List<GetPage> route = [
    GetPage(name:pickAddressMap, page:(){
      PickAddressMap _pickAddress= Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () {
      return HomePage();
    }, transition: Transition.fade),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fade),
    GetPage(
      name: popularFood,
      page: () {
        print("popular food detail");
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        print("recommended food detail");
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
      name: addAddress,
      page: (){
        return AddAddressPage();
      }
    ),
  ];
}
