import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/utils/utils.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  Chart(List<Transcation> this.transactions);

  final todaysDate = DateTime.now();
  List<Transcation> transactions;
  double maxSpending = 0;
  List<String> lastSevenDaysOrder = [];
  var index = 0;

  SideTitleWidget calculateDay(double daysToSub, TitleMeta meta) {
    var widget = SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(
        lastSevenDaysOrder[index],
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
    if (index == 6)
      index = 0;
    else
      index++;
    return widget;
  }

  List<BarChartGroupData> calculateLastSevenDaysSpending() {
    List<BarChartGroupData> data = [];
    for (var i = 0; i <= 6; i++) {
      var calculatedDate = todaysDate.subtract(Duration(days: i));
      lastSevenDaysOrder
          .add(DateFormat('EEEE').format(calculatedDate).substring(0, 3));
      var transactionsOnDay =
          transactions.where((t) => compaireDate(t.date, calculatedDate));
      double total = 0;
      transactionsOnDay.forEach((
        t,
      ) =>
          total += t.amount);

      if ((total + 20) > maxSpending) {
        maxSpending = total + 20;
      }

      BarChartGroupData cordinate = BarChartGroupData(
        barsSpace: 20,
        groupVertically: true,
        x: total.toInt(),
        showingTooltipIndicators: [0],
        barRods: [
          BarChartRodData(
            toY: total,
            width: 12,
            gradient: _barsGradient,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxSpending - 20,
              color: Color(0xff72d8bf),
            ),
          ),
        ],
      );
      data.add(cordinate);
    }
    return data;
  }

  final _barsGradient = const LinearGradient(
    colors: [Colors.white, Colors.white],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 15,
                ),
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Weekly Activity",
                  style: TextStyle(
                    color: Color(0xff0f4a3c),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AspectRatio(
                  aspectRatio: 2.11,
                  child: BarChart(
                    BarChartData(
                        barTouchData: barTouchData,
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: calculateDay,
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: borderData,
                        barGroups: calculateLastSevenDaysSpending(),
                        gridData: FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxSpending),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// child: LineChart(
//         LineChartData(
//             borderData: FlBorderData(show: false),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (v, i) => Text(calculateDay(v.floor())),
//                 ),
//               ),
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//             ),
//             lineBarsData: [
//               LineChartBarData(spots: calculateLastSevenDaysSpending()),
//             ]),
//       )
