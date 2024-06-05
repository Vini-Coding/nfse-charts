import 'package:charts_test/app/home/models/nfse.dart';
import 'package:flutter/cupertino.dart';

class HomeRepository extends ChangeNotifier {
  final List<Nfse> nfses = [
    Nfse(
      tipo: "Entrada",
      data: DateTime.parse("2024-05-14T12:11:34"),
      total: 1400,
      nomeEmitente: "SUNRISE",
      situacao: "autorizada",
      status: "associar",
    ),
    Nfse(
      tipo: "Entrada",
      data: DateTime.parse("2024-05-14T12:11:34"),
      total: 4015.06,
      nomeEmitente: "BRF S.A",
      situacao: "atualizar",
      status: "atualizar",
    ),
    Nfse(
      tipo: "Entrada",
      data: DateTime.parse("2024-05-14T12:11:34"),
      total: 300,
      nomeEmitente: "SUNRISE",
      situacao: "autorizada",
      status: "associar",
    ),
    Nfse(
      tipo: "Entrada",
      data: DateTime.parse("2024-05-14T12:11:34"),
      total: 803.84,
      nomeEmitente: "COMERCIAL CATARINA LTDA",
      situacao: "autorizada",
      status: "associar",
    ),
    Nfse(
      tipo: "Entrada",
      data: DateTime.parse("2024-05-14T12:11:34"),
      total: 300,
      nomeEmitente: "SUNRISE",
      situacao: "autorizada",
      status: "associar",
    ),
  ];
}
