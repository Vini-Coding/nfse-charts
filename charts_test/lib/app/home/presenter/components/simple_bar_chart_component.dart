import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
              color: const Color(0xFF00935F),
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
                  overflow: TextOverflow.ellipsis
                ),
                maxLines: 2,
              ),
            ),
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < totalPorEmitente.length) {
                          final emitente = totalPorEmitente.keys.elementAt(index);
                          return SideTitleWidget(
                            angle: 0.2,
                            space: 2,
                            axisSide: meta.axisSide,
                            child: Text(
                              truncateToThreeWords(emitente),
                              style: const TextStyle(
                                fontSize: 8,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF151515),
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
