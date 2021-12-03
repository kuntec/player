import 'package:flutter/material.dart';
import 'package:player/api/api_call.dart';
import 'package:player/model/banner_data.dart';

class BannerModel with ChangeNotifier {
  BannerData bannerData = BannerData();
  bool loading = false;

  getBannerData(context) async {
    loading = true;
    APICall apiCall = new APICall();
    bannerData = await apiCall.getBanner();
    loading = false;
    notifyListeners();
  }
}
