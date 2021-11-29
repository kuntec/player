import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:player/api/api_resources.dart';
import 'package:player/api/http_call.dart';
import 'package:player/constant/utility.dart';
import 'package:player/model/banner_data.dart';
import 'package:player/model/booking_data.dart';
import 'package:player/model/conversation_data.dart';
import 'package:player/model/dayslot_data.dart';
import 'package:player/model/event_data.dart';
import 'package:player/model/friend_data.dart';
import 'package:player/model/host_activity.dart';
import 'package:player/model/location_data.dart';
import 'package:player/model/looking_for_data.dart';
import 'package:player/model/my_booking_data.dart';
import 'package:player/model/my_participant_data.dart';
import 'package:player/model/my_sport.dart';
import 'package:player/model/participant_data.dart';
import 'package:player/model/player_data.dart';
import 'package:player/model/service_data.dart';
import 'package:player/model/service_model.dart';
import 'package:player/model/service_photo.dart';
import 'package:player/model/sport_data.dart';
import 'package:player/model/timeslot_data.dart';
import 'dart:developer';

import 'package:player/model/tournament_data.dart';
import 'package:player/model/venue_data.dart';
import 'package:player/model/venue_photo.dart';

class APICall {
  Future<LocationData> getLocation() async {
    Uri url = Uri.parse(APIResources.GET_LOCATION);
    HttpCall call = new HttpCall();
    http.Response response = await call.get(url);
    print("Response Body: Location " + response.body);
    return LocationData.fromJson(jsonDecode(response.body));
  }

  Future<BannerData> getBanner() async {
    Uri url = Uri.parse(APIResources.GET_BANNER);
    HttpCall call = new HttpCall();
    http.Response response = await call.get(url);
    print("Response Body: " + response.body);
    return BannerData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> getPlayers() async {
    Uri url = Uri.parse(APIResources.GET_PLAYER);
    HttpCall call = new HttpCall();
    http.Response response = await call.get(url);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> getChatPlayer(String id) async {
    Uri url = Uri.parse(APIResources.GET_CHAT_PLAYER);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<ConversationData> getMyConversation(String id) async {
    Uri url = Uri.parse(APIResources.GET_MY_CONVERSATION);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player1'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ConversationData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> getPlayerById(String id) async {
    Uri url = Uri.parse(APIResources.GET_PLAYER_BY_ID);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

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
      String name,
      String phoneNumber,
      String dob,
      String gender,
      String fuid,
      String deviceToken,
      String locationId,
      String city) async {
    Uri url = Uri.parse(APIResources.ADD_PLAYER);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['name'] = name;
    params['mobile'] = phoneNumber;
    params['dob'] = dob;
    params['gender'] = gender;
    params['f_uid'] = fuid;
    params['device_token'] = deviceToken;
    params['location_id'] = locationId;
    params['city'] = city;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> updatePlayer(Player player) async {
    Uri url = Uri.parse(APIResources.UPDATE_PLAYER);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = player.id!.toString();
    params['name'] = player.name!;
    params['mobile'] = player.mobile!;
    params['dob'] = player.dob!;
    params['gender'] = player.gender!;
    params['email'] = player.email!;
    params['location_id'] = player.locationId!;
    params['city'] = player.city!;
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
    params['role_of_player'] = activity.roleOfPlayer!;
    params['player_id'] = activity.playerId!;
    params['player_name'] = activity.playerName!;
    params['location_id'] = activity.locationId!;
    params['created_at'] = activity.createdAt!;
    params['details'] = activity.details!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return HostActivity.fromJson(jsonDecode(response.body));
  }

  Future<HostActivity> updateHostActivity(Activity activity) async {
    Uri url = Uri.parse(APIResources.UPDATE_HOST_ACTIVITY);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = activity.id.toString();
    params['sport_id'] = activity.sportId!;
    params['sport_name'] = activity.sportName!;
    params['looking_for_id'] = activity.lookingForId!;
    params['looking_for'] = activity.lookingFor!;
    params['looking_for_value'] = activity.lookingForValue!;
    params['area'] = activity.area!;
    params['start_date'] = activity.startDate!;
    params['timing'] = activity.timing!;
    params['ball_type'] = activity.ballType!;
    params['role_of_player'] = activity.roleOfPlayer!;
    params['player_id'] = activity.playerId!;
    params['player_name'] = activity.playerName!;
    params['location_id'] = activity.locationId!;
    params['created_at'] = activity.createdAt!;
    params['details'] = activity.details!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return HostActivity.fromJson(jsonDecode(response.body));
  }

  Future<HostActivity> deleteHostActivity(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_HOST_ACTIVITY);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return HostActivity.fromJson(jsonDecode(response.body));
  }

  Future<TournamentData> deleteTournament(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_TOURNAMENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TournamentData.fromJson(jsonDecode(response.body));
  }

  Future<VenueData> deleteVenue(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_VENUE);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return VenueData.fromJson(jsonDecode(response.body));
  }

  Future<EventData> deleteEvent(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_EVENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return EventData.fromJson(jsonDecode(response.body));
  }

  Future<ServiceData> deleteService(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_SERVICEDATA);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;
    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ServiceData.fromJson(jsonDecode(response.body));
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

  Future<HostActivity> getHostActivity(
      String locationId, String sportId) async {
    Uri url = Uri.parse(APIResources.GET_HOST_ACTIVITY);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['location_id'] = locationId;
    params['sport_id'] = sportId;

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
        "secondary_number": tournament.secondaryNumber,
        "tournament_name": tournament.tournamentName,
        "start_date": tournament.startDate,
        "end_date": tournament.endDate,
        "start_time": tournament.startTime,
        "end_time": tournament.endTime,
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
        "ball_type": tournament.ballType,
        "tournament_category": tournament.tournamentCategory,
        "no_of_overs": tournament.noOfOvers,
        "location_link": tournament.locationLink,
        "status": tournament.status,
        "image": await MultipartFile.fromFile(filePath, filename: "tournament")
      });

      Response response = await Dio().post(
        APIResources.ADD_TOURNAMENT,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");

      return responseBody['status'];
    } on DioError catch (e) {
      print("add tournament3");
      return false;
    } catch (e) {}
  }

  Future<TournamentData> updateTournament(Tournament tournament) async {
    log("Add Player Sport");
    Uri url = Uri.parse(APIResources.UPDATE_TOURNAMENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    log("Add Player Sport");
    params['id'] = tournament.id.toString();
    params['organizer_name'] = tournament.organizerName!;
    params['organizer_number'] = tournament.organizerNumber!;
    params['secondary_number'] = tournament.secondaryNumber!;
    params['tournament_name'] = tournament.tournamentName!;
    params['start_date'] = tournament.startDate!;
    params['end_date'] = tournament.endDate!;

    params['start_time'] = tournament.startTime!;
    params['end_time'] = tournament.endTime!;
    params['entry_fees'] = tournament.entryFees!;
    params['timing'] = tournament.timing!;
    params['no_of_members'] = tournament.noOfMembers!;

    params['age_limit'] = tournament.ageLimit!;
    params['address'] = tournament.address!;
    params['prize_details'] = tournament.prizeDetails!;
    params['other_info'] = tournament.otherInfo!;
    params['location_id'] = tournament.locationId!;

    params['player_id'] = tournament.playerId!;
    params['player_name'] = tournament.playerName!;
    params['sport_id'] = tournament.sportId!;
    params['sport_name'] = tournament.sportName!;
    params['created_at'] = tournament.createdAt!;

    params['ball_type'] = tournament.ballType!;
    params['tournament_category'] = tournament.tournamentCategory!;
    params['no_of_overs'] = tournament.noOfOvers!;
    params['location_link'] = tournament.locationLink!;
    params['status'] = tournament.status!;

    HttpCall call = new HttpCall();

    http.Response response = await call.post(url, header, params);
    log("Response Body: " + response.body);
//    return response.body;
    return TournamentData.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> updateTournamentImage(filePath, Tournament tournament) async {
    try {
      FormData formData = new FormData.fromMap({
        "id": tournament.id,
        "image": await MultipartFile.fromFile(filePath, filename: "tournament")
      });
      Response response = await Dio().post(
        APIResources.UPDATE_TOURNAMENT_IMAGE,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");

      return responseBody['status'];
    } on DioError catch (e) {
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

//  Venue

  Future<VenueData> addVenue(filePath, Venue venue) async {
    print("add venue");
    try {
      FormData formData = new FormData.fromMap({
        "name": venue.name,
        "description": venue.description,
        "open_time": venue.openTime,
        "close_time": venue.closeTime,
        "address": venue.address,
        "city": venue.city,
        "sport": venue.sport,
        "sport_id": venue.sportId,
        "location_id": venue.locationId,
        "location_link": venue.locationLink,
        "facilities": venue.facilities,
        "player_id": venue.playerId,
        "members": venue.members,
        "created_at": venue.createdAt,
        "image": await MultipartFile.fromFile(filePath, filename: "venue")
      });

      Response<String> response = await Dio().post(
        APIResources.ADD_VENUE,
        data: formData,
      );
      String responseBody = response.data.toString();
      print("Venue Response Body ${responseBody.toString()}");

      return VenueData.fromJson(jsonDecode(responseBody.toString()));
//      return responseBody['venue'];
    } on DioError catch (e) {
      print("DioError Body ${e.toString()}");
      return VenueData();
    } catch (e) {}
    return VenueData();
  }

  Future<VenueData> updateVenue(Venue venue) async {
    log("Update Venue");
    Uri url = Uri.parse(APIResources.UPDATE_VENUE);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    log("Update Venue");
    params['id'] = venue.id.toString();
    params['name'] = venue.name!;
    params['description'] = venue.description!;
    params['open_time'] = venue.openTime!;
    params['close_time'] = venue.closeTime!;
    params['address'] = venue.address!;
    params['city'] = venue.city!;

    params['sport'] = venue.sport!;
    params['sport_id'] = venue.sportId!;
    params['location_id'] = venue.locationId!;
    params['location_link'] = venue.locationLink!;
    params['facilities'] = venue.facilities!;
    params['player_id'] = venue.playerId!;
    params['members'] = venue.members!;
    params['created_at'] = venue.createdAt!;

    HttpCall call = new HttpCall();

    http.Response response = await call.post(url, header, params);
    log("Response Body: " + response.body);
//    return response.body;
    return VenueData.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> updateVenueImage(filePath, Venue venue) async {
    try {
      FormData formData = new FormData.fromMap({
        "id": venue.id,
        "image": await MultipartFile.fromFile(filePath, filename: "venue")
      });
      Response response = await Dio().post(
        APIResources.UPDATE_VENUE_IMAGE,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");

      return responseBody['status'];
    } on DioError catch (e) {
      return false;
    } catch (e) {}
  }

  Future<VenueData> getVenue(String locationId, String sportId) async {
    Uri url = Uri.parse(APIResources.GET_VENUE);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['sport_id'] = sportId;
    params['location_id'] = locationId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return VenueData.fromJson(jsonDecode(response.body));
  }

  Future<VenueData> getMyVenue(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_MY_VENUE);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return VenueData.fromJson(jsonDecode(response.body));
  }

  Future<TimeslotData> addTimeslot(Timeslot timeslot) async {
    Uri url = Uri.parse(APIResources.ADD_TIMESLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['day'] = timeslot.day!;
    params['start_time'] = timeslot.startTime!;
    params['end_time'] = timeslot.endTime!;
    params['venue_id'] = timeslot.venueId!;
    params['no_slot'] = timeslot.noSlot!;
    params['price'] = timeslot.price!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TimeslotData.fromJson(jsonDecode(response.body));
  }

  Future<TimeslotData> getTimeslot(String venueId) async {
    Uri url = Uri.parse(APIResources.GET_TIMESLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['venue_id'] = venueId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TimeslotData.fromJson(jsonDecode(response.body));
  }

  Future<TimeslotData> deleteTimeslot(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_TIMESLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TimeslotData.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> addVenuePhoto(filePath, String venueId) async {
    print("add venue");
    try {
      FormData formData = new FormData.fromMap({
        "venue_id": venueId,
        "created_at": Utility.getCurrentDate(),
        "image": await MultipartFile.fromFile(filePath, filename: "venuephoto")
      });

      Response response = await Dio().post(
        APIResources.ADD_VENUE_PHOTO,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");
      return responseBody['status'];
    } on DioError catch (e) {
      return false;
    } catch (e) {}
  }

  Future<VenuePhoto> getVenuePhoto(String venueId) async {
    Uri url = Uri.parse(APIResources.GET_VENUE_PHOTO);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['venue_id'] = venueId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return VenuePhoto.fromJson(jsonDecode(response.body));
  }

  Future<VenuePhoto> deleteVenuePhoto(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_VENUE_PHOTO);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return VenuePhoto.fromJson(jsonDecode(response.body));
  }

  Future<ServiceModel> getServiceDataId(
      String serviceId, String sportId) async {
    Uri url = Uri.parse(APIResources.GET_SERVICEDATA_ID);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['service_id'] = serviceId;
    params['sport_id'] = sportId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ServiceModel.fromJson(jsonDecode(response.body));
  }

  Future<ServiceModel> getPlayerServiceData(
      String serviceId, String playerId) async {
    Uri url = Uri.parse(APIResources.GET_PLAYER_SERVICEDATA);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['service_id'] = serviceId;
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Player Service: " + response.body);
    return ServiceModel.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> addServiceData(filePath, Service service) async {
    print("add service data");
    try {
      FormData formData = new FormData.fromMap({
        "service_id": service.serviceId,
        "player_id": service.playerId,
        "name": service.name,
        "address": service.address,
        "city": service.city,
        "contact_name": service.contactName,
        "contact_no": service.contactNo,
        "secondary_no": service.secondaryNo,
        "about": service.about,
        "location_link": service.locationLink,
        "monthly_fees": service.monthlyFees,
        "coaches": service.coaches,
        "fees_per_match": service.feesPerMatch,
        "fees_per_day": service.feesPerDay,
        "experience": service.experience,
        "company_name": service.companyName,
        "sport_id": service.sportId,
        "sport_name": service.sportName,
        "created_at": Utility.getCurrentDate(),
        "image": await MultipartFile.fromFile(filePath, filename: "servicedata")
      });

      Response response = await Dio().post(
        APIResources.ADD_SERVICEDATA,
        data: formData,
      );
      print("add service data1");
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");
      print("Service New ID ${responseBody['service']['id']}");
      return responseBody['service']['id'];
    } on DioError catch (e) {
      print("Response Body NO FOUND");
      return false;
    } catch (e) {
      print("Something Wrong ${e.toString()}");
    }
  }

  Future<ServiceData> updateServiceData(Service service) async {
    Uri url = Uri.parse(APIResources.UPDATE_SERVICEDATA);
    var header = new Map<String, String>();
    var params = new Map<String, String>();

    params['id'] = service.id.toString();
    params['service_id'] = service.serviceId.toString();
    params['player_id'] = service.playerId!;
    params['name'] = service.name!;
    params['address'] = service.address!;
    params['city'] = service.city!;

    params['contact_name'] = service.contactName!;
    params['contact_no'] = service.contactNo!;
    params['secondary_no'] = service.secondaryNo!;
    params['about'] = service.about!;
    params['location_link'] = service.locationLink!;

    params['monthly_fees'] = service.monthlyFees!;
    params['coaches'] = service.coaches!;
    params['fees_per_match'] = service.feesPerMatch!;
    params['fees_per_day'] = service.feesPerDay!;
    params['experience'] = service.experience!;

    params['company_name'] = service.companyName!;
    params['sport_id'] = service.sportId!;
    params['sport_name'] = service.sportName!;
    params['created_at'] = Utility.getCurrentDate();

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ServiceData.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> updateServicePosterImage(filePath, String id) async {
    try {
      FormData formData = new FormData.fromMap({
        "id": id,
        "image":
            await MultipartFile.fromFile(filePath, filename: "servicephoto")
      });
      Response response = await Dio().post(
        APIResources.UPDATE_SERVICEDATA_POSTER_IMAGE,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");
      return responseBody['status'];
    } on DioError catch (e) {
      return false;
    } catch (e) {}
  }

  Future<dynamic> addServicePhoto(filePath, String serviceId) async {
    try {
      FormData formData = new FormData.fromMap({
        "service_id": serviceId,
        "status": "1",
        "created_at": Utility.getCurrentDate(),
        "image":
            await MultipartFile.fromFile(filePath, filename: "servicephoto")
      });

      Response response = await Dio().post(
        APIResources.ADD_SERVICE_PHOTO,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");
      return responseBody['status'];
    } on DioError catch (e) {
      return false;
    } catch (e) {}
  }

  Future<ServicePhoto> getServicePhoto(String serviceId) async {
    Uri url = Uri.parse(APIResources.GET_SERVICE_PHOTO);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['service_id'] = serviceId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ServicePhoto.fromJson(jsonDecode(response.body));
  }

  Future<ServicePhoto> deleteServicePhoto(String id) async {
    Uri url = Uri.parse(APIResources.DELETE_SERVICE_PHOTO);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = id;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ServicePhoto.fromJson(jsonDecode(response.body));
  }

  Future<DayslotData> addDaySlot(DaySlot daySlot) async {
    Uri url = Uri.parse(APIResources.ADD_DAY_SLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['venue_id'] = daySlot.venueId!;
    params['day'] = daySlot.day!;
    params['open'] = daySlot.open!;
    params['close'] = daySlot.close!;
    params['status'] = daySlot.status!;
    params['created_at'] = daySlot.createdAt!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return DayslotData.fromJson(jsonDecode(response.body));
  }

  Future<DayslotData> updateDaySlot(DaySlot daySlot) async {
    Uri url = Uri.parse(APIResources.UPDATE_DAY_SLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = daySlot.id!.toString();
    params['venue_id'] = daySlot.venueId!;
    params['day'] = daySlot.day!;
    params['open'] = daySlot.open!;
    params['close'] = daySlot.close!;
    params['status'] = daySlot.status!;
    params['created_at'] = Utility.getCurrentDate();

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return DayslotData.fromJson(jsonDecode(response.body));
  }

  Future<DayslotData> getDaySlot(String venueId) async {
    Uri url = Uri.parse(APIResources.GET_DAY_SLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['venue_id'] = venueId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return DayslotData.fromJson(jsonDecode(response.body));
  }

  Future<TimeslotData> getDayTimeslot(String venueId) async {
    Uri url = Uri.parse(APIResources.GET_DAY_TIME_SLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['venue_id'] = venueId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TimeslotData.fromJson(jsonDecode(response.body));
  }

  Future<TimeslotData> updateDayTimeslot(
      Timeslot timeslot, int isDayStop) async {
    Uri url = Uri.parse(APIResources.UPDATE_DAY_TIME_SLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = timeslot.id.toString();
    params['no_slot'] = timeslot.noSlot.toString();
    params['price'] = timeslot.price.toString();
    params['booking_status'] = timeslot.bookingStatus.toString();
    params['day_stop'] = isDayStop.toString();

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return TimeslotData.fromJson(jsonDecode(response.body));
  }

  // Future<DayslotData> addDayTimeSlot(String venueId) async {
  //   Uri url = Uri.parse(APIResources.ADD_DAY_TIME_SLOT);
  //   var header = new Map<String, String>();
  //   var params = new Map<String, String>();
  //   params['venue_id'] = venueId;
  //
  //   HttpCall call = new HttpCall();
  //   http.Response response = await call.post(url, header, params);
  //   print("Response Body: " + response.body);
  //   return DayslotData.fromJson(jsonDecode(response.body));
  // }

  //Event API

  Future<dynamic> addEvent(filePath, Event event) async {
    try {
      FormData formData = new FormData.fromMap({
        "player_id": event.playerId,
        "name": event.name,
        "type": event.type,
        "description": event.description,
        "status": event.status,
        "start_date": event.startDate,
        "end_date": event.endDate,
        "start_time": event.startTime,
        "end_time": event.endTime,
        "entry_fees": event.entryFees,
        "members": event.members,
        "address": event.address,
        "location_id": event.locationId,
        "location_link": event.locationLink,
        "details": event.details,
        "organizer_name": event.organizerName,
        "number": event.number,
        "secondary_number": event.secondaryNumber,
        "created_at": event.createdAt,
        "image": await MultipartFile.fromFile(filePath, filename: "event")
      });

      Response response = await Dio().post(
        APIResources.ADD_EVENT,
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

  Future<EventData> updateEvent(Event event) async {
    Uri url = Uri.parse(APIResources.UPDATE_EVENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();

    params['id'] = event.id.toString();
    params['player_id'] = event.playerId!;
    params['name'] = event.name!;
    params['type'] = event.type!;
    params['description'] = event.description!;
    params['status'] = event.status!;

    params['start_date'] = event.startDate!;
    params['end_date'] = event.endDate!;
    params['start_time'] = event.startTime!;
    params['end_time'] = event.endTime!;
    params['entry_fees'] = event.entryFees!;

    params['members'] = event.members!;
    params['address'] = event.address!;
    params['location_id'] = event.locationId!;
    params['location_link'] = event.locationLink!;
    params['details'] = event.details!;

    params['organizer_name'] = event.organizerName!;
    params['number'] = event.number!;
    params['secondary_number'] = event.secondaryNumber!;

    params['created_at'] = event.createdAt!;

    HttpCall call = new HttpCall();

    http.Response response = await call.post(url, header, params);
    log("Response Body: " + response.body);
//    return response.body;
    return EventData.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> updateEventImage(filePath, Event event) async {
    try {
      FormData formData = new FormData.fromMap({
        "id": event.id,
        "image": await MultipartFile.fromFile(filePath, filename: "tournament")
      });
      Response response = await Dio().post(
        APIResources.UPDATE_EVENT_IMAGE,
        data: formData,
      );
      var responseBody = response.data;
      print("Response Body ${responseBody['status']}");

      return responseBody['status'];
    } on DioError catch (e) {
      return false;
    } catch (e) {}
  }

  Future<EventData> getMyEvent(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_MY_EVENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body2: " + response.body);
    return EventData.fromJson(jsonDecode(response.body));
  }

  Future<EventData> getEvent(String locationId) async {
    Uri url = Uri.parse(APIResources.GET_EVENT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['location_id'] = locationId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body1: " + response.body);
    return EventData.fromJson(jsonDecode(response.body));
  }

  Future<ParticipantData> addParticipant(Participant participant) async {
    Uri url = Uri.parse(APIResources.ADD_PARTICIPANT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['name'] = participant.name!.toString();
    params['player_id'] = participant.playerId!.toString();
    params['status'] = participant.status!;
    params['type'] = participant.type!;
    params['number'] = participant.number!;
    params['amount'] = participant.amount!;
    params['age'] = participant.age!;
    params['event_id'] = participant.eventId!;
    params['gender'] = participant.gender!;
    params['payment_id'] = participant.paymentId!;
    params['payment_mode'] = participant.paymentMode!;
    params['payment_status'] = participant.paymentStatus!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ParticipantData.fromJson(jsonDecode(response.body));
  }

  Future<ParticipantData> updateParticipant(participant) async {
    Uri url = Uri.parse(APIResources.UPDATE_PARTICIPANT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = participant.id!.toString();
    params['status'] = participant.status!;
    params['payment_mode'] = participant.paymentMode!;
    params['payment_status'] = participant.paymentStatus!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ParticipantData.fromJson(jsonDecode(response.body));
  }

  Future<ParticipantData> getParticipant(String eventId, String type) async {
    Uri url = Uri.parse(APIResources.GET_PARTICIPANT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['event_id'] = eventId;
    params['type'] = type;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return ParticipantData.fromJson(jsonDecode(response.body));
  }

  Future<BookingData> addBooking(Booking booking) async {
    Uri url = Uri.parse(APIResources.ADD_BOOKING);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['name'] = booking.name!;
    params['number'] = booking.number!;
    params['gender'] = booking.gender!;
    params['age'] = booking.age!;
    params['player_id'] = booking.playerId!;
    params['sport_id'] = booking.sportId!;
    params['venue_id'] = booking.venueId!;
    params['payment_mode'] = booking.paymentMode!;
    params['payment_status'] = booking.paymentStatus!;
    params['booking_status'] = booking.bookingStatus!;
    params['amount'] = booking.amount!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return BookingData.fromJson(jsonDecode(response.body));
  }

  Future<BookingData> addBookingSlot(Slot slot) async {
    Uri url = Uri.parse(APIResources.ADD_BOOKING_SLOT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['booking_id'] = slot.bookingId!;
    params['venue_id'] = slot.venueId!;
    params['time_slot_id'] = slot.timeSlotId!;
    params['booking_date'] = slot.bookingDate!;
    params['day'] = slot.day!;
    params['start_time'] = slot.startTime!;
    params['price'] = slot.price!;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return BookingData.fromJson(jsonDecode(response.body));
  }

  Future<MyBookingData> getOwnerBookings(String ownerId) async {
    Uri url = Uri.parse(APIResources.GET_OWNER_BOOKINGS);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['owner_id'] = ownerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return MyBookingData.fromJson(jsonDecode(response.body));
  }

  Future<MyBookingData> getMyBookings(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_MY_BOOKINGS);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return MyBookingData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> addFriend(String playerId1, String playerId2) async {
    Uri url = Uri.parse(APIResources.ADD_FRIEND);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id1'] = playerId1;
    params['player_id2'] = playerId2;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> updateFriend(
      String playerId1, String playerId2, String status) async {
    Uri url = Uri.parse(APIResources.UPDATE_FRIEND);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id1'] = playerId1;
    params['player_id2'] = playerId2;
    params['status'] = status;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<PlayerData> removeFriend(String playerId1, String playerId2) async {
    Uri url = Uri.parse(APIResources.REMOVE_FRIEND);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id1'] = playerId1;
    params['player_id2'] = playerId2;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return PlayerData.fromJson(jsonDecode(response.body));
  }

  Future<FriendData> getRequestFriend(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_FRIEND_REQUEST);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return FriendData.fromJson(jsonDecode(response.body));
  }

  Future<FriendData> listFriend(String playerId) async {
    Uri url = Uri.parse(APIResources.LIST_FRIENDS);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return FriendData.fromJson(jsonDecode(response.body));
  }

  Future<void> chatNotification(
      String playerId, String title, String body) async {
    Uri url = Uri.parse(APIResources.CHAT_NOTIFICATION);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['id'] = playerId;
    params['title'] = title;
    params['body'] = body;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
  }

  Future<void> addConversation(
      String player1, String player2, String message) async {
    Uri url = Uri.parse(APIResources.ADD_CONVERSATION);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player1'] = player1;
    params['player2'] = player2;
    params['message'] = message;
    params['status'] = "0";

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
  }

  Future<FriendData> updateConversationStatus(
      String cId, String playerId) async {
    Uri url = Uri.parse(APIResources.UPDATE_CONVERSATION_STATUS);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['c_id'] = cId;
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return FriendData.fromJson(jsonDecode(response.body));
  }

  Future<MyParticipantData> getEventParticipant(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_EVENT_PARTICIPANT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return MyParticipantData.fromJson(jsonDecode(response.body));
  }

  Future<MyParticipantData> getTournamentParticipant(String playerId) async {
    Uri url = Uri.parse(APIResources.GET_TOURNAMENT_PARTICIPANT);
    var header = new Map<String, String>();
    var params = new Map<String, String>();
    params['player_id'] = playerId;

    HttpCall call = new HttpCall();
    http.Response response = await call.post(url, header, params);
    print("Response Body: " + response.body);
    return MyParticipantData.fromJson(jsonDecode(response.body));
  }
}
