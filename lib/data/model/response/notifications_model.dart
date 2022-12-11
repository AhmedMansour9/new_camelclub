import 'dart:convert';
/// result : [{"title":"9279672396","description":"","attachmentComplanitHistory":["638047308104445082.jpg"],"notificationType":"requestComplanit","notificationId":146,"notificationState":0,"body":"","subject":"TechnicianAssigned","complanitStatus":2,"complanitHistoryId":99,"requestComplanitId":39},{"title":"1225317991","description":"","attachmentComplanitHistory":["638047308104445082.jpg"],"notificationType":"requestComplanit","notificationId":258,"notificationState":0,"body":"","subject":"ملغي","complanitStatus":5,"complanitHistoryId":148,"requestComplanitId":32}]
/// pageIndex : 1
/// totalPages : 1
/// totalItems : 2
/// pageSize : 9
/// message : "CategoryComplanitRetrievedSuccessfully"
/// statusEnum : "success"

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));
String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());
class NotificationsModel {
  NotificationsModel({
      List<NotificationsListModel>? result,
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

  NotificationsModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(NotificationsListModel.fromJson(v));
      });
    }
    _pageIndex = json['pageIndex'];
    _totalPages = json['totalPages'];
    _totalItems = json['totalItems'];
    _pageSize = json['pageSize'];
    _message = json['message'];
    _statusEnum = json['statusEnum'];
  }
  List<NotificationsListModel>? _result;
  int? _pageIndex;
  int? _totalPages;
  int? _totalItems;
  int? _pageSize;
  String? _message;
  String? _statusEnum;

  List<NotificationsListModel>? get result => _result;
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

/// title : "9279672396"
/// description : ""
/// attachmentComplanitHistory : ["638047308104445082.jpg"]
/// notificationType : "requestComplanit"
/// notificationId : 146
/// notificationState : 0
/// body : ""
/// subject : "TechnicianAssigned"
/// complanitStatus : 2
/// complanitHistoryId : 99
/// requestComplanitId : 39

NotificationsListModel resultFromJson(String str) => NotificationsListModel.fromJson(json.decode(str));
String resultToJson(NotificationsListModel data) => json.encode(data.toJson());
class NotificationsListModel {
  NotificationsListModel({
      String? title, 
      String? code,
      String? description,
      List<String>? attachmentComplanitHistory, 
      String? notificationType, 
      int? notificationId, 
      int? notificationState, 
      String? body, 
      String? subject, 
      int? complanitStatus, 
      int? complanitHistoryId, 
      int? requestComplanitId,}){
    _code = title;
    _description = description;
    _attachmentComplanitHistory = attachmentComplanitHistory;
    _notificationType = notificationType;
    _notificationId = notificationId;
    _notificationState = notificationState;
    _body = body;
    _subject = subject;
    _complanitStatus = complanitStatus;
    _complanitHistoryId = complanitHistoryId;
    _requestComplanitId = requestComplanitId;
}

  NotificationsListModel.fromJson(dynamic json) {
    _title = json['title'];
    _code = json['code'];
    _description = json['description'];
    _attachmentComplanitHistory = json['attachmentComplanitHistory'] != null ? json['attachmentComplanitHistory'].cast<String>() : [];
    _notificationType = json['notificationType'];
    _notificationId = json['notificationId'];
    _notificationState = json['notificationState'];
    _body = json['body'];
    _subject = json['subject'];
    _complanitStatus = json['complanitStatus'];
    _complanitHistoryId = json['complanitHistoryId'];
    _requestComplanitId = json['requestComplanitId'];
  }
  String? _title;
  String? _code;
  String? _description;
  List<String>? _attachmentComplanitHistory;
  String? _notificationType;
  int? _notificationId;
  int? _notificationState;
  String? _body;
  String? _subject;
  int? _complanitStatus;
  int? _complanitHistoryId;
  int? _requestComplanitId;

  String? get title => _title;
  String? get code => _code;
  String? get description => _description;
  List<String>? get attachmentComplanitHistory => _attachmentComplanitHistory;
  String? get notificationType => _notificationType;
  int? get notificationId => _notificationId;
  int? get notificationState => _notificationState;
  String? get body => _body;
  String? get subject => _subject;
  int? get complanitStatus => _complanitStatus;
  int? get complanitHistoryId => _complanitHistoryId;
  int? get requestComplanitId => _requestComplanitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['code'] = _code;
    map['description'] = _description;
    map['attachmentComplanitHistory'] = _attachmentComplanitHistory;
    map['notificationType'] = _notificationType;
    map['notificationId'] = _notificationId;
    map['notificationState'] = _notificationState;
    map['body'] = _body;
    map['subject'] = _subject;
    map['complanitStatus'] = _complanitStatus;
    map['complanitHistoryId'] = _complanitHistoryId;
    map['requestComplanitId'] = _requestComplanitId;
    return map;
  }

}