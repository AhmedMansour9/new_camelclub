import 'dart:convert';
/// result : [{"id":2,"categoryComplanitId":2,"nameAr":"خلاط كهرباء","nameEn":"Electric mixer","descriptionAr":"خلاط كهرباء","descriptionEn":"Electric mixer"},{"id":4,"categoryComplanitId":2,"nameAr":"خلاط مطبخ","nameEn":"Kitchen mixer","descriptionAr":"id eiusmod conse","descriptionEn":"nulla consectetur"}]
/// pageIndex : 1
/// totalPages : 1
/// totalItems : 2
/// pageSize : 9
/// message : "CheckListModelComplanitRetrievedSuccessfully"
/// statusEnum : "success"

CheckListModel CheckListModelFromJson(String str) => CheckListModel.fromJson(json.decode(str));
String CheckListModelToJson(CheckListModel data) => json.encode(data.toJson());
class CheckListModel {
  CheckListModel({
      List<ResultChechList>? result,
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

  CheckListModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(ResultChechList.fromJson(v));
      });
    }
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  List<ResultChechList>? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  String? _statusEnum;

  List<ResultChechList>? get result => _result;
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

/// id : 2
/// categoryComplanitId : 2
/// nameAr : "خلاط كهرباء"
/// nameEn : "Electric mixer"
/// descriptionAr : "خلاط كهرباء"
/// descriptionEn : "Electric mixer"

ResultChechList resultFromJson(String str) => ResultChechList.fromJson(json.decode(str));
String resultToJson(ResultChechList data) => json.encode(data.toJson());
class ResultChechList {
  ResultChechList({
      int? id,
      int? categoryComplanitId,
      String? nameAr,
      String? nameEn,
      String? descriptionAr,
      String? descriptionEn,}){
    _id = id;
    _categoryComplanitId = categoryComplanitId;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
}

  ResultChechList.fromJson(dynamic json) {
    _id = json['id'];
    _categoryComplanitId = json['categoryComplanitId'];
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
    _descriptionAr = json['descriptionAr'];
    _descriptionEn = json['descriptionEn'];
  }
  int? _id;
  int? _categoryComplanitId;
  String? _nameAr;
  String? _nameEn;
  String? _descriptionAr;
  String? _descriptionEn;

  int? get id => _id;
  int? get categoryComplanitId => _categoryComplanitId;
  String? get nameAr => _nameAr;
  String? get nameEn => _nameEn;
  String? get descriptionAr => _descriptionAr;
  String? get descriptionEn => _descriptionEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['categoryComplanitId'] = _categoryComplanitId;
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    map['descriptionAr'] = _descriptionAr;
    map['descriptionEn'] = _descriptionEn;
    return map;
  }

}