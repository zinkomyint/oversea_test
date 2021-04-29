class ContactModel {
  List<Contact> contacts;
  String error;
  ContactModel({this.contacts});
  ContactModel.withError(String errorMessage) {
    error = errorMessage;
  }
  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = new List<Contact>();
      json['contacts'].forEach((v) {
        contacts.add(new Contact.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['Contact'] = this.contacts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contact {
  int id;
  String name;
  String job;
  int age;

  Contact({
    this.id,
    this.name,
    this.job,
    this.age,
  });

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    job = json['job'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['job'] = this.job;
    data['age'] = this.age;

    return data;
  }

  String error;
  Contact.withError(String errorMessage) {
    error = errorMessage;
  }
}

// import 'package:json_annotation/json_annotation.dart';
// part 'contact.g.dart';

// @JsonSerializable()
// class ContactModel {
//   int id;
//   String name;
//   String job;
//   int age;
//   ContactModel({this.name, this.job, this.age, this.id});

//   factory ContactModel.fromJson(Map<String, dynamic> json) =>
//       _$ContactModelFromJson(json);
//   Map<String, dynamic> toJson() => _$ContactModelToJson(this);

//   // String error;
//   // ContactModel.withError(String errorMessage) {
//   //   error = errorMessage;
//   // }
// }
