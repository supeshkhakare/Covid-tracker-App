import 'package:covid_tracker_app/Models/api_fetch_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Models/WorldData.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
              future: Api_fetch_func.getWorldData(),
              builder: (context, AsyncSnapshot<WorldData> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      // PieChart
                      PieChart(
                        dataMap: {
                          "TOTAL": double.parse(
                              snapshot.data!.todayCases.toString()),
                          "RECOVERED": double.parse(
                              snapshot.data!.todayRecovered.toString()),
                          "DEATHS": double.parse(
                              snapshot.data!.todayDeaths.toString()),
                        },
                        animationDuration: Duration(milliseconds: 1200),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 25,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.left,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //CARD of showing values

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: "total cases",
                                  value: snapshot.data!.todayCases.toString()),
                              ReusableRow(
                                  title: "total Recovered",
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                              ReusableRow(
                                  title: "total Deaths",
                                  value: snapshot.data!.todayDeaths.toString())
                            ],
                          ),
                        ),
                      ),

                      // button for track countries
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text("Track Countries"),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
        ],
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          )
        ],
      ),
    );
  }
}
