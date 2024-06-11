// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PessoaMateriaPrima {
  String id;
  String tipo;
  String pessoa;
  String nomerazao;
  String fantasiacontato;
  String cpfcnpj;

  PessoaMateriaPrima({
    required this.id,
    required this.tipo,
    required this.pessoa,
    required this.nomerazao,
    required this.fantasiacontato,
    required this.cpfcnpj,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo,
      'pessoa': pessoa,
      'nomerazao': nomerazao,
      'fantasiacontato': fantasiacontato,
      'cpfcnpj': cpfcnpj,
    };
  }

  factory PessoaMateriaPrima.fromMap(Map<String, dynamic> map) {
    return PessoaMateriaPrima(
      id: map['id'] as String,
      tipo: map['tipo'] as String,
      pessoa: map['pessoa'] as String,
      nomerazao: map['nomerazao'] as String,
      fantasiacontato: map['fantasiacontato'] as String,
      cpfcnpj: map['cpfcnpj'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PessoaMateriaPrima.fromJson(String source) =>
      PessoaMateriaPrima.fromMap(json.decode(source) as Map<String, dynamic>);
}
