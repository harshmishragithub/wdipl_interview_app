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

  Future<ResponseData> getSourceapi() async {
    String url = ApiEndpoints.getsourceapi;
    final response = await NetworkApiService().get(url);
    return response;
  }

  Future<ResponseData> sendEducation(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendeduapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

  Future<ResponseData> sendWorkExperience(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendweapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

  Future<ResponseData> getTechnology() async {
    String url = ApiEndpoints.gettechapi;
    final response = await NetworkApiService().get(url);
    return response;
  }
}
