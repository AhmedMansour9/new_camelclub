import 'dart:convert';
import 'dart:ffi';


SendFiltertionRequestModel SendFiltertionRequestModelFromJson(String str) => SendFiltertionRequestModel.fromJson(json.decode(str));
String SendFiltertionRequestModelToJson(SendFiltertionRequestModel data) => json.encode(data.toJson());
class SendFiltertionRequestModel {
  SendFiltertionRequestModel({
    String? complanitStatus,
    int? pageNumber,
    int? pageSize,
    List<int>? categoriesListsRequest,
    List<int>? officeListsRequest,List<int>? regionsListsRequest}) {
    _complanitStatus = complanitStatus;
    _pageSize = pageSize;
    _pageNumber = pageNumber;
    _categoriesListsRequest = categoriesListsRequest;
    _officeListsRequest = officeListsRequest;
    _regionsListsRequest = regionsListsRequest;
  }

  SendFiltertionRequestModel.fromJson(dynamic json) {
    _complanitStatus = json['complanitStatus'];
    _pageSize = json['pageSize'];
    _pageNumber = json['pageNumber'];
    _categoriesListsRequest = json['CategoryId'] != null
        ? json['CategoryId'].cast<String>()
        : [];
    _officeListsRequest =
    json['OfficeId'] != null ? json['OfficeId'].cast<
        String>() : [];
  }

  String? _complanitStatus;
  int? _pageNumber;
  int? _pageSize;
  List<int>? _categoriesListsRequest;
  List<int>? _officeListsRequest;
  List<int>? _regionsListsRequest;

  String? get complanitStatus => _complanitStatus;

  List<int>? get categoriesListsRequest => _categoriesListsRequest;
  List<int>? get regionsListsRequest => _regionsListsRequest;

  List<int>? get attachmentsComplanit => _officeListsRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNumber'] = _pageNumber;
    map['pageSize'] = _pageSize;
    map['complanitStatus'] = _complanitStatus;
    map['categoryId'] = _categoriesListsRequest;
    map['officeId'] = _officeListsRequest;
    map['regionId'] = _regionsListsRequest;
    return map;
  }
}