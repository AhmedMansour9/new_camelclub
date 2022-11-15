import 'package:new_camelclub/data/model/response/language_model.dart';
import 'package:new_camelclub/utill/images.dart';

class AppConstants {

  static const String APP_NAME = 'awzan';

 // static const String BASE_URL = 'https://demo.6amtech.com/restaurant';
 //  static const String BASE_URL = 'https://awzanstore.com';
  static const String BASE_URL = 'http://mahmoudabd2345-002-site4.ctempurl.com';
  static const String CATEGORY_URI = '/api/v1/categories';
  static const String BANNER_URI = '/api/v1/banners?position=middle';
  static const String TOP_BANNER_URI = '/api/v1/banners?position=top';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/latest';
  static const String SEARCH_PRODUCT_URI = '/api/v1/products/details/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products/';
  static const String CONFIG_URI = '/api/v1/config';
  static const String SLOTS = '/api/v1/timeSlot';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String MESSAGE_URI = '/api/v1/customer/message/get';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/message/send';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/Account/VerificationCode';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/otp-login';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/check-otp-code';//2
  static const String REGISTER_URI = '/api/v1/auth/otp-register';//3
  static const String LOGIN_URI = '/api/Account/Login';
  static const String PRICESCART_URI = '/api/v1/products/check-price';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String CALCULATION_RECEIPT_URI = '/api/v1/customer/order/create-receipt';
  static const String GET_BALANCE = '/api/v1/customer/get-balance-value';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String REMOVE_ADDRESS_URI = '/api/v1/customer/address/delete?address_id=';
  static const String SEND_ADDRESS = '/api/v1/customer/address/set-as-current/';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String SET_MENU_URI = '/api/v1/products/set-menu';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';
  static const String COUPON_URI = '/api/v1/coupon/list';
  static const String COUPON_APPLY_URI = '/api/v1/coupon/apply?code=';
  static const String ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String UPDATE_METHOD_URI = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI = '/api/v1/customer/order/details?order_id=';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?product_id=';
  static const String REMOVE_WISH_LIST_URI = '/api/v1/customer/wish-list/remove?product_id=';
  static const String NOTIFICATION_URI = '/api/v1/notifications';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String SEARCH_URI = '/api/v1/products/search?name=';
  static const String REVIEW_URI = '/api/v1/products/reviews/submit';
  static const String PRODUCT_DETAILS_URI = '/api/v1/products/details/';
  static const String LAST_LOCATION_URI = '/api/v1/delivery-man/last-location?order_id=';
  static const String DELIVER_MAN_REVIEW_URI = '/api/v1/delivery-man/reviews/submit';
  // static const String GOOGLE_API = 'AIzaSyBR7CVXoCQgMp5a7zbUcsNVCULq1rkRAvg';
  static const String GOOGLE_API = 'AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String FIRST_TIME = 'first';
  static const String FIRST_TIME_ONBOARDING = 'first_onboard';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String COUPON = 'coupon';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String CART_MP3 = 'song_cart.mp3';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.united_kindom, languageName: 'English', countryCode: 'US', languageCode: 'en'),

    LanguageModel(imageUrl: Images.arabic, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),

  ];


}
