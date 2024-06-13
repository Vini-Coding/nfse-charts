import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

import '../../models/nfse.dart';

class HomeStore extends ChangeNotifier {
  late final List<Nfse> nfses;
  final Map<String, int> fornecedores = {};
  final Map<String, int> situacoes = {};
  final Map<String, int> centrosCusto = {};
  final Map<String, int> status = {};
  final Map<String, double> totalPorEmitente = {};


  void init(HomeRepository repository) {
    Map<String, dynamic> jsonData = repository.getData();
    Nfses nfsesData = Nfses.fromMap(jsonData);

    nfses = nfsesData.nfsesList;

    for (Nfse nfse in nfses) {
      //PIE CHARTS
      fornecedores[nfse.nomeEmitente] =
          (fornecedores[nfse.nomeEmitente] ?? 0) + 1;
      situacoes[nfse.situacao] = (situacoes[nfse.situacao] ?? 0) + 1;
      centrosCusto[nfse.centroCustoId.fantasia] =
          (centrosCusto[nfse.centroCustoId.fantasia] ?? 0) + 1;
      status[nfse.status] = (status[nfse.status] ?? 0) + 1;

      // BAR CHARTS
      totalPorEmitente[nfse.nomeEmitente] =
          (totalPorEmitente[nfse.nomeEmitente] ?? 0) + nfse.totalNf;
    }
  }
}
