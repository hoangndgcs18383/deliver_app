class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

/*  static const String BASE_URL = "http://10.0.2.2:8000";*/
  static const String BASE_URL = "http://mvs.bslmeiyu.com";


  static const String SENT_URL = "http://127.0.0.1:8000";

  static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URL = "/api/v1/products/recommended";
  static const String DRINK_URL = "/api/v1/products/drinks";
  static const String UPLOAD_URL = "/uploads/";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String USER_ADDRESS = "user_address";

  //auth end point
  static const String REGISTRATION_URL = "/api/v1/auth/register";
  static const String LOGIN_URL = "/api/v1/auth/login";
  static const String USER_INFO_URL = "/api/v1/customer/info";
  static const String ADD_USER_ADDRESS_URL = "/api/v1/customer/address/add";
  static const String ADDDRESS_LIST_URL = "/api/v1/customer/address/list";
  static const String GEOCODE_URL = "/api/v1/config/geocode-api";
  static const String ZONE_URL = "/api/v1/config/get-zone-id";

  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}