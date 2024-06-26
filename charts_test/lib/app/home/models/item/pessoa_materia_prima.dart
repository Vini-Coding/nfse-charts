// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MateriaPrimaIdPessoaId {
  final String id;
  final String tipo;
  final String pessoa;
  final String nomerazao;
  final String fantasiacontato;
  final String cpfcnpj;
  final Map<String, String?> endereco;
  final dynamic contato;
  final dynamic celular;
  final dynamic email;
  final List<dynamic> contatos;

  MateriaPrimaIdPessoaId({
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
      'endereco': endereco,
      'contato': contato,
      'celular': celular,
      'email': email,
      'contatos': contatos,
    };
  }

  factory MateriaPrimaIdPessoaId.fromMap(Map<String, dynamic> map) {
    return MateriaPrimaIdPessoaId(
      id: map['id'] as String,
      tipo: map['tipo'] as String,
      pessoa: map['pessoa'] as String,
      nomerazao: map['nomerazao'] as String,
      fantasiacontato: map['fantasiacontato'] as String,
      cpfcnpj: map['cpfcnpj'] as String,
      endereco: Map<String, String?>.from(
        (map['endereco'] as Map<String, String?>),
      ),
      contato: map['contato'] as dynamic,
      celular: map['celular'] as dynamic,
      email: map['email'] as dynamic,
      contatos: List<dynamic>.from(
        (map['contatos'] as List<dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MateriaPrimaIdPessoaId.fromJson(String source) =>
      MateriaPrimaIdPessoaId.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
