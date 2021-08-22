import 'package:littleshops/data/model/error_model.dart';
import 'package:littleshops/data/model/push_notification_model.dart';
import 'package:littleshops/data/request/api_url.dart';
import 'package:littleshops/data/request/request.dart';

class PushRepository {
  Request _request = Request(baseUrl: LocationApi.API_URL_PUSH);

  Future<String> generateNotificationPush(PushNotificationModel model) async {
    String url = "/sendPush";
    var res = await _request
        .requestApi(method: MethodType.POST, url: url, data: model.toMap()!);

    print("Hola");
    if (res is ErrorModel) return "Error";

    var data = (res as Map<String, dynamic>);
    var chiefId = data["businessId"] as String;
    return chiefId;
  }

}