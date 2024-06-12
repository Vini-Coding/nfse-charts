// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:charts_test/app/home/models/pessoa/nfse_pessoa_endereco.dart';

class NfsePessoaId {
  final String id;
  final String tipo;
  final String pessoa;
  final String nomerazao;
  final String fantasiacontato;
  final String cpfcnpj;
  final Endereco endereco;
  final dynamic contato;
  final dynamic celular;
  final dynamic email;
  final List<dynamic> contatos;

  NfsePessoaId({
    required this.id,
    required this.tipo,
    required this.pessoa,
    required this.nomerazao,
    required this.fantasiacontato,
    required this.cpfcnpj,
    required this.endereco,
    required this.contato,
    required this.celular,
    required this.email,
    required this.contatos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo,
      'pessoa': pessoa,
      'nomerazao': nomerazao,
      'fantasiacontato': fantasiacontato,
      'cpfcnpj': cpfcnpj,
      'endereco': endereco.toMap(),
      'contato': contato,
      'celular': celular,
      'email': email,
      'contatos': contatos,
    };
  }

  factory NfsePessoaId.fromMap(Map<String, dynamic> map) {
    return NfsePessoaId(
      id: map['id'] as String,
      tipo: map['tipo'] as String,
      pessoa: map['pessoa'] as String,
      nomerazao: map['nomerazao'] as String,
      fantasiacontato: map['fantasiacontato'] as String,
      cpfcnpj: map['cpfcnpj'] as String,
      endereco: Endereco.fromMap(map['endereco'] as Map<String, dynamic>),
      contato: map['contato'] as dynamic,
      celular: map['celular'] as dynamic,
      email: map['email'] as dynamic,
      contatos: List<dynamic>.from(
        (map['contatos'] as List<dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NfsePessoaId.fromJson(String source) =>
      NfsePessoaId.fromMap(json.decode(source) as Map<String, dynamic>);
}
