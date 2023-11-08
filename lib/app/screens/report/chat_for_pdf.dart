import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../constants/gasout_constants.dart';

class ChartForPdf extends StatefulWidget {
  final List<double> gasSensorValues;
  final List<int> hoursTimestampValues;
  final String roomName;
  final String averageValue;
  final String highestValueTime;
  final String userMail;

  ChartForPdf(
      {Key? key,
      required this.averageValue,
      required this.highestValueTime,
      required this.gasSensorValues,
      required this.hoursTimestampValues,
      required this.roomName,
      required this.userMail})
      : super(key: key);

  @override
  State<ChartForPdf> createState() => _ChartForPdfState();
}

class _ChartForPdfState extends State<ChartForPdf> {
  final Color barBackgroundColor = ConstantColors.secondaryColor;

  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: ConstantColors.thirdColor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    widget.userMail,
                    style: TextStyle(
                        color: ConstantColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.roomName,
                    style: TextStyle(
                        color: ConstantColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Valores mais recentes do sensor de gás",
                    style: TextStyle(
                        color: ConstantColors.primaryColor.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Média dos valores de medição: ",
                    style: TextStyle(
                        color: ConstantColors.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.averageValue,
                    style: TextStyle(
                        color: ConstantColors.secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Horário do pico de medição: ",
                    style: TextStyle(
                        color: ConstantColors.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.highestValueTime,
                    style: TextStyle(
                        color: ConstantColors.secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, widget.gasSensorValues[i],
                isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String hours;
              switch (group.x.toInt()) {
                case 0:
                  hours = widget.hoursTimestampValues[0].toString();
                  break;
                case 1:
                  hours = widget.hoursTimestampValues[1].toString();
                  break;
                case 2:
                  hours = widget.hoursTimestampValues[2].toString();
                  break;
                case 3:
                  hours = widget.hoursTimestampValues[3].toString();
                  break;
                case 4:
                  hours = widget.hoursTimestampValues[4].toString();
                  break;
                case 5:
                  hours = widget.hoursTimestampValues[5].toString();
                  break;
                case 6:
                  hours = widget.hoursTimestampValues[6].toString();
                  break;
                case 7:
                  hours = widget.hoursTimestampValues[7].toString();
                  break;
                case 8:
                  hours = widget.hoursTimestampValues[8].toString();
                  break;
                case 9:
                  hours = widget.hoursTimestampValues[9].toString();
                  break;
                case 10:
                  hours = widget.hoursTimestampValues[10].toString();
                  break;
                case 11:
                  hours = widget.hoursTimestampValues[11].toString();
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                hours + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            return widget.hoursTimestampValues[value.toInt()].toString() + "h";
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              return value.toInt().toString();
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
          rightTitles: SideTitles(
            showTitles: false,
          )),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.blue);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.amber);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.deepOrange);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.pink);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.red);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.green);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.blueGrey);
          case 7:
            return makeGroupData(7, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.amber);
          case 8:
            return makeGroupData(8, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.deepOrange);
          case 9:
            return makeGroupData(9, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.pink);
          case 10:
            return makeGroupData(10, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.red);
          case 11:
            return makeGroupData(11, Random().nextInt(15).toDouble() + 11,
                barColor: Colors.green);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }
}
