class FormData {
  String name;
  String date;
  String positionapp;
  String gender;
  String source;
  String dob;
  int age;
  int contactno;
  String email;
  String presentadd;
  String permanentadd;

  FormData(
      {required this.name,
      required this.date,
      required this.positionapp,
      required this.gender,
      required this.source,
      required this.dob,
      required this.age,
      required this.contactno,
      required this.email,
      required this.presentadd,
      required this.permanentadd});
}

class FormData2 {
  String compname;
  String designation;
  String duration;
  String reasonleave;

  int salary;

  FormData2({
    required this.compname,
    required this.designation,
    required this.duration,
    required this.reasonleave,
    required this.salary,
  });
}

class FormData3 {
  String referralname;
  String designation1;
  String organization;

  int phoneno;

  FormData3({
    required this.referralname,
    required this.designation1,
    required this.organization,
    required this.phoneno,
  });
}
