import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app/colors.dart';
import '../../app/dimensions.dart';
import '../../base/custom_button.dart';
import '../../controllers/location_controller.dart';
import '../../routes/route_helper.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap ({Key? key, required this.fromSignup, required this.fromAddress,
    this.googleMapController
  }) : super(key: key);

  @override
  _PickAddressMapState createState() => _PickAddressMapState();

}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initalPosition=LatLng(45.521563, -122.677433);
      _cameraPosition=CameraPosition(target: _initalPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosition=LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition=CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
          body:SafeArea(
              child: Center(
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Stack(
                        children: [
                          GoogleMap(initialCameraPosition: CameraPosition(
                              target: _initalPosition, zoom: 17

                          ),
                              zoomControlsEnabled: false,
                              onCameraMove: (CameraPosition cameraPosition){
                                _cameraPosition=cameraPosition;
                              },
                              onCameraIdle: (){
                                Get.find<LocationController>().updatePosition(_cameraPosition, false);
                              }
                          ),
                          Center(
                            child:!locationController.loading?Image.asset("assets/images/empty-cart.png",
                              height: 50, width: 50,
                            ):CircularProgressIndicator()
                            ),
                          Positioned(
                            top: Dimensions.height45,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(Dimensions.radius20/2)
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, size: 25, color: AppColors.yellowColor),
                                  Expanded(child: Text(
                                    '${locationController.pickPlacemark.name??''}',
                                    style: TextStyle(
                                      color:Colors.white,
                                      fontSize: Dimensions.font16
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                                ],
                              )
                            )
                          ),
                          Positioned(
                            bottom: 80,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            child: !locationController.isLading?Center(child: CircularProgressIndicator(),): CustomButton(

                              buttonText: locationController.inZone?widget.fromAddress?'Pick Address': 'Pick Location':'Service is not available in your area',
                              onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                                if(locationController.pickPosition.latitude!=0&&
                                    locationController.pickPlacemark.name!=null){
                                  if(widget.fromAddress){
                                    if(widget.googleMapController!=null){
                                      print("Bây giờ bạn có thể ấn vào đây");
                                      widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                          locationController.pickPosition.latitude,
                                          locationController.pickPosition.longitude
                                      ))));
                                      locationController.setAddAddressData();
                                    }
                                    //Get.back() creates update proble
                                    //list, a value
                                    Get.toNamed(RouteHelper.getAddressPage());
                                  }
                                }
                              },

                            )

                          )
                        ],
                      )
                  )
              )
          )
      );
    });
  }
}