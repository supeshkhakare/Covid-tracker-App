import 'package:covid_tracker_app/Models/api_fetch_func.dart';
import 'package:covid_tracker_app/Screens/countries_list.dart';
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

  // FIX 1: API call ke future ko state variable mein store kiya
  late Future<WorldData> _worldDataFuture;

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void initState() {
    super.initState();
    // API ko sirf ek baar yahan call kiya
    _worldDataFuture = Api_fetch_func.getWorldData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FutureBuilder<WorldData>(
                    future: _worldDataFuture, // Yahan state variable use kiya
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                      // Data aane ke baad UI dikhane ke liye alag method call kiya
                      return _buildDataView(snapshot.data!);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // FIX 2: UI ko alag method mein rakha taaki build method saaf rahe
  Widget _buildDataView(WorldData data) {
    return ListView(
      children: [
        const SizedBox(height: 40),
        PieChart(
          dataMap: {
            "TOTAL": double.parse(data.cases.toString()),
            "RECOVERED": double.parse(data.recovered.toString()),
            "DEATHS": double.parse(data.deaths.toString()),
          },
          animationDuration: const Duration(milliseconds: 1200),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 2.5,
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
              color: Colors.white, // <-- Add this line
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
        const SizedBox(height: 30),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                ReusableRow(title: "Total Cases", value: data.cases.toString()),
                ReusableRow(
                    title: "Total Recovered", value: data.recovered.toString()),
                ReusableRow(
                    title: "Total Deaths", value: data.deaths.toString()),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CountriesList()),
            );
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff1aa260),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Track Countries",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ReusableRow (No changes needed, yeh pehle se hi aacha hai)
class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const Divider(thickness: 0.8),
        ],
      ),
    );
  }
}
