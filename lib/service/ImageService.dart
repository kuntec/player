import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:player/api/api_resources.dart';

class ImageService {
  static Future<dynamic> uploadFile(filePath, playerId) async {
    print("Player id image upload $playerId");
    try {
      FormData formData = new FormData.fromMap({
        "id": playerId,
        "image": await MultipartFile.fromFile(filePath, filename: "player")
      });

      Response response = await Dio().post(
        APIResources.UPDATE_PLAYER_IMAGE,
        data: formData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {}
  }
}
