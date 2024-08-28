class GetLogicModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  GetLogicModel({this.status, this.statusCode, this.message, this.data});

  GetLogicModel.fromJson(Map<String, dynamic> json) {
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
  String? question;
  List<Answer>? answer;

  Data({this.id, this.question, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['question'] = this.question;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  int? id;
  int? logicalQuestionsXid;
  String? answere;

  var isRight;

  Answer({this.id, this.logicalQuestionsXid, this.answere});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logicalQuestionsXid = json['logical_questions_xid'];
    answere = json['answere'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logical_questions_xid'] = this.logicalQuestionsXid;
    data['answere'] = this.answere;
    return data;
  }
}
