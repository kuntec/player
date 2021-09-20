//import 'dart:convert';

// import 'package:nikahjodi/api/api_resources.dart';
// import 'package:nikahjodi/api/http_call.dart';
//import 'package:http/http.dart' as http;
// import 'package:nikahjodi/models/DropdownData.dart';
// import 'package:nikahjodi/models/LoginData.dart';
// import 'package:nikahjodi/models/Member.dart';
// import 'package:nikahjodi/models/all_members.dart';

class APICall {
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
