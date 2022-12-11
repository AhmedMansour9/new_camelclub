import 'dart:convert';
/// result : [{"id":1,"officeNameAr":"مركز 1","officeNameEn":"Center 1"},{"id":5,"officeNameAr":"مركز 2","officeNameEn":"مركز 2"}]
/// pageIndex : 0
/// totalPages : 0
/// totalItems : 0
/// pageSize : 0
/// message : "officesRetrievedSuccessfully"
/// statusEnum : 3

RegionsModel regionsModelFromJson(String str) => RegionsModel.fromJson(json.decode(str));
String regionsModelToJson(RegionsModel data) => json.encode(data.toJson());
class RegionsModel {
  RegionsModel({
      List<ResultRegionsModel>? result,
      int? pageIndex, 
      int? totalPages, 
      int? totalItems, 
      int? pageSize, 
      String? message, 
      int? statusEnum,}){
    _result = result;
    _pageIndex = pageIndex;
    _totalPages = totalPages;
    _totalItems = totalItems;
    _pageSize = pageSize;
    _message = message;
    _statusEnum = statusEnum;
}

  RegionsModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(ResultRegionsModel.fromJson(v));
      });
    }
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  List<ResultRegionsModel>? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  int? _statusEnum;

  List<ResultRegionsModel>? get result => _result;
  int? get pageIndex => _pageIndex;
  int? get totalPages => _totalPages;
  int? get totalItems => _totalItems;
  int? get pageSize => _pageSize;
  String? get message => _message;
  int? get statusEnum => _statusEnum;

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

/// id : 1
/// officeNameAr : "مركز 1"
/// officeNameEn : "Center 1"

ResultRegionsModel resultFromJson(String str) => ResultRegionsModel.fromJson(json.decode(str));
String resultToJson(ResultRegionsModel data) => json.encode(data.toJson());
class ResultRegionsModel {
  ResultRegionsModel({
      int? id, 
      String? officeNameAr, 
      String? officeNameEn, String? code,}){
    _id = id;
    _officeNameAr = officeNameAr;
    _officeNameEn = officeNameEn;
    _code= code;
}

  ResultRegionsModel.fromJson(dynamic json) {
    _id = json['id'];
    _officeNameAr = json['officeNameAr'];
    _officeNameEn = json['officeNameEn'];
    _code = json['code'];
  }
  int? _id;
  String? _officeNameAr;
  String? _officeNameEn;
  String? _code;

  int? get id => _id;
  String? get officeNameAr => _officeNameAr;
  String? get officeNameEn => _officeNameEn;
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['officeNameAr'] = _officeNameAr;
    map['officeNameEn'] = _officeNameEn;
    map['code'] = _code;
    return map;
  }

}