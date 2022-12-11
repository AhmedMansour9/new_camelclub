import 'dart:convert';
/// result : [{"id":10,"regionName":"01"},{"id":11,"regionName":"02"},{"id":12,"regionName":"03"},{"id":13,"regionName":"04"},{"id":14,"regionName":"05"},{"id":15,"regionName":"06"},{"id":16,"regionName":"07"},{"id":17,"regionName":"08"},{"id":18,"regionName":"09"},{"id":19,"regionName":"10"},{"id":20,"regionName":"11"},{"id":21,"regionName":"12"},{"id":22,"regionName":"13"},{"id":23,"regionName":"14"},{"id":24,"regionName":"15"},{"id":25,"regionName":"16"},{"id":26,"regionName":"17"},{"id":27,"regionName":"18"},{"id":28,"regionName":"19"},{"id":29,"regionName":"20"},{"id":30,"regionName":"21"},{"id":31,"regionName":"22"},{"id":32,"regionName":"23"},{"id":33,"regionName":"24"},{"id":34,"regionName":"25"},{"id":35,"regionName":"26"},{"id":36,"regionName":"27"},{"id":37,"regionName":"28"},{"id":38,"regionName":"29"},{"id":39,"regionName":"30"},{"id":40,"regionName":"31"},{"id":41,"regionName":"32"},{"id":42,"regionName":"33"},{"id":43,"regionName":"34"},{"id":44,"regionName":"35"},{"id":45,"regionName":"36"}]
/// pageIndex : 0
/// totalPages : 0
/// totalItems : 0
/// pageSize : 0
/// message : "regionsRetrievedSuccessfully"
/// statusEnum : 3

CenterModeldart centerModeldartFromJson(String str) => CenterModeldart.fromJson(json.decode(str));
String centerModeldartToJson(CenterModeldart data) => json.encode(data.toJson());
class CenterModeldart {
  CenterModeldart({
      List<ResultCenterModel>? result,
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

  CenterModeldart.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(ResultCenterModel.fromJson(v));
      });
    }
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  List<ResultCenterModel>? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  int? _statusEnum;

  List<ResultCenterModel>? get result => _result;
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

/// id : 10
/// regionName : "01"

ResultCenterModel resultFromJson(String str) => ResultCenterModel.fromJson(json.decode(str));
String resultToJson(ResultCenterModel data) => json.encode(data.toJson());
class ResultCenterModel {
  ResultCenterModel({
      int? id, 
      String? regionName,}){
    _id = id;
    _regionName = regionName;
}

  ResultCenterModel.fromJson(dynamic json) {
    _id = json['id'];
    _regionName = json['regionName'];
  }
  int? _id;
  String? _regionName;

  int? get id => _id;
  String? get regionName => _regionName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['regionName'] = _regionName;
    return map;
  }

}