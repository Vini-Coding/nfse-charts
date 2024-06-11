// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NfsePgto {
  String id;
  String formaPgto;
  String valorPgto;

  NfsePgto({
    required this.id,
    required this.formaPgto,
    required this.valorPgto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'formaPgto': formaPgto,
      'valorPgto': valorPgto,
    };
  }

  factory NfsePgto.fromMap(Map<String, dynamic> map) {
    return NfsePgto(
      id: map['id'] as String,
      formaPgto: map['formaPgto'] as String,
      valorPgto: map['valorPgto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfsePgto.fromJson(String source) => NfsePgto.fromMap(json.decode(source) as Map<String, dynamic>);
}
