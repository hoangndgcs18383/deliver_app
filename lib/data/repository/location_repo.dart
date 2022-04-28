import 'package:deliver_app/data/api/api_client.dart';
import 'package:deliver_app/models/address_model.dart';
import 'package:deliver_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({ required this.apiClient, required this.sharedPreferences });

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URL}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

  Future<Response> addAddress(AddressModel addressModel) async{
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS_URL, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDDRESS_LIST_URL);
  }

  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URL}?lat=$lat&lng=$lng');
  }
}