import 'package:wdipl_interview_app/shared/api/base_manager.dart';

import '../../../../shared/api/api_endpoints.dart';
import '../../../../shared/api/network_api_services.dart';

class PersonalInfoAPIServices {
  PersonalInfoAPIServices();
  Future<ResponseData> sendPersonalDetails(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendpersonaldetailsapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }
}
