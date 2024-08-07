class ApiEndpoints {
  static const base = //"https://admin.tanami.betadelivery.com/";
      "https://sprint4.tanami.betadelivery.com/"; //"https://tanami.betadelivery.com/";
  static const baseurl = //"https://admin.tanami.betadelivery.com/api/v1/";
      "192.168.50.102/laravel_test/public/api/";
  // "https://tanami.betadelivery.com/api/development/v1/"; //App Base url

  //Country
  static const sendpersonaldetailsapi = "${baseurl}add_user_details";

  //Register
  static const requestotpapi = "${baseurl}auth/user/register-mobileNumber";
  static const registerrequestapi = "${baseurl}auth/user/registration";
}
