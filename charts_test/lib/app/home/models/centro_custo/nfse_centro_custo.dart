// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NfseCentroCustoId {
  final String id;
  final String razao;
  final String fantasia;
  final String cnpj;
  final Map<String, String?> endereco;
  final dynamic contato;
  final String inscricaoEstadual;
  final String inscricaoMunicipal;
  final int regimeTributario;
  final dynamic nomeResponsavel;
  final String cpfResponsavel;
  final String tokenFocus;
  final String tokenFocusHomologacao;
  final int focusId;

  NfseCentroCustoId({
    required this.id,
    required this.razao,
    required this.fantasia,
    required this.cnpj,
    required this.endereco,
    required this.contato,
    required this.inscricaoEstadual,
    required this.inscricaoMunicipal,
    required this.regimeTributario,
    required this.nomeResponsavel,
    required this.cpfResponsavel,
    required this.tokenFocus,
    required this.tokenFocusHomologacao,
    required this.focusId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'razao': razao,
      'fantasia': fantasia,
      'cnpj': cnpj,
      'endereco': endereco,
      'contato': contato,
      'inscricao_estadual': inscricaoEstadual,
      'inscricao_municipal': inscricaoMunicipal,
      'regime_tributario': regimeTributario,
      'nome_responsavel': nomeResponsavel,
      'cpf_responsavel': cpfResponsavel,
      'token_focus': tokenFocus,
      'token_focus_homologacao': tokenFocusHomologacao,
      'focus_id': focusId,
    };
  }

  factory NfseCentroCustoId.fromMap(Map<String, dynamic> map) {
    return NfseCentroCustoId(
      id: map['id'] as String,
      razao: map['razao'] as String,
      fantasia: map['fantasia'] as String,
      cnpj: map['cnpj'] as String,
      endereco: Map<String, String?>.from((map['endereco'] as Map<String, String?>)),
      contato: map['contato'] as dynamic,
      inscricaoEstadual: map['inscricao_estadual'] as String,
      inscricaoMunicipal: map['inscricao_municipal'] as String,
      regimeTributario: map['regime_tributario'] as int,
      nomeResponsavel: map['nome_responsavel'] as dynamic,
      cpfResponsavel: map['cpf_responsavel'] as String,
      tokenFocus: map['token_focus'] as String,
      tokenFocusHomologacao: map['token_focus_homologacao'] as String,
      focusId: map['focus_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfseCentroCustoId.fromJson(String source) => NfseCentroCustoId.fromMap(json.decode(source) as Map<String, dynamic>);
}
