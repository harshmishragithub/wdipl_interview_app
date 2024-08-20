class ApiEndpoints {
  static const base = //"https://admin.tanami.betadelivery.com/";
      "https://sprint4.tanami.betadelivery.com/"; //"https://tanami.betadelivery.com/";
  static const baseurl = //"https://admin.tanami.betadelivery.com/api/v1/";
      "http://192.168.50.78/laravel_test/public/api/";
  // "https://tanami.betadelivery.com/api/development/v1/"; //App Base url

  //Country
  static const sendpersonaldetailsapi = "${baseurl}add_user_details";

  //Register
  static const getsourceapi = "${baseurl}get_source";
  static const sendeduapi = "${baseurl}add_user_education_details";
  static const sendweapi = "${baseurl}add_user_work_experience_details";
  static const gettechapi = "${baseurl}get_technology";
  static const sendtechapi = "${baseurl}store_technology";
  static const gettechqueapi = "${baseurl}get_technology_que_ans";
  static const getlogicapi = "${baseurl}get_logical_que_ans";
  static const getpersonalityquestionapi =
      "${baseurl}get_personality_que_ans"; //"${baseurl}get_source";
}
