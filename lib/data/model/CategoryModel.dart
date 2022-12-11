import 'dart:convert';
/// result : {"nameAr":"سباكة","nameEn":"plumbing","descriptionAr":"سباكة","descriptionEn":"plumbing","id":1}
/// pageIndex : 0
/// totalPages : 0
/// totalItems : 0
/// pageSize : 0
/// message : "CategoryComplanitSavedSuccessfully"
/// statusEnum : "savedSuccessfully"

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());
class CategoryModel {
  CategoryModel({
      Result? result, 
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

  CategoryModel.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  Result? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  String? _statusEnum;

  Result? get result => _result;
  int? get pageIndex => _pageIndex;
  int? get totalPages => _totalPages;
  int? get totalItems => _totalItems;
  int? get pageSize => _pageSize;
  String? get message => _message;
  String? get statusEnum => _statusEnum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
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

/// nameAr : "سباكة"
/// nameEn : "plumbing"
/// descriptionAr : "سباكة"
/// descriptionEn : "plumbing"
/// id : 1

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? nameAr, 
      String? nameEn, 
      String? descriptionAr, 
      String? descriptionEn, 
      int? id,}){
    _nameAr = nameAr;
    _nameEn = nameEn;
    _descriptionAr = descriptionAr;
    _descriptionEn = descriptionEn;
    _id = id;
}

  Result.fromJson(dynamic json) {
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
    _descriptionAr = json['descriptionAr'];
    _descriptionEn = json['descriptionEn'];
    _id = json['id'];
  }
  String? _nameAr;
  String? _nameEn;
  String? _descriptionAr;
  String? _descriptionEn;
  int? _id;

  String? get nameAr => _nameAr;
  String? get nameEn => _nameEn;
  String? get descriptionAr => _descriptionAr;
  String? get descriptionEn => _descriptionEn;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    map['descriptionAr'] = _descriptionAr;
    map['descriptionEn'] = _descriptionEn;
    map['id'] = _id;
    return map;
  }

}