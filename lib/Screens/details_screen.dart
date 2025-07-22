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
        // Screen ke side se thoda padding de diya taaki card chipka hua na lage
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stack ka use karke hum widgets ko ek ke upar ek rakhenge
            Stack(
              // clipBehavior.none se CircleAvatar Stack ke bahar bhi dikhega
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // **STEP 1: Card ko neeche rakha hai aur uske top mein space di hai**
                // Padding se Card thoda neeche khisak jayega, taaki avatar ke liye jagah ban jaye
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .06),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Avatar ke liye jagah chhodne ke liye SizedBox
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .06),
                          // Aapka custom row widget
                          ReusableRow(
                              title: "Total Cases",
                              value: widget.cases.toString()),
                          ReusableRow(
                              title: "Total Cases",
                              value: widget.recovered.toString()),
                          ReusableRow(
                              title: "Total Cases",
                              value: widget.deaths.toString()),
                          // Yahan aur bhi ReusableRow add kar sakte hain
                          // e.g., ReusableRow(title: "Deaths", value: widget.deaths.toString()),
                        ],
                      ),
                    ),
                  ),
                ),

                // **STEP 2: CircleAvatar ko Stack ke top center par align kiya hai**
                // Positioned se avatar ko aasaani se control kar sakte hain
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
