/// status : true
/// message : "Notifications Found"
/// unread : [{"id":3,"notification_id":"30","player_id":"79","status":"0"}]

class UnreadNotificationData {
  UnreadNotificationData({
    bool? status,
    String? message,
    List<Unread>? unread,
  }) {
    _status = status;
    _message = message;
    _unread = unread;
  }

  UnreadNotificationData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['unread'] != null) {
      _unread = [];
      json['unread'].forEach((v) {
        _unread?.add(Unread.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Unread>? _unread;

  bool? get status => _status;
  String? get message => _message;
  List<Unread>? get unread => _unread;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_unread != null) {
      map['unread'] = _unread?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3
/// notification_id : "30"
/// player_id : "79"
/// status : "0"

class Unread {
  Unread({
    int? id,
    String? notificationId,
    String? playerId,
    String? status,
  }) {
    _id = id;
    _notificationId = notificationId;
    _playerId = playerId;
    _status = status;
  }

  Unread.fromJson(dynamic json) {
    _id = json['id'];
    _notificationId = json['notification_id'];
    _playerId = json['player_id'];
    _status = json['status'];
  }
  int? _id;
  String? _notificationId;
  String? _playerId;
  String? _status;

  int? get id => _id;
  String? get notificationId => _notificationId;
  String? get playerId => _playerId;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['notification_id'] = _notificationId;
    map['player_id'] = _playerId;
    map['status'] = _status;
    return map;
  }
}
