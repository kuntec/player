/// status : true
/// message : "Notifications Found"
/// notifications : [{"id":1,"title":"demo","body":"sample testing","created_at":"16-1-2022"},{"id":2,"title":"test","body":"test","created_at":"2022-01-25 07:07:52"}]

class NotificationData {
  NotificationData({
    bool? status,
    String? message,
    List<Notifications>? notifications,
  }) {
    _status = status;
    _message = message;
    _notifications = notifications;
  }

  NotificationData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Notifications>? _notifications;

  bool? get status => _status;
  String? get message => _message;
  List<Notifications>? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// title : "demo"
/// body : "sample testing"
/// created_at : "16-1-2022"

class Notifications {
  Notifications({
    int? id,
    String? title,
    String? body,
    String? createdAt,
  }) {
    _id = id;
    _title = title;
    _body = body;
    _createdAt = createdAt;
  }

  Notifications.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _title;
  String? _body;
  String? _createdAt;

  int? get id => _id;
  String? get title => _title;
  String? get body => _body;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['created_at'] = _createdAt;
    return map;
  }
}
