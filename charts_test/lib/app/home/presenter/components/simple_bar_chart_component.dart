import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleBarChartComponent extends StatelessWidget {
  final String title;
  final Map<String, double> totalPorEmitente;
  const SimpleBarChartComponent({
    super.key,
    required this.title,
    required this.totalPorEmitente,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final List<BarChartGroupData> barGroups = [];
    int index = 0;

    totalPorEmitente.forEach((emitente, total) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: total,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF00FFA6),
                  Color(0xFF00935F),
                ],
              ),
              borderRadius: BorderRadius.zero,
              width: 12,
            ),
          ],
        ),
      );
      index++;
    });

    String truncateToThreeWords(String text) {
      List<String> words = text.split(' ');
      if (words.length > 3) {
        words = words.sublist(0, 3);
      }

      return words.join(' ');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Visibility(
            visible: totalPorEmitente.isNotEmpty,
            replacement: const Center(
              child: Text(
                "Sem gráficos para esse período",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00935F),
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            ),
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(color: const Color(0xFF00935F)),
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
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: screenSize.height * 0.05,
                      getTitlesWidget: (value, meta) => const SizedBox(),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: screenSize.height * 0.06,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < totalPorEmitente.length) {
                          final emitente =
                              totalPorEmitente.keys.elementAt(index);
                          return SideTitleWidget(
                            angle: 0.2,
                            space: 2,
                            axisSide: meta.axisSide,
                            child: Text(
                              truncateToThreeWords(emitente),
                              style: const TextStyle(
                                fontSize: 8,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF00462E),
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
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
                barTouchData: BarTouchData(
                  mouseCursorResolver: (touchEvent, touchResponse) {
                    if (touchResponse == null || touchResponse.spot == null) {
                      return SystemMouseCursors.basic;
                    }
                    return SystemMouseCursors.click;
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (touchedSpot) => const Color(0xFF00FFA6),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final formattedValue = NumberFormat.currency(
                        locale: 'pt_BR',
                        symbol: 'R\$',
                      ).format(rod.toY);
                      return BarTooltipItem(
                        formattedValue,
                        const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF00462E),
                        ),
                      );
                    },
                  ),
                ),
              ),
              swapAnimationDuration: const Duration(
                milliseconds: 150,
              ),
              swapAnimationCurve: Curves.linear,
            ),
          ),
        ),
      ],
    );
  }
}
