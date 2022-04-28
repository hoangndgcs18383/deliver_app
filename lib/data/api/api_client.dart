import 'package:deliver_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    _mainHeaders = {
      "Content-type" : "application/json; charset=UTF-8",
      "Authorization" : "Bearer $token",
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      "Content-type" : "application/json; charset=UTF-8",
      "Authorization" : "Bearer $token",
    };
  }

  Future<Response> getData(String url, {Map<String, String>? headers}) async{
    try {
      Response response = await get(url,
          headers : headers ?? _mainHeaders
      );
      return response;
    } catch(e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  //api call
  Future<Response> postData(String url, dynamic body) async {
    try {
      Response response = await post(url, body, headers: _mainHeaders);
      return response;
    } catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}