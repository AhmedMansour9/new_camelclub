import 'dart:convert';
/// result : [{"nameProperty":"اجمالي عدد البلاغات","valueProperty":1},{"nameProperty":"مفتوح","valueProperty":1},{"nameProperty":"جاري المعالجة","valueProperty":0},{"nameProperty":"معلق","valueProperty":0},{"nameProperty":"ملغي","valueProperty":0},{"nameProperty":"مكتمل","valueProperty":0},{"nameProperty":"مقفول","valueProperty":0},{"nameProperty":"كهرباء","valueProperty":0},{"nameProperty":"النظافة","valueProperty":1},{"nameProperty":"سباكة","valueProperty":0},{"nameProperty":"تكييف","valueProperty":0}]
/// pageIndex : 0
/// totalPages : 0
/// totalItems : 0
/// pageSize : 0
/// message : "CategoryComplanitRetrievedSuccessfully"
/// statusEnum : "success"

ReportsjsonModel reportsjsonModelFromJson(String str) => ReportsjsonModel.fromJson(json.decode(str));
String reportsjsonModelToJson(ReportsjsonModel data) => json.encode(data.toJson());
class ReportsjsonModel {
  ReportsjsonModel({
      List<ReportsResult>? result, 
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

  ReportsjsonModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(ReportsResult.fromJson(v));
      });
    }
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  List<ReportsResult>? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  String? _statusEnum;

  List<ReportsResult>? get result => _result;
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

/// nameProperty : "اجمالي عدد البلاغات"
/// valueProperty : 1

ReportsResult resultFromJson(String str) => ReportsResult.fromJson(json.decode(str));
String resultToJson(ReportsResult data) => json.encode(data.toJson());
class ReportsResult {
  Result({
      String? nameProperty,
      int? valueProperty,}){
    _nameProperty = nameProperty;
    _valueProperty = valueProperty;
}

  ReportsResult.fromJson(dynamic json) {
    _nameProperty = json['nameProperty'];
    _valueProperty = json['valueProperty'];
  }
  String? _nameProperty;
  int? _valueProperty;

  String? get nameProperty => _nameProperty;
  int? get valueProperty => _valueProperty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nameProperty'] = _nameProperty;
    map['valueProperty'] = _valueProperty;
    return map;
  }

}