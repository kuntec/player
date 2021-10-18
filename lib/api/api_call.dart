import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:player/api/api_resources.dart';
import 'package:player/api/http_call.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/looking_for_data.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/player_data.dart';
import 'package:player/model/service_data.dart';
import 'package:player/model/sport_data.dart';
import 'dart:developer';

import 'package:player/model/tournament_data.dart';

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

  Future<PlayerData> addPlayerSport(
      String playerId, String selectedSport) async {
    log("Add Player Sport");
    Uri url = Uri.parse(APIResources.ADD_PLAYER_SPORT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    log("Add Player Sport");
    params['player_id'] = playerId;
    params['sport_id'] = selectedSport;
    params['created_at'] = Utility.getCurrentDate();

    HttpCall call = new HttpCall();

    http.Response response = await call.post(url, header, params);
    log("Response Body: " + response.body);
//    return response.body;
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> addTournament(filePath, Tournament tournament) async {
    print("add tournament");
    try {
      print("add tournament2");
      FormData formData = new FormData.fromMap({
        "organizer_name": tournament.organizerName,
        "organizer_number": tournament.organizerNumber,
        "tournament_name": tournament.tournamentName,
        "start_date": tournament.startDate,
        "end_date": tournament.endDate,
        "entry_fees": tournament.entryFees,
        "timing": tournament.timing,
        "no_of_members": tournament.noOfMembers,
        "age_limit": tournament.ageLimit,
        "address": tournament.address,
        "prize_details": tournament.prizeDetails,
        "other_info": tournament.otherInfo,
        "location_id": tournament.locationId,
        "player_id": tournament.playerId,
        "player_name": tournament.playerName,
        "sport_id": tournament.sportId,
        "sport_name": tournament.sportName,
        "created_at": tournament.createdAt,
        "image": await MultipartFile.fromFile(filePath, filename: "tournament")
      });

      Response response = await Dio().post(
        APIResources.ADD_TOURNAMENT,
        data: formData,
      );
//      return response;
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");

      // tournamentData =
      //     TournamentData.fromJson(jsonDecode(responseBody.toString()));
      //print("Response Body ${tournamentData.status}");
      return responseBody['status'];
    } on DioError catch (e) {
      print("add tournament3");
      return false;
    } catch (e) {}
  }

  Future<TournamentData> getMyTournament(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_MY_TOURNAMENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TournamentData.fromJson(jsonDecode(response.body));
  }

  Future<TournamentData> getTournament(
      String locationId, String sportId) async {
    Uri url = Uri.parse(APIResources.GET_TOURNAMENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['location_id'] = locationId;
    params['sport_id'] = sportId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TournamentData.fromJson(jsonDecode(response.body));
  }

  Future<MySport> getMySports(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_PLAYER_SPORT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return MySport.fromJson(jsonDecode(response.body));
  }

  Future<ServiceData> getService() async {
    Uri url = Uri.parse(APIResources.GET_SERVICE);
    HttpCall call = new HttpCall();
    http.Response response = await call.get(url);
    print("Response Body: " + response.body);
    return ServiceData.fromJson(jsonDecode(response.body));
  }
}
