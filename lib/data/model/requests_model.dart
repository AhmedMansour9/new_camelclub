import 'dart:convert';
/// result : [{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":1,"requestComplanitId":2,"description":"test1","checkListComplanit":[{"checkListComplanitId":1,"name":"خلاط كهرباء","description":"خلاط كهرباء"},{"checkListComplanitId":2,"name":"خلاط كهرباء","description":"خلاط كهرباء"}],"attachmentsComplanit":["in est"],"complanitStatus":2,"location":"مركز :  منطقة : 01 بركس : 01 غرفة : ","serialNumber":"00F0101R"},{"categoryComplanitName":"سباكة","categoryComplanitLogo":null,"categoryComplanitId":3,"requestComplanitId":3,"description":"test2","checkListComplanit":[{"checkListComplanitId":3,"name":"تيست واحد","description":"enim"},{"checkListComplanitId":4,"name":"خلاط مطبخ","description":"id eiusmod conse"}],"attachmentsComplanit":[],"complanitStatus":2,"location":"مركز :  منطقة : 01 بركس : 01 غرفة : ","serialNumber":"00F0101L"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":10,"requestComplanitId":4,"description":"ea magna Ut ullamco","checkListComplanit":[{"checkListComplanitId":10,"name":"مكتب ","description":"id eiusmod conse"},{"checkListComplanitId":9,"name":"تليفون ","description":"id eiusmod conse"}],"attachmentsComplanit":["Lorem ullamco dolor"],"complanitStatus":null,"location":"مركز :  منطقة : 01 بركس : 03 غرفة : ","serialNumber":"00F0103R"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":10,"requestComplanitId":5,"description":"ea magna Ut ullamco","checkListComplanit":[{"checkListComplanitId":10,"name":"مكتب ","description":"id eiusmod conse"},{"checkListComplanitId":9,"name":"تليفون ","description":"id eiusmod conse"}],"attachmentsComplanit":["in est","Lorem ullamco dolor"],"complanitStatus":1,"location":"مركز :  منطقة : 01 بركس : 05 غرفة : ","serialNumber":"00F0105R"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":13,"requestComplanitId":6,"description":null,"checkListComplanit":[{"checkListComplanitId":13,"name":"لمبات ","description":"id eiusmod conse"},{"checkListComplanitId":14,"name":"شفاط ","description":"id eiusmod conse"},{"checkListComplanitId":15,"name":"فيش ","description":"id eiusmod conse"}],"attachmentsComplanit":[],"complanitStatus":1,"location":"مركز :  منطقة : 01 بركس : 06 غرفة : ","serialNumber":"00F0106R"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":13,"requestComplanitId":7,"description":null,"checkListComplanit":[{"checkListComplanitId":13,"name":"لمبات ","description":"id eiusmod conse"},{"checkListComplanitId":14,"name":"شفاط ","description":"id eiusmod conse"},{"checkListComplanitId":15,"name":"فيش ","description":"id eiusmod conse"}],"attachmentsComplanit":[],"complanitStatus":1,"location":"مركز :  منطقة : 01 بركس : 07 غرفة : ","serialNumber":"00F0107T"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":13,"requestComplanitId":8,"description":null,"checkListComplanit":[{"checkListComplanitId":13,"name":"لمبات ","description":"id eiusmod conse"},{"checkListComplanitId":14,"name":"شفاط ","description":"id eiusmod conse"},{"checkListComplanitId":15,"name":"فيش ","description":"id eiusmod conse"}],"attachmentsComplanit":[],"complanitStatus":1,"location":"مركز :  منطقة : 02 بركس : 01 غرفة : ","serialNumber":"00F0201R"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":13,"requestComplanitId":9,"description":null,"checkListComplanit":[{"checkListComplanitId":13,"name":"لمبات ","description":"id eiusmod conse"},{"checkListComplanitId":14,"name":"شفاط ","description":"id eiusmod conse"},{"checkListComplanitId":15,"name":"فيش ","description":"id eiusmod conse"}],"attachmentsComplanit":[],"complanitStatus":1,"location":"مركز :  منطقة : 02 بركس : 01 غرفة : ","serialNumber":"00F0201L"},{"categoryComplanitName":"كهرباء","categoryComplanitLogo":null,"categoryComplanitId":13,"requestComplanitId":10,"description":null,"checkListComplanit":[{"checkListComplanitId":13,"name":"لمبات ","description":"id eiusmod conse"}],"attachmentsComplanit":["638045571691725213.jpg"],"complanitStatus":1,"location":"مركز :  منطقة : 02 بركس : 02 غرفة : ","serialNumber":"00F0202R"}]
/// pageIndex : 1
/// totalPages : 2
/// totalItems : 13
/// pageSize : 9
/// message : "CategoryComplanitRetrievedSuccessfully"
/// statusEnum : "success"

RequestsModel requestsModelFromJson(String str) => RequestsModel.fromJson(json.decode(str));
String requestsModelToJson(RequestsModel data) => json.encode(data.toJson());
class RequestsModel {
  RequestsModel({
      List<RequestsFiltertionModel>? result,
      int? pageIndex,
      int? totalPages,
      int? totalItems,
      int? pageSize,
      String? message,
      String? statusEnum,}){
    _result = result;
    _pageIndex = pageIndex;
    _totalPages = totalPages;
    _totalItems = totalItems;
    _pageSize = pageSize;
    _message = message;
    _statusEnum = statusEnum;
}

  RequestsModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(RequestsFiltertionModel.fromJson(v));
      });
    }
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  List<RequestsFiltertionModel>? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  String? _statusEnum;

  List<RequestsFiltertionModel>? get result => _result;
  int? get pageIndex => _pageIndex;
  int? get totalPages => _totalPages;
  int? get totalItems => _totalItems;
  int? get pageSize => _pageSize;
  String? get message => _message;
  String? get statusEnum => _statusEnum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    map['pageIndex'] = _pageIndex;
    map['totalPages'] = _totalPages;
    map['totalItems'] = _totalItems;
    map['pageSize'] = _pageSize;
    map['message'] = _message;
    map['statusEnum'] = _statusEnum;
    return map;
  }

}

/// categoryComplanitName : "كهرباء"
/// categoryComplanitLogo : null
/// categoryComplanitId : 1
/// requestComplanitId : 2
/// description : "test1"
/// checkListComplanit : [{"checkListComplanitId":1,"name":"خلاط كهرباء","description":"خلاط كهرباء"},{"checkListComplanitId":2,"name":"خلاط كهرباء","description":"خلاط كهرباء"}]
/// attachmentsComplanit : ["in est"]
/// complanitStatus : 2
/// location : "مركز :  منطقة : 01 بركس : 01 غرفة : "
/// serialNumber : "00F0101R"

RequestsFiltertionModel resultFromJson(String str) => RequestsFiltertionModel.fromJson(json.decode(str));
String resultToJson(RequestsFiltertionModel data) => json.encode(data.toJson());
class RequestsFiltertionModel {
  RequestsFiltertionModel({
      String? categoryComplanitName,
      String? code,
      String? createdOn,
      dynamic categoryComplanitLogo,
      int? categoryComplanitId,
      int? requestComplanitId,
      String? description,
      List<CheckListComplanit>? checkListComplanit,
      List<String>? attachmentsComplanit,
      int? complanitStatus,
      String? officeName,
      String? regionName,
      String? carvanNumber,
      String? roomNumber,
      String? technicianName,
      String? technicianDescription,
      String? serialNumber,
    UserDto? userDto}){
    _categoryComplanitName = categoryComplanitName;
    _categoryComplanitLogo = categoryComplanitLogo;
    _categoryComplanitId = categoryComplanitId;
    _requestComplanitId = requestComplanitId;
    _description = description;
    _checkListComplanit = checkListComplanit;
    _attachmentsComplanit = attachmentsComplanit;
    _complanitStatus = complanitStatus;
    _officeName = officeName;
    _serialNumber = serialNumber;
    _code = code;
    _createdOn = createdOn;
    _regionName = regionName;
    _carvanNumber = carvanNumber;
    _roomNumber = roomNumber;
    _userDto = userDto;
    _technicianName = technicianName;
    _technicianDescription = technicianDescription;

  }

  RequestsFiltertionModel.fromJson(dynamic json) {
    _categoryComplanitName = json['categoryComplanitName'];
    _categoryComplanitLogo = json['categoryComplanitLogo'];
    _categoryComplanitId = json['categoryComplanitId'];
    _requestComplanitId = json['requestComplanitId'];
    _description = json['description'];
    if (json['checkListComplanit'] != null) {
      _checkListComplanit = [];
      json['checkListComplanit'].forEach((v) {
        _checkListComplanit?.add(CheckListComplanit.fromJson(v));
      });
    }
    _attachmentsComplanit = json['attachmentsComplanit'] != null ? json['attachmentsComplanit'].cast<String>() : [];
    _complanitStatus = json['complanitStatus'];
    _officeName = json['officeName'];
    _serialNumber = json['serialNumber'];
    _code = json['code'];
    _createdOn = json['createdOn'];
    _regionName = json['regionName'];
    _carvanNumber = json['carvanNumber'];

    _createdOn = json['createdOn'];
    _technicianDescription = json['technicianDescription'];
    _roomNumber = json['roomNumber'];
    _technicianName = json['technicianName'];
    _userDto = json['userDto'] != null ? UserDto.fromJson(json['userDto']) : null;

  }
  String? _categoryComplanitName;
  dynamic _categoryComplanitLogo;
  int? _categoryComplanitId;
  int? _requestComplanitId;
  String? _description;
  List<CheckListComplanit>? _checkListComplanit;
  List<String>? _attachmentsComplanit;
  int? _complanitStatus;
  String? _officeName;
  String? _serialNumber;
  String? _createdOn;
  String? _regionName;
  String? _roomNumber;
  String? _carvanNumber;
  String? _code;
  String? _technicianDescription;
  String? _technicianName;
  UserDto? _userDto;

  String? get categoryComplanitName => _categoryComplanitName;
  dynamic get categoryComplanitLogo => _categoryComplanitLogo;
  int? get categoryComplanitId => _categoryComplanitId;
  int? get requestComplanitId => _requestComplanitId;
  String? get description => _description;
  String? get createdOn => _createdOn;
  String? get code => _code;
  List<CheckListComplanit>? get checkListComplanit => _checkListComplanit;
  List<String>? get attachmentsComplanit => _attachmentsComplanit;
  int? get complanitStatus => _complanitStatus;
  String? get technicianName => _technicianName;
  String? get officeName => _officeName;
  String? get regionName => _regionName;
  String? get technicianDescription => _technicianDescription;
  String? get carvanNumber => _carvanNumber;
  String? get roomNumber => _roomNumber;
  String? get serialNumber => _serialNumber;
  UserDto? get userDto => _userDto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryComplanitName'] = _categoryComplanitName;
    map['categoryComplanitLogo'] = _categoryComplanitLogo;
    map['categoryComplanitId'] = _categoryComplanitId;
    map['requestComplanitId'] = _requestComplanitId;
    map['description'] = _description;
    if (_checkListComplanit != null) {
      map['checkListComplanit'] = _checkListComplanit?.map((v) => v.toJson()).toList();
    }
    map['attachmentsComplanit'] = _attachmentsComplanit;
    map['complanitStatus'] = _complanitStatus;
    map['officeName'] = _officeName;
    map['serialNumber'] = _serialNumber;
    map['code'] = _code;
    map['createdOn'] = _createdOn;
    map['regionName'] = _regionName;
    map['carvanNumber'] = _carvanNumber;
    map['roomNumber'] = _roomNumber;
    map['technicianName'] = _technicianName;
    map['technicianDescription'] = _technicianDescription;
    if (_userDto != null) {
      map['userDto'] = _userDto?.toJson();
    }
    return map;
  }

}

/// checkListComplanitId : 1
/// name : "خلاط كهرباء"
/// description : "خلاط كهرباء"

CheckListComplanit checkListComplanitFromJson(String str) => CheckListComplanit.fromJson(json.decode(str));
String checkListComplanitToJson(CheckListComplanit data) => json.encode(data.toJson());
class CheckListComplanit {
  CheckListComplanit({
      int? checkListComplanitId, 
      String? name, 
      String? description,}){
    _checkListComplanitId = checkListComplanitId;
    _name = name;
    _description = description;
}

  CheckListComplanit.fromJson(dynamic json) {
    _checkListComplanitId = json['checkListComplanitId'];
    _name = json['name'];
    _description = json['description'];
  }
  int? _checkListComplanitId;
  String? _name;
  String? _description;

  int? get checkListComplanitId => _checkListComplanitId;
  String? get name => _name;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['checkListComplanitId'] = _checkListComplanitId;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }

}


UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));
String userDtoToJson(UserDto data) => json.encode(data.toJson());
class UserDto {
  UserDto({
    int? userId,
    String? fullName,
    String? phoneNumber,
    String? identityNumber,}){
    _userId = userId;
    _fullName = fullName;
    _phoneNumber = phoneNumber;
    _identityNumber = identityNumber;
  }

  UserDto.fromJson(dynamic json) {
    _userId = json['userId'];
    _fullName = json['fullName'];
    _phoneNumber = json['phoneNumber'];
    _identityNumber = json['identityNumber'];
  }
  int? _userId;
  String? _fullName;
  String? _phoneNumber;
  String? _identityNumber;

  int? get userId => _userId;
  String? get fullName => _fullName;
  String? get phoneNumber => _phoneNumber;
  String? get identityNumber => _identityNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['fullName'] = _fullName;
    map['phoneNumber'] = _phoneNumber;
    map['identityNumber'] = _identityNumber;
    return map;
  }

}