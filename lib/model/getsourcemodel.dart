//json to dart file conversion
class GetSourceModel {
  List<Data>? data;

  GetSourceModel({this.data});

  GetSourceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? principalSourceTitle;
  String? isActive;
  String? createdBy;
  String? modifiedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.principalSourceTitle,
      this.isActive,
      this.createdBy,
      this.modifiedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    principalSourceTitle = json['principal_source_title'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['principal_source_title'] = this.principalSourceTitle;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
