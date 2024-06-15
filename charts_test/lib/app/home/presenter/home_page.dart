import 'package:charts_test/app/home/presenter/components/pie_chart_component.dart';
import 'package:charts_test/app/home/presenter/components/show_custom_date_filter_dialog.dart';
import 'package:charts_test/app/home/presenter/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'components/info_card_component.dart';
import 'components/line_chart_component.dart';
import 'components/simple_bar_chart_component.dart';

class HomePage extends StatefulWidget {
  final HomeStore store;
  const HomePage({super.key, required this.store});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.store.init();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final store = widget.store;
    final int nfsesTotalItems = store.filteredNfses.length;

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
                        fontSize: 25,
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
                    subtitle: store.currentCentroCusto,
                    icon: FontAwesomeIcons.buildingUser,
                    width: 0.25,
                    isSelectCard: true,
                    selectOptions: store.centrosCustoSelection,
                    onSelect: (value) {
                      store.filtrarPorCentroDeCusto(value);
                    },
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  InfoCardComponent(
                    title: "Período:",
                    subtitle: store.currentPeriodoSelection,
                    icon: FontAwesomeIcons.calendar,
                    width: 0.25,
                    isSelectCard: true,
                    selectOptions: store.periodoSelection,
                    onSelect: (value) async {
                      if (value == "Personalizado") {
                        await showCustomDateFilterDialog(context, store);
                      } else {
                        store.filtrarPorData(periodo: value);
                      }
                    },
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  InfoCardComponent(
                    title: "Notas emitidas:",
                    subtitle: store.filteredNfses.length.toString(),
                    icon: FontAwesomeIcons.noteSticky,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  InfoCardComponent(
                    title: "Total gasto:",
                    subtitle: NumberFormat.currency(
                      locale: 'pt_BR',
                      symbol: 'R\$',
                    ).format(store.totalGasto),
                    icon: FontAwesomeIcons.coins,
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                children: [
                  Visibility(
                    visible: store.currentCentroCusto == "TODOS",
                    child: Expanded(
                      child: PieChartComponent(
                        title: "Notas fiscais por Centros de Custo",
                        items: store.centrosCusto,
                        totalItems: nfsesTotalItems,
                        sortedItems: store.sortedCentroCusto,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: store.currentCentroCusto == "TODOS",
                    child: SizedBox(width: screenSize.width * 0.02),
                  ),
                  Expanded(
                    child: PieChartComponent(
                      title: "Notas fiscais por fornecedores",
                      items: store.fornecedores,
                      totalItems: nfsesTotalItems,
                      sortedItems: store.sortedFornecedores,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              LineChartComponent(
                title: "Evolução de compras por período",
                nfses: store.filteredNfses,
                dates: store.dates.map((date) {
                  return DateFormat('dd/MM/yy').format(date);
                }).toList(),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: PieChartComponent(
                      title: "Situação das notas fiscais",
                      items: store.situacoes,
                      totalItems: nfsesTotalItems,
                      sortedItems: store.sortedSituacoes,
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.02),
                  Expanded(
                    child: PieChartComponent(
                      title: "Status das nostas fiscais",
                      items: store.status,
                      totalItems: nfsesTotalItems,
                      sortedItems: store.sortedStatus,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              SimpleBarChartComponent(
                title: "Total de pagamentos por fornecedores",
                totalPorEmitente: store.totalPorEmitente,
              ),
              SizedBox(height: screenSize.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
