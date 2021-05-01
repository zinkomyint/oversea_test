// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) {
  return ContactModel(
    name: json['name'] as String,
    job: json['job'] as String,
    age: json['age'] as int,
    id: json['id'] as int,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'job': instance.job,
      'age': instance.age,
      'error': instance.error,
    };
