import 'package:json_annotation/json_annotation.dart';
part 'contact.g.dart';

@JsonSerializable()
class ContactModel {
  String error;
  int id;
  String name;
  String job;
  int age;
  ContactModel(this.name, this.job, {this.age, this.id});

  ContactModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
