class GetEMHTest {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  GetEMHTest({this.status, this.statusCode, this.message, this.data});

  GetEMHTest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? techMastersXid;
  int? noOfExp;
  String? difficulty;
  String? question;
  List<Answer>? answer;

  Data(
      {this.id,
      this.techMastersXid,
      this.noOfExp,
      this.difficulty,
      this.question,
      this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    techMastersXid = json['tech_masters_xid'];
    noOfExp = json['no_of_exp'];
    difficulty = json['difficulty'];
    question = json['question'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tech_masters_xid'] = this.techMastersXid;
    data['no_of_exp'] = this.noOfExp;
    data['difficulty'] = this.difficulty;
    data['question'] = this.question;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  int? id;
  int? questionXid;
  String? answer;

  Answer({this.id, this.questionXid, this.answer});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionXid = json['question_xid'];
    answer = json['answer'];
  }

  get isRight => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_xid'] = this.questionXid;
    data['answer'] = this.answer;
    return data;
  }
}
