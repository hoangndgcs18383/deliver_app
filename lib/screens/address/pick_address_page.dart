import 'package:deliver_app/base/custom_button.dart';
import 'package:deliver_app/controllers/location_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PickAddressPage extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddressArea;
  final GoogleMapController? googleMapController;
  const PickAddressPage({
    Key? key,
    required this.fromSignUp,
    required this.fromAddressArea,
    this.googleMapController
  }) : super(key: key);

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  late LatLng _initPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initPosition = LatLng(10.8467138, 106.7918561);
      _cameraPosition = CameraPosition(target: _initPosition, zoom: 17);
    }
    else {
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
        );
        _cameraPosition = CameraPosition(target: _initPosition, zoom: 17);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(target:
                  _initPosition, zoom: 17
                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.loading ?
                      Image.asset("assets/image/pick_marker.png",
                        height: 50,
                        width: 50,
                    ) : CircularProgressIndicator(),
                  ),
                  Positioned(
                      top: Dimemsions.height45,
                      left: Dimemsions.width20,
                      right: Dimemsions.width20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimemsions.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimemsions.radius20/2),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, size: 25, color: AppColors.yellowColor,),
                            Expanded(child: Text('${locationController.pickPlacemark.name ?? ''}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimemsions.font16
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 80,
                      left: Dimemsions.width20,
                      right: Dimemsions.width20,
                      child: locationController.isLoading ?
                      Center(child: CircularProgressIndicator()) :
                      CustomButton(
                        buttonText: locationController.inZone ?
                        widget.fromAddressArea ?
                        'Pick address' : 'Pick Location' : 'Service is not available in your area',
                        onPress: (locationController.buttonDisable || locationController.loading) ? null : () {
                          if(locationController.pickPosition.latitude != 0 &&
                              locationController.pickPlacemark.name != null){
                            if(widget.fromAddressArea){
                              if(widget.googleMapController != null){
                                print("Now clicked");
                                widget.googleMapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                              locationController.pickPosition.latitude,
                                              locationController.pickPosition.longitude
                                            ))));
                                locationController.setAddressData();
                              }
                              Get.toNamed(RouteHelper.getAddAddressPage());
                            }
                          }
                        },
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
