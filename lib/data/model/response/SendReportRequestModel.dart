import 'dart:convert';
/// requests : [{"description":"ea magna Ut ullamco","checkListsRequest":[10,9],"attachmentsComplanit":["in est","Lorem ullamco dolor"]}]

SendReportRequestModel sendReportRequestModelFromJson(String str) => SendReportRequestModel.fromJson(json.decode(str));
String sendReportRequestModelToJson(SendReportRequestModel data) => json.encode(data.toJson());
class SendReportRequestModel {
  SendReportRequestModel({
    String? serialNumber,
    List<Requests>? requests,}){
    _requests = requests;
    _serialNumber = serialNumber;

  }

  SendReportRequestModel.fromJson(dynamic json) {
    _serialNumber = json['serialNumber'];
    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests?.add(Requests.fromJson(v));
      });
    }
  }
  List<Requests>? _requests;
  String? _serialNumber;
  String? get serialNumber => _serialNumber;

  List<Requests>? get requests => _requests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_requests != null) {
      map['requests'] = _requests?.map((v) => v.toJson()).toList();
      map['serialNumber'] = _serialNumber;
    }
    return map;
  }

}

/// description : "ea magna Ut ullamco"
/// checkListsRequest : [10,9]
/// attachmentsComplanit : ["in est","Lorem ullamco dolor"]

Requests requestsFromJson(String str) => Requests.fromJson(json.decode(str));
String requestsToJson(Requests data) => json.encode(data.toJson());
class Requests {
  Requests({
      String? description, 
      int? categoryComplanitId,
      List<int>? checkListsRequest,
      List<String>? attachmentsComplanit,}){
    _description = description;
    _categoryComplanitId = categoryComplanitId;
    _checkListsRequest = checkListsRequest;
    _attachmentsComplanit = attachmentsComplanit;
}

  Requests.fromJson(dynamic json) {
    _description = json['description'];
    _categoryComplanitId = json['categoryComplanitId'];
    _checkListsRequest = json['checkListsRequest'] != null ? json['checkListsRequest'].cast<int>() : [];
    _attachmentsComplanit = json['attachmentsComplanit'] != null ? json['attachmentsComplanit'].cast<String>() : [];
  }
  String? _description;
  int? _categoryComplanitId;
  List<int>? _checkListsRequest;
  List<String>? _attachmentsComplanit;

  String? get description => _description;
  List<int>? get checkListsRequest => _checkListsRequest;
  List<String>? get attachmentsComplanit => _attachmentsComplanit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryComplanitId'] = _categoryComplanitId;
    map['description'] = _description;
    map['checkListsRequest'] = _checkListsRequest;
    map['attachmentsComplanit'] = _attachmentsComplanit;
    return map;
  }

}