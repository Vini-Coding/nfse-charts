import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/item/nfse_item.dart';
import '../../models/nfse.dart';

class HomeStore extends ChangeNotifier {
  final HomeRepository repository;

  HomeStore({required this.repository});

  late final List<Nfse> nfses;
  late List<Nfse> filteredNfses;
  List<NfseItem> filteredNfseItems = [];
  Map<String, int> fornecedores = {};
  Map<String, int> situacoes = {};
  Map<String, int> centrosCusto = {};
  Map<String, int> status = {};
  Map<String, int> materiasPrima = {};
  Map<String, double> totalPorEmitente = {};
  late List<MapEntry> sortedFornecedores;
  late List<MapEntry> sortedSituacoes;
  late List<MapEntry> sortedCentroCusto;
  late List<MapEntry> sortedStatus;
  late List<MapEntry> sortedMateriasPrima;
  double totalGasto = 0;
  List<DateTime> dates = [];
  String currentCentroCusto = "TODOS";
  List<String> centrosCustoSelection = ["TODOS"];
  String currentPeriodoSelection = "";
  List<String> periodoSelection = [
    "Hoje",
    "Ontem",
    "Nos últimos 7 dias",
    "Nos últimos 30 dias",
    "Personalizado",
  ];

  void init() {
    Map<String, dynamic> jsonData = repository.getData();
    Nfses nfsesData = Nfses.fromMap(jsonData);

    nfses = nfsesData.nfsesList;
    filteredNfses = nfses;

    updateChartsMaps();
    updateAndSortLists(updateCentroCustoSelection: true);
    updateTotalGasto();
    updateCurrentPeriodo();
  }

  void updateCurrentPeriodo() {
    currentPeriodoSelection =
        "até ${DateFormat('dd/MM/yyyy').format(dates.last)}";
  }

  void updateTotalGasto() {
    totalGasto = 0;
    for (var nfse in filteredNfses) {
      totalGasto = totalGasto + nfse.totalNf;
    }
  }

  void updateChartsMaps() {
    for (Nfse nfse in filteredNfses) {
      //PIE CHARTS
      fornecedores[nfse.nomeEmitente] =
          (fornecedores[nfse.nomeEmitente] ?? 0) + 1;
      situacoes[nfse.situacao] = (situacoes[nfse.situacao] ?? 0) + 1;
      centrosCusto[nfse.centroCustoId.fantasia] =
          (centrosCusto[nfse.centroCustoId.fantasia] ?? 0) + 1;
      status[nfse.status] = (status[nfse.status] ?? 0) + 1;
      for (NfseItem item in nfse.itens) {
        materiasPrima[item.materiaPrimaId.nome] =
            (materiasPrima[item.materiaPrimaId.nome] ?? 0) + 1;
      }

      // Nfse items
      filteredNfseItems.addAll(nfse.itens);

      // BAR CHARTS
      totalPorEmitente[nfse.nomeEmitente] =
          (totalPorEmitente[nfse.nomeEmitente] ?? 0) + nfse.totalNf;
    }
  }

  void updateAndSortLists({bool? updateCentroCustoSelection}) {
    sortedFornecedores = fornecedores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedSituacoes = situacoes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedCentroCusto = centrosCusto.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedStatus = status.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    sortedMateriasPrima = materiasPrima.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (updateCentroCustoSelection == true) {
      centrosCustoSelection = centrosCusto.entries.map((centroCusto) {
        return centroCusto.key;
      }).toList()
        ..add("TODOS");
    }

    for (var nfse in filteredNfses) {
      if (!dates.contains(nfse.data)) {
        dates.add(nfse.data);
      }
    }
    dates.sort((a, b) => a.compareTo(b));
  }

  void clearLists() {
    fornecedores.clear();
    situacoes.clear();
    status.clear();
    materiasPrima.clear();
    totalPorEmitente.clear();
    sortedFornecedores.clear();
    sortedSituacoes.clear();
    sortedCentroCusto.clear();
    sortedStatus.clear();
    sortedMateriasPrima.clear();
    dates.clear();
    filteredNfseItems.clear();
  }

  void update() {
    updateChartsMaps();
    updateAndSortLists();
    updateTotalGasto();
  }

  void filtrarPorCentroDeCusto(String centroCusto) {
    if (centroCusto == "TODOS") {
      currentCentroCusto = centroCusto;
      filteredNfses = nfses;
      clearLists();
      centrosCusto.clear();
      update();
      updateCurrentPeriodo();
    } else {
      currentCentroCusto = centroCusto;
      filteredNfses = nfses.where((nfse) {
        return nfse.centroCustoId.fantasia == centroCusto;
      }).toList();
      clearLists();
      update();
      updateCurrentPeriodo();
    }
    notifyListeners();
  }

  void filtrarPorData({
    required String periodo,
    DateTime? dataInicio,
    DateTime? dataFinal,
  }) {
    // HOJE
    void filtrarPorHoje() {
      final now = DateTime.now();
      final dataInicio = DateTime(now.year, now.month, now.day, 0, 0, 0);
      final dataFinal = DateTime(now.year, now.month, now.day, 23, 59, 59);

      if (currentCentroCusto == "TODOS") {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal);
          },
        ).toList();
      } else {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal) &&
                nfse.centroCustoId.fantasia == currentCentroCusto;
          },
        ).toList();
      }

      clearLists();
      centrosCusto.clear();
      update();
      currentPeriodoSelection = periodo;

      notifyListeners();
    }

    // ONTEM
    void filtrarPorOntem() {
      final now = DateTime.now();
      final ontem = now.subtract(const Duration(days: 1));
      final dataInicio = DateTime(ontem.year, ontem.month, ontem.day, 0, 0, 0);
      final dataFinal =
          DateTime(ontem.year, ontem.month, ontem.day, 23, 59, 59);

      if (currentCentroCusto == "TODOS") {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal);
          },
        ).toList();
      } else {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal) &&
                nfse.centroCustoId.fantasia == currentCentroCusto;
          },
        ).toList();
      }

      clearLists();
      centrosCusto.clear();
      update();
      currentPeriodoSelection = periodo;

      notifyListeners();
    }

    //NOS ÚLTIMOS 7 DIAS
    void filtrarPorUmaSemana() {
      final now = DateTime.now();
      final dataInicio = now.subtract(const Duration(days: 7));
      final dataFinal = DateTime(now.year, now.month, now.day, 23, 59, 59);

      if (currentCentroCusto == "TODOS") {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal);
          },
        ).toList();
      } else {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal) &&
                nfse.centroCustoId.fantasia == currentCentroCusto;
          },
        ).toList();
      }

      clearLists();
      centrosCusto.clear();
      update();
      currentPeriodoSelection = periodo;

      notifyListeners();
    }

    //NOS ÚLTIMOS 30 DIAS
    void filtrarPorUmMes() {
      final now = DateTime.now();
      final dataInicio = DateTime(now.year, now.month - 1, now.day);
      final dataFinal = DateTime(now.year, now.month, now.day, 23, 59, 59);

      if (currentCentroCusto == "TODOS") {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal);
          },
        ).toList();
      } else {
        filteredNfses = nfses.where(
          (nfse) {
            return nfse.data.isAfter(dataInicio) &&
                nfse.data.isBefore(dataFinal) &&
                nfse.centroCustoId.fantasia == currentCentroCusto;
          },
        ).toList();
      }

      clearLists();
      centrosCusto.clear();
      update();
      currentPeriodoSelection = periodo;

      notifyListeners();
    }

    void filtrarPersonalizado() {
      try {
        if (currentCentroCusto == "TODOS") {
          filteredNfses = nfses.where(
            (nfse) {
              return nfse.data.isAfter(dataInicio!) &&
                  nfse.data.isBefore(dataFinal!);
            },
          ).toList();
        } else {
          filteredNfses = nfses.where(
            (nfse) {
              return nfse.data.isAfter(dataInicio!) &&
                  nfse.data.isBefore(dataFinal!) &&
                  nfse.centroCustoId.fantasia == currentCentroCusto;
            },
          ).toList();
        }

        clearLists();
        centrosCusto.clear();
        update();
        updateCurrentPeriodo();
      } catch (e) {
        throw Exception("Erro em filtrar por data: ${e.toString()}");
      }

      notifyListeners();
    }

    switch (periodo) {
      case "Hoje":
        filtrarPorHoje();
        break;
      case "Ontem":
        filtrarPorOntem();
        break;
      case "Nos últimos 7 dias":
        filtrarPorUmaSemana();
        break;
      case "Nos últimos 30 dias":
        filtrarPorUmMes();
        break;
      case "Personalizado":
        filtrarPersonalizado();
        break;
      default:
        throw Exception("Período de filtro não reconhecido: $periodo");
    }

    notifyListeners();
  }
}
