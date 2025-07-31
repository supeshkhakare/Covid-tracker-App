import 'package:covid_tracker_app/Screens/world_states.dart'; // Assuming ReusableRow is in here
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  final String photo;
  final int cases;
  final int recovered;
  final int deaths;

  const DetailsScreen({
    super.key,
    required this.name,
    required this.photo,
    required this.cases,
    required this.recovered,
    required this.deaths,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        elevation: 0,
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Stack(
              
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
               
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .06),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                         
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .06),
                          
                          ReusableRow(
                              title: "Total Cases",
                              value: widget.cases.toString()),
                          ReusableRow(
                              title: "Total Cases",
                              value: widget.recovered.toString()),
                          ReusableRow(
                              title: "Total Cases",
                              value: widget.deaths.toString()),
                        
                        ],
                      ),
                    ),
                  ),
                ),

                
                Positioned(
                  top: 0,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height *
                        .06, // Responsive radius
                    backgroundImage: NetworkImage(widget.photo),
                    backgroundColor: Colors.grey[300], // Fallback color
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
