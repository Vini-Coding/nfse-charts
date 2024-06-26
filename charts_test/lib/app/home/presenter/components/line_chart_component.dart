import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartComponent extends StatelessWidget {
  final String title;
  final List<dynamic> nfses;
  final List<String> dates;
  const LineChartComponent({
    super.key,
    required this.title,
    required this.nfses,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Agrupar gastos por data
    Map<DateTime, double> groupedData = {};
    for (var nfse in nfses) {
      DateTime dateKey =
          DateTime(nfse.data.year, nfse.data.month, nfse.data.day);
      if (groupedData.containsKey(dateKey)) {
        groupedData[dateKey] = groupedData[dateKey]! + nfse.totalNf;
      } else {
        groupedData[dateKey] = nfse.totalNf;
      }
    }

    // Ordenar os dados por data
    List<MapEntry<DateTime, double>> sortedEntries =
        groupedData.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    // Criar os pontos para o gráfico
    final List<FlSpot> spots = sortedEntries.asMap().entries.map((entry) {
      int index = entry.key;
      double totalGasto = entry.value.value;
      return FlSpot(
        index.toDouble(),
        totalGasto,
      );
    }).toList();

    // Criar lista de datas para os títulos do eixo x
    final List<String> dates = sortedEntries.map((entry) {
      return DateFormat('dd/MM/yyyy').format(entry.key);
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            color: Color(0xFF151515),
          ),
        ),
        SizedBox(height: screenSize.height * 0.02),
        Container(
          height: screenSize.height * 0.5,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Visibility(
            visible: nfses.isNotEmpty,
            replacement: const Center(
              child: Text(
                "Sem gráficos para esse período",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF00935F),
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    preventCurveOverShooting: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: const Color(0xFF00FFA6),
                        );
                      },
                    ),
                    color: const Color(0xFF00FFA6),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF00462E).withOpacity(0.7),
                          const Color(0xFF00462E).withOpacity(0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      spotsLine: const BarAreaSpotsLine(
                        show: true,
                        flLineStyle: FlLine(
                          color: Color(0xFF00FFA6),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                ],
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xFF00462E)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: Color(0xFFCFF4E7),
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: Color(0xFFCFF4E7),
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < dates.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              dates[index],
                              style: const TextStyle(
                                color: Color(0xFF00935F),
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      interval: 1,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => const SizedBox(),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: screenSize.width * 0.06,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            NumberFormat.currency(
                              locale: 'pt_BR',
                              symbol: 'R\$',
                            ).format(value),
                            style: const TextStyle(
                              color: Color(0xFF00462E),
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: screenSize.width * 0.06,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            NumberFormat.currency(
                              locale: 'pt_BR',
                              symbol: 'R\$',
                            ).format(value),
                            style: const TextStyle(
                              color: Color(0xFF00462E),
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: 0,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => const Color(0xFF00FFA6),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        final formattedValue = NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                        ).format(spot.y);
                        return LineTooltipItem(
                          formattedValue,
                          const TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF00462E),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
