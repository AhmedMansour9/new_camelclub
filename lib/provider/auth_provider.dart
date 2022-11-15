import 'package:flutter/foundation.dart';
import 'package:new_camelclub/data/model/response/base/api_response.dart';
import 'package:new_camelclub/data/model/response/base/error_response.dart';
import 'package:new_camelclub/data/model/response/response_model.dart';
import 'package:new_camelclub/data/model/response/signup_model.dart';
import 'package:new_camelclub/data/repository/auth_repo.dart';
import 'package:new_camelclub/utill/strings.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  // for registration section
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _registrationErrorMessage = '';

  String get registrationErrorMessage => _registrationErrorMessage;

  updateRegistrationErrorMessage(String message) {
    _registrationErrorMessage = message;
    notifyListeners();
  }

  Future<ResponseModel> registration(SignUpModel signUpModel) async { //3 - complete user data
    _isLoading = true;
    _registrationErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(signUpModel);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
     /* Map map = apiResponse.response.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();*/

      authRepo.saveIsRegistered("token");
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage="";
      if (apiResponse.message is String) {
        errorMessage = apiResponse.message.toString();
      }
      print(errorMessage);
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  // for login section
  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(email: email, password: password);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      Map map = apiResponse.response?.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.message is String) {
        errorMessage = apiResponse.message.toString();
      } else {
        errorMessage = apiResponse.message.messages[0].message;
      }
      print(errorMessage);
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  // for forgot password
  bool _isForgotPasswordLoading = false;

  bool get isForgotPasswordLoading => _isForgotPasswordLoading;

  Future<ResponseModel> forgetPassword(String email) async {
    _isForgotPasswordLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isForgotPasswordLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response?.data["message"]);
    } else {
      String errorMessage="";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    return responseModel;
  }

  Future<void> updateToken() async {
    ApiResponse apiResponse = await authRepo.updateToken();
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {

    } else {
      String errorMessage;
      if (apiResponse.message is String) {
        errorMessage = apiResponse.message.toString();
      } else {
        errorMessage = apiResponse.message.messages[0].message;
      }
      print(errorMessage);
    }
  }

  Future<ResponseModel> verifyToken(String email) async {
    _isPhoneNumberVerificationButtonLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.verifyToken(email, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {

      String? userId=apiResponse.response?.data["result"]["user"]["userId"].toString();

      responseModel = ResponseModel(apiResponse.response?.data["statusEnum"].toString() == "success" ? true : false, apiResponse.response?.data["message"],userId: userId );
      _verificationMsg = apiResponse.response?.data["message"] ;

      if(apiResponse.response?.data["statusEnum"].toString() == "success"){
      String token=apiResponse.response?.data["result"]["token"];
        authRepo.saveUserToken(token);
      }

      // responseModel = ResponseModel(true, apiResponse.response?.data["message"]);
    } else {
      String errorMessage="";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    return responseModel;
  }

  Future<ResponseModel> resetPassword(String resetToken, String password, String confirmPassword) async {
    _isForgotPasswordLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.resetPassword(resetToken, password, confirmPassword);
    _isForgotPasswordLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(true, apiResponse.response?.data["message"]);
    } else {
      String errorMessage="";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    return responseModel;
  }

  // for phone verification
  bool _isPhoneNumberVerificationButtonLoading = false;

  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;
  String _verificationMsg = '';

  String get verificationMessage => _verificationMsg;
  String _email = '';

  String get email => _email;

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void clearVerificationMessage() {
    _verificationMsg = '';
  }

  Future<ResponseModel> checkEmail(String email,String password) async {//1 - check phone number
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.checkEmail(email,password);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      // Map map = apiResponse.response?.data["result"]["token"];
      // String token = map["token"];
      // print('token is $token');
      // authRepo.saveUserToken(token);

      // bool skip_otp = apiResponse.response?.data["skip_otp"]??false;

      // if(skip_otp&&!(map['is_new_user']as bool)){
      //   authRepo.saveIsRegistered(token);
      // }

      String? userId=apiResponse.response?.data["result"]["user"]["userId"].toString();
      String? phone=apiResponse.response?.data["result"]["user"]["identityNumber"].toString();

      responseModel = ResponseModel(apiResponse.response?.data["statusEnum"].toString() == "success" ? true : false, apiResponse.response?.data["message"],userId: userId,phone: phone );
        _verificationMsg = apiResponse.response?.data["message"] ;
    } else {
      String errorMessage="";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email) async {//2 - chek opt is right or not
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.verifyEmail(email, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {

      Map map = apiResponse.response?.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();

      print('type is ${map['is_new_user'].toString()}');
      if(!(map['is_new_user']as bool))
        authRepo.saveIsRegistered("token");
      responseModel = ResponseModel(true, map["message"],is_user: map['is_new_user']as bool);
    } else {
      String errorMessage="";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }

      responseModel = ResponseModel(false, errorMessage);
      _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }


  // for verification Code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }

  // for Remember Me Section

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    _isLoading = true;
    notifyListeners();
    bool _isSuccess = await authRepo.clearSharedData();
    _isLoading = false;
    notifyListeners();
    return _isSuccess;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }
  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }


}
