/// status : true
/// message : "Services Found"
/// services : [{"id":1,"name":"Personal Coach","icon":"services/J7cUfpqV0lh5Mu4Vs1B80doSU9XY4p9XFpQZZmcn.png"},{"id":2,"name":"Trophy Sellers","icon":"services/phiS6WmggXtuf2Vq6hxd4qdlGMUUy4HgkIu33QdB.png"},{"id":3,"name":"Manufacturers","icon":"services/tR9JCGom2V9BNCnUh97glByKwpaavwfjsjTs7Jxn.png"},{"id":4,"name":"Scorers","icon":"services/PJ4zR7EDsD9pLN5N01UTDTXj2VbMlUVRmDkyoZOF.png"},{"id":5,"name":"Organiser","icon":"services/op3TyXgo3rt05myMO16jiTi4R9dmjs3alLtRRByf.png"},{"id":6,"name":"Academy","icon":"services/O5nQzP5dokjZ3DQoUhrCJYsRZMjcI7rBhtfFd358.png"},{"id":7,"name":"T-shirt Sellers","icon":"services/FnC5bRyDjWst0I8tnSOInGopM8jTXwuvONl7Jwlk.png"},{"id":8,"name":"Sports Market","icon":"services/2b5ZuhHKWNyGfXLwgTTrYOcpamECX2PXt4Fpe5bb.png"},{"id":9,"name":"Umpires","icon":"services/uHnI9rjhd0sgyDTg4AcU7vtHETzaie2fuCuHOX6N.png"},{"id":10,"name":"Physio & Fitness","icon":"services/HXbuBWNH017vQe47qgQ70Z4LwecItVgYl7GGnuq3.png"},{"id":11,"name":"Commentator","icon":"services/XH9TPOt9f8Vi75uk6YBPtUUDgABcrBCu5OS9YNxz.png"},{"id":12,"name":"Helpers","icon":"services/subcgT2E4xeE4PnT1qGrI3atJ3yWr3EZCI3mWc5q.png"},{"id":13,"name":"Item Rental","icon":"services/9dvJ3WraVPbemUIoPF10t6NHnGU8quaavWaFIe2U.png"}]

class ServiceData {
  ServiceData({
    bool? status,
    String? message,
    List<Services>? services,
  }) {
    _status = status;
    _message = message;
    _services = services;
  }

  ServiceData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Services>? _services;

  bool? get status => _status;
  String? get message => _message;
  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Personal Coach"
/// icon : "services/J7cUfpqV0lh5Mu4Vs1B80doSU9XY4p9XFpQZZmcn.png"

class Services {
  Services({
    int? id,
    String? name,
    String? icon,
  }) {
    _id = id;
    _name = name;
    _icon = icon;
  }

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
  }
  int? _id;
  String? _name;
  String? _icon;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    return map;
  }
}
