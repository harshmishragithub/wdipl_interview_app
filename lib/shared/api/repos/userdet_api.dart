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

  Future<ResponseData> sendTechselection(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendtechapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

  Future<ResponseData> sendPersonalityQuestion(
      Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendpersonalqapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

  Future<ResponseData> sendLogicalQuestion(Map<String, dynamic> data) async {
    String url = ApiEndpoints.sendlogoqapi;
    final response = await NetworkApiService().post(url, data);
    return response;
  }

  Future<ResponseData> getTechnology() async {
    String url = ApiEndpoints.gettechapi;
    final response = await NetworkApiService().get(url);
    return response;
  }

  Future<ResponseData> getTechnologyQuestion() async {
    String url = ApiEndpoints.gettechqueapi;
    final response = await NetworkApiService().get(url);
    return response;
  }

  Future<ResponseData> getLogicalQuestion() async {
    String url = ApiEndpoints.getlogicapi;
    final response = await NetworkApiService().get(url);
    return response;
  }

  Future<ResponseData> getPersonalityQuestion() async {
    String url = ApiEndpoints.getpersonalityquestionapi;
    final response = await NetworkApiService().get(url);
    return response;
  }
}
