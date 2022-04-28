import 'package:deliver_app/controllers/auth_controller.dart';
import 'package:deliver_app/controllers/location_controller.dart';
import 'package:deliver_app/controllers/user_controller.dart';
import 'package:deliver_app/models/address_model.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/screens/address/pick_address_page.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_text_field.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(
          10.8467138, 106.7918561), zoom: 17);

  late LatLng _initialPosition = LatLng(
      10.8467138, 106.7918561);

  Future<void> requestPermission() async { await Permission.location.request(); }

  @override
  void initState(){
    requestPermission();
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel == null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage() == ""){
        Get.find<LocationController>().saveUserAddress(
            Get.find<LocationController>()
                .addressList
                .last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address page'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel != null && _contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.postalCode ?? ''}'
              '${locationController.placemark.country ?? ''}';
          print('address in my view is '+ _addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 2,
                          color: AppColors.mainColor
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                        onTap: (latLng){
                          Get.toNamed(RouteHelper.getPickAddressPage(),
                            arguments: PickAddressPage(
                              fromSignUp: false,
                              fromAddressArea: true,
                              googleMapController: locationController.mapController,
                            )
                          );
                        },
                        buildingsEnabled: true,
                        zoomControlsEnabled: false,
                        compassEnabled: true,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onCameraIdle: () {
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position) => _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimemsions.width20, top: Dimemsions.height20),
                  child: SizedBox(height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimemsions.width20*2, vertical: Dimemsions.height10),
                          margin: EdgeInsets.only(right: Dimemsions.width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimemsions.radius20/4),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5,
                              )
                            ]
                          ),
                          child: Icon(
                            index == 0 ? Icons.home_filled : index == 1? Icons.work : Icons.location_on,
                            color: locationController.addressTypeList == index ? AppColors.mainColor : Theme.of(context).disabledColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: Dimemsions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimemsions.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimemsions.height10,),
                AppTextField(
                    textEditingController: _addressController,
                    hintText: "Your address",
                    icon: Icons.map),
                SizedBox(height: Dimemsions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimemsions.width20),
                  child: BigText(text: "Contact Name"),
                ),
                SizedBox(height: Dimemsions.height10,),
                AppTextField(
                    textEditingController: _contactPersonName,
                    hintText: "Your name",
                    icon: Icons.person),
                SizedBox(height: Dimemsions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimemsions.width20),
                  child: BigText(text: "Contact Number"),
                ),
                SizedBox(height: Dimemsions.height10,),
                AppTextField(
                    textEditingController: _contactPersonNumber,
                    hintText: "Your number",
                    icon: Icons.phone),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimemsions.height20*8,
              padding: EdgeInsets.only(
                  top: Dimemsions.height30,
                  bottom: Dimemsions.height30,
                  left: Dimemsions.width20,
                  right: Dimemsions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimemsions.radius20 * 2),
                      topRight: Radius.circular(Dimemsions.radius20 * 2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      var addressList = locationController.addressTypeList;
                      var addressIndex = locationController.addressTypeIndex;
                      AddressModel _addresModel = AddressModel(
                          addressType: addressList[addressIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString(),
                      );
                      locationController.addAddress(_addresModel).then((response) {
                        if(response.isSuccess){
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar("Address", "Address Successfully");
                        } else {
                          Get.snackbar("Address", "Couldn't save address");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimemsions.height20,
                          bottom: Dimemsions.height20,
                          left: Dimemsions.width20,
                          right: Dimemsions.width20),
                      child: BigText(
                        text: "Save address",
                        color: Colors.white,
                        size: 26,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimemsions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
