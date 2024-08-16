class ApiEndpoints {
  static const base = //"https://admin.tanami.betadelivery.com/";
      "https://sprint4.tanami.betadelivery.com/"; //"https://tanami.betadelivery.com/";
  static const baseurl = //"https://admin.tanami.betadelivery.com/api/v1/";
      "http://192.168.50.178/laravel_test/public/api/";
  // "https://tanami.betadelivery.com/api/development/v1/"; //App Base url

  //Country
  static const sendpersonaldetailsapi = "${baseurl}add_user_details";

  //Register
  static const getsourceapi = "${baseurl}get_source";
  static const sendeduapi = "${baseurl}add_user_education_details";
  static const sendweapi = "${baseurl}add_user_work_experience_details";
  static const gettechapi = "${baseurl}get_technology";
  static const sendtechapi =
      "${baseurl}get_technology"; //"${baseurl}get_source";
}
