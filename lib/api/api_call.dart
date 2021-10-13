import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:player/api/api_resources.dart';
import 'package:player/api/http_call.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/looking_for_data.dart';
import 'package:player/model/player_data.dart';
import 'package:player/model/sport_data.dart';

class APICall {
  Future<PlayerData> checkPlayer(String phoneNumber) async {
    Uri url = Uri.parse(APIResources.CHECK_PLAYER);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['mobile'] = phoneNumber;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> addPlayer(
      String name, String phoneNumber, String dob, String gender) async {
    Uri url = Uri.parse(APIResources.ADD_PLAYER);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['name'] = name;
    params['mobile'] = phoneNumber;
    params['dob'] = dob;
    params['gender'] = gender;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<SportData> getSports() async {
    Uri url = Uri.parse(APIResources.GET_SPORT);
    HttpCall call = new HttpCall();
    http.Response response = await call.get(url);
    print("Response Body: " + response.body);
    return SportData.fromJson(jsonDecode(response.body));
  }

  Future<LookingForData> getLookingFor() async {
    Uri url = Uri.parse(APIResources.GET_LOOKING_FOR);
    HttpCall call = new HttpCall();
    http.Response response = await call.get(url);
    print("Response Body: " + response.body);
    return LookingForData.fromJson(jsonDecode(response.body));
  }

  Future<HostActivity> addHostActivity(Activity activity) async {
    Uri url = Uri.parse(APIResources.ADD_HOST_ACTIVITY);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['sport_id'] = activity.sportId!;
    params['sport_name'] = activity.sportName!;
    params['looking_for_id'] = activity.lookingForId!;
    params['looking_for'] = activity.lookingFor!;
    params['looking_for_value'] = activity.lookingForValue!;
    params['area'] = activity.area!;
    params['start_date'] = activity.startDate!;
    params['timing'] = activity.timing!;
    params['ball_type'] = activity.ballType!;
    params['player_id'] = activity.playerId!;
    params['player_name'] = activity.playerName!;
    params['location_id'] = activity.locationId!;
    params['created_at'] = activity.createdAt!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return HostActivity.fromJson(jsonDecode(response.body));
  }

  Future<HostActivity> getMyHostActivity(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_MY_HOST_ACTIVITY);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return HostActivity.fromJson(jsonDecode(response.body));
  }

  Future<HostActivity> getHostActivity(String locationId) async {
    Uri url = Uri.parse(APIResources.GET_HOST_ACTIVITY);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['location_id'] = locationId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return HostActivity.fromJson(jsonDecode(response.body));
  }

  // Future<LoginData> loginPhone(String number) async {
  //   Uri url = Uri.parse(APIResources.LOGIN_PHONE);
  //   var header = new Map<String, String>();
  //
  //   header['Content-Type'] = 'application/x-www-form-urlencoded';
  //
  //   var params = new Map<String, String>();
  //   params['phone'] = number;
  //
  //   HttpCall call = new HttpCall();
  //
  //   http.Response response = await call.post(url, header, params);
  //
  //   print("Response Body: " + response.body);
  //   return LoginData.fromJson(jsonDecode(response.body));
  // }

  // Future<AllMembers> getMembers() async {
  //   HttpCall call = new HttpCall();
  //   Uri url = Uri.parse(APIResources.GET_MEMBERS);
  //   http.Response response = await call.get(url);
  //   print("Response Body: " + response.body);
  //   return AllMembers.fromJson(jsonDecode(response.body));
  //   // return response.body;
  // }

//   Future getData() async {
//     HttpCall call = new HttpCall();
//     Uri url = Uri.parse(APIResources.ALL_PUBLIC_PROFILE);
//     http.Response response = await call.get(url);
//     return response.body;
//   }

  // Future<List<Member>> getAllMembers() async {
  //   HttpCall call = new HttpCall();
  //   Uri url = Uri.parse(APIResources.GET_MEMBERS);
  //   http.Response response = await call.get(url);
  //
  //   print("Response Body: " + response.body);
  //   var tagObjsJson = jsonDecode(response.body) as List;
  //   List<Member> memObjs =
  //       tagObjsJson.map((tagJson) => Member.fromJson(tagJson)).toList();
  //   return memObjs;
  // }

//   Future<Member> getMember(String memberId) async {
//     Uri url = Uri.parse(APIResources.MEMBER_PROFILE);
//     var header = new Map<String, String>();
//
// //    header['Content-Type'] = 'application/x-www-form-urlencoded';
//
//     var params = new Map<String, String>();
//     params['memberId'] = memberId;
//
//     HttpCall call = new HttpCall();
//
//     http.Response response = await call.post(url, header, params);
//
//     print("Response Body: " + response.body);
//     return Member.fromJson(jsonDecode(response.body));
//   }
//
//   Future<DropdownData> getDropdownData() async {
//     Uri url = Uri.parse(APIResources.DROPDOWN_DATA);
//     HttpCall call = new HttpCall();
//
//     http.Response response = await call.get(url);
//
//     print("Response Body: " + response.body);
//     return DropdownData.fromJson(jsonDecode(response.body));
//   }
//
//   Future<LoginData> loginPhone(String number) async {
//     Uri url = Uri.parse(APIResources.LOGIN_PHONE);
//     var header = new Map<String, String>();
//
// //    header['Content-Type'] = 'application/x-www-form-urlencoded';
//
//     var params = new Map<String, String>();
//     params['phone'] = number;
//
//     HttpCall call = new HttpCall();
//
//     http.Response response = await call.post(url, header, params);
//
//     print("Response Body: " + response.body);
//     return LoginData.fromJson(jsonDecode(response.body));
//   }
}
