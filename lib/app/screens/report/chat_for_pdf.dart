import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../constants/gasout_constants.dart';

class ChartForPdf extends StatefulWidget {
  final List<double> gasSensorValues;
  final String roomName;
  final String userMail;

  ChartForPdf({Key? key, required this.gasSensorValues, required this.roomName, required this.userMail}) : super(key: key);

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
      aspectRatio: 1,
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
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
                  hours = '1';
                  break;
                case 1:
                  hours = '2';
                  break;
                case 2:
                  hours = '3';
                  break;
                case 3:
                  hours = '4';
                  break;
                case 4:
                  hours = '5';
                  break;
                case 5:
                  hours = '6';
                  break;
                case 6:
                  hours = '7';
                  break;
                case 7:
                  hours = '8';
                  break;
                case 8:
                  hours = '9';
                  break;
                case 9:
                  hours = '10';
                  break;
                case 10:
                  hours = '11';
                  break;
                case 11:
                  hours = '12';
                  break;
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
            return (value + 1).toInt().toString() + "h";
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
