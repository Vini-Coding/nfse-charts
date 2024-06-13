import 'package:charts_test/app/home/models/nfse.dart';
import 'package:charts_test/app/home/presenter/components/pie_chart_component.dart';
import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/info_card_component.dart';
import 'components/line_chart_component.dart';
import 'components/simple_bar_chart_component.dart';

class HomePage extends StatefulWidget {
  final HomeRepository repository;
  const HomePage({super.key, required this.repository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Nfse> nfses;
  final Map<String, int> fornecedores = {};
  final Map<String, int> situacoes = {};
  final Map<String, int> centrosCusto = {};
  final Map<String, int> status = {};
  final Map<String, double> totalPorEmitente = {};

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jsonData = widget.repository.getData();
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final int nfsesTotalItems = nfses.length;

    final List<MapEntry> sortedFornecedores = fornecedores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final List<MapEntry> sortedSituacoes = situacoes.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final List<MapEntry> sortedCentroCusto = centrosCusto.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final List<MapEntry> sortedStatus = status.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(
                  text: "Dashboard de\n",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515),
                  ),
                  children: [
                    TextSpan(
                      text: "notas fiscais",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 30,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF00935F),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoCardComponent(
                    title: "Centro de custo:",
                    subtitle: sortedCentroCusto.first.key,
                    icon: FontAwesomeIcons.buildingUser,
                    width: 0.3,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  InfoCardComponent(
                    title: "Período:",
                    subtitle: nfses.length.toString(),
                    icon: FontAwesomeIcons.calendar,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  InfoCardComponent(
                    title: "Notas emitidas:",
                    subtitle: nfses.length.toString(),
                    icon: FontAwesomeIcons.noteSticky,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  InfoCardComponent(
                    title: "Total gasto:",
                    subtitle:
                        "R\$ ${2000.000.toStringAsFixed(2).replaceAll('.', ',')}",
                    icon: FontAwesomeIcons.coins,
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              LineChartComponent(
                title: "Evolução de compras por período",
                nfses: nfses,
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: PieChartComponent(
                      title: "Situação das notas fiscais",
                      items: situacoes,
                      totalItems: nfsesTotalItems,
                      sortedItems: sortedSituacoes,
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.02),
                  Expanded(
                    child: PieChartComponent(
                      title: "Status das nostas fiscais",
                      items: status,
                      totalItems: nfsesTotalItems,
                      sortedItems: sortedStatus,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              SimpleBarChartComponent(
                title: "Total de pagamentos por fornecedores",
                totalPorEmitente: totalPorEmitente,
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: PieChartComponent(
                      title: "Notas fiscais por empresa",
                      items: centrosCusto,
                      totalItems: nfsesTotalItems,
                      sortedItems: sortedCentroCusto,
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.02),
                  Expanded(
                    child: PieChartComponent(
                      title: "Notas fiscais por fornecedores",
                      items: fornecedores,
                      totalItems: nfsesTotalItems,
                      sortedItems: sortedFornecedores,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
