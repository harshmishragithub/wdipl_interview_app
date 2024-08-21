class GetPersonalQModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  GetPersonalQModel({this.status, this.statusCode, this.message, this.data});

  GetPersonalQModel.fromJson(Map<String, dynamic> json) {
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
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Answer>? answer;

  Data(
      {this.id,
      this.question,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  int? id;
  int? questionXid;
  String? answere;
  int? isRight;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;

  Answer(
      {this.id,
      this.questionXid,
      this.answere,
      this.isRight,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionXid = json['question_xid'];
    answere = json['answere'];
    isRight = json['is_right'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_xid'] = this.questionXid;
    data['answere'] = this.answere;
    data['is_right'] = this.isRight;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
