/// id : 4
/// sport_name : "Tennis"
/// sport_desc : "tournament tennis"
/// sport_icon : "sports/zjO3R55k9B4i3XtUB2qRuFYehkEv4iDe3bxOpuOT.jpg"
/// created_at : "2021-10-06 08:02:50"
/// sport_category_id : "2"

class Sport {
  Sport({
    int? id,
    String? sportName,
    String? sportDesc,
    String? sportIcon,
    String? createdAt,
    String? sportCategoryId,
  }) {
    _id = id;
    _sportName = sportName;
    _sportDesc = sportDesc;
    _sportIcon = sportIcon;
    _createdAt = createdAt;
    _sportCategoryId = sportCategoryId;
  }

  Sport.fromJson(dynamic json) {
    _id = json['id'];
    _sportName = json['sport_name'];
    _sportDesc = json['sport_desc'];
    _sportIcon = json['sport_icon'];
    _createdAt = json['created_at'];
    _sportCategoryId = json['sport_category_id'];
  }
  int? _id;
  String? _sportName;
  String? _sportDesc;
  String? _sportIcon;
  String? _createdAt;
  String? _sportCategoryId;

  int? get id => _id;
  String? get sportName => _sportName;
  String? get sportDesc => _sportDesc;
  String? get sportIcon => _sportIcon;
  String? get createdAt => _createdAt;
  String? get sportCategoryId => _sportCategoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sport_name'] = _sportName;
    map['sport_desc'] = _sportDesc;
    map['sport_icon'] = _sportIcon;
    map['created_at'] = _createdAt;
    map['sport_category_id'] = _sportCategoryId;
    return map;
  }
}
