import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_camelclub/data/model/CategoryModel.dart';
import 'package:new_camelclub/data/model/response/base/api_response.dart';
import 'package:new_camelclub/data/model/response/language_model.dart';
import 'package:new_camelclub/data/model/response/regions_model.dart';
import 'package:new_camelclub/data/repository/category_repo.dart';
import 'package:new_camelclub/localization/language_constrants.dart';
import 'package:new_camelclub/utill/strings.dart';
import 'package:new_camelclub/view/screens/home/dialog_complete_checklist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_camelclub/helper/api_checker.dart';
import 'package:intl/intl.dart';

import '../data/model/requests_model.dart';
import '../data/model/response/CheckListModel.dart';
import '../data/model/response/SendReportRequestModel.dart';
import '../data/model/response/center_mode.dart';
import '../data/model/response/reports_model.dart';
import '../data/model/response/response_model.dart';
import '../data/model/send_filtertion_model.dart';
import '../utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../utill/routes.dart';
import '../view/base/custom_snackbar.dart';

class HomeProvider with ChangeNotifier {
  final CategoryRepo categoryRepo;
  final SharedPreferences sharedPreferences;

  HomeProvider({required this.categoryRepo, required this.sharedPreferences});

  String? fileUrl = null;

  List<Result>? _categoryList;
  List<ReportsModel> reportsList = [];
  List<ResultChechList>? _subcategoryList;
  List<RequestsFiltertionModel>? _requestsFiltertionList;
  int selectedPoistionCategory = 0;
  String selectedIdCategory = "";
  String selectedNameCategory = "";
  int countrer = 0;
  String? RegionId = null;
  String? OfficeId = null;
  String? TypeRequest = "1";
  String _verificationMsg = '';
  List<String> selectedItemsOffices = [];
  List<String> selectedItemsRegions = [];
  List<String> selectedItemsCategories = [];

  late List<String> FilterRegion = [];
  late List<String> FilterCategory = [];
  late List<String> FilterOffices = [];

  void changeCategoryPoistion(index) {
    selectedPoistionCategory = index;
    selectedIdCategory = _categoryList![index].id.toString();
    selectedNameCategory = getTitleCategory(index);
    getSubCategoryList(_categoryList![index].id.toString());
    notifyListeners();
  }

  checkFirstOpenStatus() {
    if (getUserType() == "technician") {
      TypeRequest = "1";
    } else {
      TypeRequest = null;
    }
  }

  String mappingList(List<String> titlesList) {
    List<String> list = titlesList;
    String ids = list.join(",");
    print('idds $ids');
    return ids;
  }

  int get categoryPoistion => selectedPoistionCategory;

  String? get idRegion => RegionId;

  String? get idOffice => OfficeId;

  List<Result>? get categoryList => _categoryList;

  List<String>? get getFilterOffices => FilterOffices;

  List<RequestsFiltertionModel>? get requestsFiltertionList =>
      _requestsFiltertionList;

  List<ReportsModel>? get getReportsList => reportsList;

  List<ResultChechList>? get subCategoryList => _subcategoryList;

  Future<void> getCategoryList(BuildContext context, bool reload) async {
    _isLoading = true;
    if (_categoryList == null || reload) {
      ApiResponse apiResponse = await categoryRepo.getCategoryList();
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        _categoryList = [];
        apiResponse.response?.data["result"].forEach(
            (category) => _categoryList?.add(Result.fromJson(category)));
        selectedIdCategory = _categoryList![0].id.toString();
        selectedNameCategory = getTitleCategory(0);
        getSubCategoryList(_categoryList![0].id.toString());
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSubCategoryList(String CatId) async {
    // if (reload) {
    _isLoading = true;
    ApiResponse apiResponse = await categoryRepo.getSubCategoryList(CatId);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _isLoading = false;
      _subcategoryList = [];
      apiResponse.response?.data["result"].forEach((subcategory) =>
          _subcategoryList?.add(ResultChechList.fromJson(subcategory)));
    } else {
      // ApiChecker.checkApi(context, apiResponse);

    }
    _isLoading = false;
    notifyListeners();
    // }
  }

  String getTitleCategory(int poistion) {
    String lang = sharedPreferences.getString(AppConstants.LANGUAGE_CODE)!;
    if (lang == "en") {
      return _categoryList![poistion].nameEn!;
    } else {
      return _categoryList![poistion].nameAr!;
    }
  }

  String getTitleSubCategory(int poistion) {
    String lang = sharedPreferences.getString(AppConstants.LANGUAGE_CODE)!;
    if (lang == "en") {
      return _subcategoryList![poistion].nameEn!;
    } else {
      return _subcategoryList![poistion].nameAr!;
    }
  }

  bool _isLoading = false;
  bool _isLoadingFilter = false;
  bool _isLoadingDetails = false;

  bool get isLoading => _isLoading;

  bool get isLoadingFilter => _isLoadingFilter;

  void setLoading() {
    _isLoadingFilter = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 1), () {
      _isLoadingFilter = false;
      notifyListeners();
    });
  }

  bool get isLoadingDetails => _isLoadingDetails;

  Future<void> updateUserInfo(File? file, String token) async {
    _isLoading = true;
    notifyListeners();
    ResponseModel _responseModel;
    http.StreamedResponse response =
        await categoryRepo.updateProfile(file, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      fileUrl = map["result"];
      // _userInfoModel = updateUserModel;
      // _responseModel = ResponseModel(true, photo);
      // print(photo);
    } else {
      // _responseModel = ResponseModel(false, '${response.statusCode} ${response.reasonPhrase}');
      // print('${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();
  }

  List<String> checkListId = [];
  List<String> checkListTitle = [];
  String? CatId = null;
  String? Description = null;
  String? CatName = null;

  clearList() {
    CatId = null;
    CatName = null;
    checkListId.clear();
  }

  saveCheckId(BuildContext context, bool checked, String checkId, String catId,
      String catName, String checkTitle) {
    if (!checked) {
      checkListId.remove(checkId);
      checkListTitle.add(checkTitle);
      if (checkListId.length == 0) {
        CatId = null;
        CatName = null;
      }
    } else {
      if (checkListId.length > 0) {
        if (CatId == catId) {
          checkListId.add(checkId);
          checkListTitle.add(checkTitle);
        } else {
          completeCheckListDialog(context);
        }
      } else {
        CatName = catName;
        CatId = catId;
        checkListId.add(checkId);
        checkListTitle.add(checkTitle);
      }
    }

    print("listChecked${checkListId.length}");

    notifyListeners();
  }

  bool checkIdInList(String Id) {
    for (var element in checkListId) {
      if (element.toString() == Id) {
        return true;
      }
    }
    return false;
  }

  void completeCheckListDialog(BuildContext context) {
    print("catname1$CatName");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CompleteCheckListDialog(
              catName: CatName!,
            ));
  }

  saveReports() {
    countrer++;
    ReportsModel reportsModel = ReportsModel(
        id: countrer,
        catId: CatId!,
        catName: CatName!,
        checkListIds: checkListId,
        checkListTitles: checkListTitle,
        image: fileUrl,
        note: Description);
    reportsList.add(reportsModel);

    CatName = null;
    CatId = null;
    fileUrl = null;
    Description = null;
    this.checkListTitle = [];
    this.checkListId = [];
    notifyListeners();
  }

  String getListTitleReport(poistion) {
    String title;
    var kontan = StringBuffer();

    for (var element in reportsList[poistion].checkListTitle) {
      kontan.writeln("$element,");
    }
    title = kontan.toString();
    return title;
  }

  clearItemReport(int index, BuildContext context) {
    reportsList.removeAt(index);
    if (reportsList.length == 0) {
      Navigator.pop(context);
    }
    notifyListeners();
  }

  List<ResultCenterModel>? _regionsList;
  List<ResultRegionsModel>? _officeList;

  List<ResultCenterModel>? get regionsList => _regionsList;

  List<ResultRegionsModel>? get officesList => _officeList;

  void confirmSendReport(BuildContext context,String SerialNUmber) {
    _isLoading = true;
    notifyListeners();
    List<Requests> list = [];
    int index = 0;
    for (var element in reportsList) {
      List<String> photos = [];
      List<int> ids = [];
      if (element.image != null) {
        photos.add(element.image!);
      }
      for (var Id in reportsList[index].checkListId) {
        ids.add(int.parse(Id));
      }


      Requests requests = Requests(
        categoryComplanitId: int.parse(element.catId),
          attachmentsComplanit: photos,
          description: element.note,
          checkListsRequest: ids);
      list.add(requests);
      index++;
    }

    SendReportRequestModel sendReportRequestModel =
        SendReportRequestModel(requests: list,serialNumber: SerialNUmber);
    sendRequest(sendReportRequestModel).then((value) {
      if (value.isSuccess!) {
        CatName = null;
        CatId = null;
        fileUrl = null;
        Description = null;
        this.checkListTitle = [];
        this.checkListId = [];
        this.reportsList = [];
        showCustomSnackBar(
                getTranslated('success_send', context), isError: false, context)
            .then((value) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.getMainCLientRoute(), (route) => false);
        });
      } else {
        showCustomSnackBar(value.message!, context);
      }
    });
  }

  Future<ResponseModel> sendRequest(
      SendReportRequestModel sendReportRequestModel) async {
    //1 - check phone number

    ApiResponse apiResponse =
        await categoryRepo.sendReportRequest(sendReportRequestModel);
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      if (apiResponse.response?.data["statusEnum"].toString() ==
          "savedSuccessfully") {
        responseModel =
            ResponseModel(true, apiResponse.response?.data["message"]);
        // _verificationMsg = apiResponse.response?.data["message"] ;
      } else {
        responseModel =
            ResponseModel(false, apiResponse.response?.data["message"]);
        // _verificationMsg = apiResponse.response?.data["message"] ;
      }
    } else {
      String errorMessage = "";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
      _verificationMsg = errorMessage;
    }
    _isLoading = false;

    notifyListeners();
    return responseModel;
  }

  Future<void> getRegionsList(List<String> idsList) async {
    _isLoadingFilter = true;
    notifyListeners();
    List<String> list = idsList;
    String ids = list.join(",");
    print('idds $ids');
    selectedItemsRegions = [];
    final url = Uri.parse(
        "https://hrdeploy.camelclub.gov.sa/app/api/v1/Region/GetAllRegionsByOfficeIds?IdsString=${ids.isEmpty ? "0" : ids}");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization':
            'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}'
      });
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        print("res $res");
        _regionsList = [];
        res["result"].forEach((regions) =>
            _regionsList?.add(ResultCenterModel.fromJson(regions)));
        print(" res22 = " + _regionsList!.length.toString());
      }
    } catch (e) {
      print("Settings Api Get, error occurred " + e.toString());
    }
    _isLoadingFilter = false;
    notifyListeners();
  }

  Future<void> getOfficesList() async {
    final url = Uri.parse(
        "https://hrdeploy.camelclub.gov.sa/app/api/v1/office/getalloffices");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization':
            'Bearer ${sharedPreferences.getString(AppConstants.TOKEN)}'
      });
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        print("res $res");
        _officeList = [];
        res["result"].forEach((regions) =>
            _officeList?.add(ResultRegionsModel.fromJson(regions)));
        print(" res22 = " + _officeList!.length.toString());
      }
    } catch (e) {
      print("Settings Api Get, error occurred " + e.toString());
    }
  }

  List<String> getRegionsTitles(BuildContext context) {
    List<String> newlist = [];
    String lang = sharedPreferences.getString(AppConstants.LANGUAGE_CODE)!;
    if (regionsList != null && regionsList!.length > 0) {
      newlist.add(getTranslated('all', context));
      for (var element in regionsList!) {
        newlist.add(element.regionName ?? '');
      }
    }
    return newlist;
  }

  List<String> getOfficesTitles(BuildContext context) {
    List<String> newlist = [];
    String lang = sharedPreferences.getString(AppConstants.LANGUAGE_CODE)!;
    if (officesList != null) {
      newlist.add(getTranslated('all', context));
      for (var element in officesList!) {
        newlist.add(lang == "en"
            ? element.officeNameEn!+ "/" + element.code!
            : element.officeNameAr! + "/" + element.code!);
      }
    }
    return newlist;
  }

  List<String> getOCategoriesTitles(BuildContext context) {
    List<String> newlist = [];
    String lang = sharedPreferences.getString(AppConstants.LANGUAGE_CODE)!;
    if (categoryList != null) {
      newlist.add(getTranslated('all', context));
      for (var element in categoryList!) {
        newlist.add(lang == "en" ? element.nameEn! : element.nameAr!);
      }
    }
    return newlist;
  }

  void getRegionId(String region) {
    for (var element in regionsList!) {
      if (region == element.regionName!) {
        RegionId = element.id.toString();
      }
    }
  }

  void getOfficeId(String region) {
    for (var element in officesList!) {
      if (region == element.officeNameEn! || region == element.officeNameAr!) {
        OfficeId = element.id.toString();
      }
    }
  }

  void confirmFilter(
      List<String> category, List<String> offices, List<String> region) {
    FilterCategory = [];
    FilterOffices = [];
    FilterRegion = [];

    if (category.length > 0) {
      for (var element in getListIdsCategory(category)) {
        FilterCategory.add(element);
        if (element == "0") {
          FilterCategory = [];
          break;
        }
      }
      print("FilterCategory$FilterCategory");
      saveSharedCategories(category, FilterCategory);
    }

    if (offices.length > 0) {
      for (var element in getListIdsOffices(offices)) {
        FilterOffices.add(element);
        if (element == "0") {
          FilterOffices = [];
          break;
        }
      }
      print("FilterOffices$FilterOffices");
      saveSharedOffices(offices, FilterOffices);
    }
    if (region.length > 0) {
      for (var element in getListIdsRegions(region)) {
        FilterRegion.add(element);
        if (element == "0") {
          FilterRegion = [];
          break;
        }
      }
      print("FilterRegion$FilterRegion");
      saveSharedRegions(region, FilterRegion);
    }
    sendDataFiltertion();
  }

  List<String> getListIdsCategory(List<String> category) {
    List<String> idsListCategory = [];
    for (var element in category!) {
      for (int i = 0; i < categoryList!.length; i++) {
        // if (element == "الكل" || element == "All") {
        //   idsListCategory.add("0");
        // }
        if (categoryList![i].nameEn == element ||
            categoryList![i].nameAr == element) {
          idsListCategory.add(categoryList![i].id.toString());
        }
      }
    }
    return idsListCategory;
  }

  List<String> getListIdsRegions(List<String> category) {
    List<String> idsListRegions = [];
    for (var element in category) {
      for (int i = 0; i < regionsList!.length; i++) {
        // if (element == "الكل" || element == "All") {
        //   idsListRegions.add("0");
        // }
        if (regionsList![i].regionName == element) {
          idsListRegions.add(regionsList![i].id.toString());
        }
      }
    }
    return idsListRegions;
  }

  List<String> getListIdsOffices(List<String> offices) {
    List<String> idsListOffices = [];
    for (var element in offices) {
      for (int i = 0; i < officesList!.length; i++) {
        // if (element == "الكل" || element == "All") {
        //   idsListOffices.add("0");
        //   break;
        // }
        if ("${officesList![i].officeNameAr!}/${officesList![i].code!}" ==
                element ||
            "${officesList![i].officeNameEn!}/${officesList![i].code!}" ==
                element) {
          idsListOffices.add(officesList![i].id.toString());
        }
      }
    }
    return idsListOffices;
  }

  String getFormateDay(String date) {
    if (sharedPreferences.getString(AppConstants.LANGUAGE_CODE) == "ar") {
      var now =  DateTime.parse(date);
      var formatter = DateFormat('dd-MM-yyyy',Intl.defaultLocale = "en");
      String formattedDate = formatter.format(now);
      print(formattedDate);
      return formattedDate;
    } else {
      var now = DateTime.parse(date);
      var formatter = DateFormat('dd-MM-yyyy', Intl.defaultLocale = "en");
      String formattedDate = formatter.format(now);
      return formattedDate;
    }
  }

  String getFormateTime(String date) {
    if (sharedPreferences.getString(AppConstants.LANGUAGE_CODE) == "ar") {
      var now = DateTime.parse(date);
      String formattedTime = DateFormat('h:mma ').format(now);
      print(formattedTime);
      return formattedTime;
    } else {
      var now = DateTime.parse(date);
      String formattedTime = DateFormat('h:mm a').format(now);
      print(formattedTime);
      return formattedTime;
    }
  }

  changeTypeRequest(String status) {
    if (status == "All" || status == "الكل") {
      TypeRequest = null;
    }
    if (status == "Opened" || status == "مفتوح") {
      TypeRequest = "1";
    } else if (status == "Under processing" ||
        status == "تحت المعالجة") {
      TypeRequest = "2";
    } else if (status == "Suspended" || status == "معلق") {
      TypeRequest = "3";
    } else if (status == "Canceled" || status == "ملغي") {
      TypeRequest = "5";
    } else if (status == "Completed" || status == "مكتمل") {
      TypeRequest = "7";
    }
    sendDataFiltertion();
  }

  saveSharedCategories(List<String> categories, List<String> categoriesIds) {
    sharedPreferences.setStringList('categoriesIds', categoriesIds);
    sharedPreferences.setStringList('categoriesNames', categories);
  }

  List<String>? getSavedCategoriesTitles() {
    List<String>? categories = [];
    if (sharedPreferences.containsKey("categoriesNames")) {
      categories = sharedPreferences.getStringList("categoriesNames");
      print("itemssss+${categories!.length}");
      return categories;
    }
  }

  List<String>? getSavedRegionsTitles() {
    List<String>? categories = [];
    if (sharedPreferences.containsKey("regionsNames")) {
      categories = sharedPreferences.getStringList("regionsNames");
      print("itemssss+${categories!.length}");
      return categories;
    }
  }

  List<String>? getSavedOfficesTitles() {
    List<String>? categories = [];
    if (sharedPreferences.containsKey("officesNames")) {
      categories = sharedPreferences.getStringList("officesNames");
      print("itemssss+${categories!.length}");
      return categories;
    }
  }

  getSavedCategoriesIds() {
    List<String>? categories = [];
    if (sharedPreferences.containsKey("categoriesIds")) {
      categories = sharedPreferences.getStringList("categoriesIds");
      print("itemssss+${categories!.length}");
      FilterCategory = categories;
    }
  }

  saveSharedOffices(List<String> officesNames, List<String> officesIds) {
    sharedPreferences.setStringList('officesIds', officesIds);
    sharedPreferences.setStringList('officesNames', officesNames);
  }

  getSavedOfficesIds() {
    List<String>? officesIds = [];
    if (sharedPreferences.containsKey("officesIds")) {
      officesIds = sharedPreferences.getStringList("officesIds");
      print("itemssss+${officesIds!.length}");
      FilterOffices = officesIds;
    }
  }

  saveSharedRegions(List<String> regionsNames, List<String> regionsIds) {
    sharedPreferences.setStringList('regionsIds', regionsIds);
    sharedPreferences.setStringList('regionsNames', regionsNames);
  }

  getSavedRegionIds() {
    List<String>? regionsIds = [];
    if (sharedPreferences.containsKey("regionsIds")) {
      regionsIds = sharedPreferences.getStringList("regionsIds");
      print("itemssss+${regionsIds!.length}");
      FilterRegion = regionsIds;
    }
  }

  int page = 1;
  int totalPage = 0;

  Future<void> sendDataFiltertion() async {
    // if (reload) {
    _isLoading = true;
    notifyListeners();
    // late List<int> FilterRegionInteger = [];
    // late List<int> FilterCategoryInteger = [];
    // late List<int> FilterOfficesInteger = [];

    List<int> FilterRegionInteger =
        FilterRegion.map((i) => int.parse(i)).toList();
    List<int> FilterCategoryInteger =
        FilterCategory.map((i) => int.parse(i)).toList();
    List<int> FilterOfficesInteger =
        FilterOffices.map((i) => int.parse(i)).toList();

    page = 1;
    SendFiltertionRequestModel filtertionRequestModel =
        SendFiltertionRequestModel(
            pageNumber: page,
            pageSize: 10,
            categoriesListsRequest: FilterCategoryInteger,
            officeListsRequest: FilterOfficesInteger,
            complanitStatus: TypeRequest,
            regionsListsRequest: FilterRegionInteger);
    print("filtertion${filtertionRequestModel.toJson()}");
    ApiResponse apiResponse =
        await categoryRepo.sendFiltertionRequest(filtertionRequestModel);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _isLoading = false;
      _requestsFiltertionList = [];
      apiResponse.response?.data["result"].forEach((filtertion) =>
          _requestsFiltertionList
              ?.add(RequestsFiltertionModel.fromJson(filtertion)));
      totalPage = apiResponse.response?.data["totalPages"];
    } else {
      // ApiChecker.checkApi(context, apiResponse);

    }
    _isLoading = false;
    notifyListeners();
    // }
  }

  Future<void> sendDataFiltertionLoadMore() async {
    // if (reload) {
    if (totalPage >= page) {
      page += 1;
      _isLoading = true;
      notifyListeners();

      List<int> FilterRegionInteger =
          FilterRegion.map((i) => int.parse(i)).toList();
      List<int> FilterCategoryInteger =
          FilterCategory.map((i) => int.parse(i)).toList();
      List<int> FilterOfficesInteger =
          FilterOffices.map((i) => int.parse(i)).toList();


      SendFiltertionRequestModel filtertionRequestModel =
          SendFiltertionRequestModel(
              pageNumber: page,
              pageSize: 10,
              categoriesListsRequest: FilterCategoryInteger,
              officeListsRequest: FilterOfficesInteger,
              complanitStatus: TypeRequest,
              regionsListsRequest: FilterRegionInteger);
      print("filtertion${filtertionRequestModel.toJson()}");
      ApiResponse apiResponse =
          await categoryRepo.sendFiltertionRequest(filtertionRequestModel);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        _isLoading = false;
        // _requestsFiltertionList = [];
        apiResponse.response?.data["result"].forEach((filtertion) =>
            _requestsFiltertionList
                ?.add(RequestsFiltertionModel.fromJson(filtertion)));
      } else {
        // ApiChecker.checkApi(context, apiResponse);

      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchByCode(String code) async {
    // if (reload) {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await categoryRepo.searchByCode(code);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _isLoading = false;
      _requestsFiltertionList = [];
      apiResponse.response?.data["result"].forEach((filtertion) =>
          _requestsFiltertionList
              ?.add(RequestsFiltertionModel.fromJson(filtertion)));
    } else {
      // ApiChecker.checkApi(context, apiResponse);

    }
    _isLoading = false;
    notifyListeners();
    // }
  }

  String getUserId() {
    return sharedPreferences.getString("userId")!;
  }

  String getUserType() {
    return sharedPreferences.getString("userType")!;
  }

  sendTokenFirebase() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("firebasetoken$fcmToken");
    String userId = sharedPreferences.getString("userId")!;
    // final databaseRef = FirebaseDatabase._instance_.reference(); //database reference object
    //
    // void addData(String data) {
    //   databaseRef.push().set({'name': data, 'comment': 'A good season'});
    // }

    if (fcmToken != null) {
      ApiResponse apiResponse =
          await categoryRepo.sendUserToken(fcmToken, userId);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
      } else {
        // ApiChecker.checkApi(context, apiResponse);

      }
    }
  }

  Future<ResponseModel> changeRequestStatus(
      String requestComplanitId,
      String? attachmentsComplanit,
      String complanitStatus,
      String? description) async {
    List<String> image = [];
    _isLoadingDetails = true;
    notifyListeners();
    if (attachmentsComplanit != null) {
      image.add(attachmentsComplanit);
    }
    var map = <String, dynamic>{};
    map["requestComplanitId"] = requestComplanitId;
    map["complanitStatus"] = complanitStatus;
    map["attachmentsComplanitHistory"] = image;
    map["description"] = description;
    ResponseModel responseModel;

    ApiResponse apiResponse = await categoryRepo.changeStatus(map);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(
        apiResponse.response?.data["statusEnum"].toString() ==
                "savedSuccessfully"
            ? true
            : false,
        apiResponse.response?.data["message"],
      );
      _verificationMsg = apiResponse.response?.data["message"];

      if (apiResponse.response?.data["statusEnum"].toString() == "success") {}

      // responseModel = ResponseModel(true, apiResponse.response?.data["message"]);
    } else {
      String errorMessage = "";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoadingDetails = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> confirmcodeStatus(String requestComplanitId,
      String? codeSms, String complanitStatus) async {
    _isLoadingDetails = true;
    notifyListeners();

    var map = <String, dynamic>{};
    map["requestComplanitId"] = requestComplanitId;
    map["complanitStatus"] = complanitStatus;
    map["codeSms"] = codeSms;
    ResponseModel responseModel;

    ApiResponse apiResponse = await categoryRepo.confirmcCodeStatus(map);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(
        apiResponse.response?.data["statusEnum"].toString() == "success"
            ? true
            : false,
        apiResponse.response?.data["message"],
      );
      _verificationMsg = apiResponse.response?.data["message"];

      if (apiResponse.response?.data["statusEnum"].toString() == "success") {}

      // responseModel = ResponseModel(true, apiResponse.response?.data["message"]);
    } else {
      String errorMessage = "";
      if (apiResponse.message is String) {
        print(apiResponse.message.toString());
        errorMessage = apiResponse.message.toString();
      }
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoadingDetails = false;
    notifyListeners();
    return responseModel;
  }
}
