import 'package:covid_tracker_app/Models/api_fetch_func.dart';
import 'package:covid_tracker_app/Screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[800],
      ),
      body: SafeArea(
        child: Column(
          children: [
// Search Field

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                style: const TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: "Search with country name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  suffixIcon: _searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          onTap: () {
                            _searchController.clear();

                            setState(() {});
                          },
                          child: const Icon(Icons.clear),
                        ),
                ),
              ),
            ),

// List or Loading

            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: Api_fetch_func.getCountriesdata(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
// Show shimmer while loading

                    return ListView.builder(
                      itemCount: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: double.infinity,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        height: 10,
                                        width: 150,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  final countries = snapshot.data!;

                  final query = _searchController.text.toLowerCase();

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];

                      final countryName = country['country'] as String;

                      if (query.isNotEmpty &&
                          !countryName.toLowerCase().contains(query)) {
                        return const SizedBox.shrink(); // Don't render
                      }

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            name: country['country'],
                                            cases: country['cases'],
                                            photo: country['countryInfo']
                                                ['flag'],
                                            deaths: country['deaths'],
                                            recovered: country['recovered'],
                                          )));
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  country["countryInfo"]["flag"],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                countryName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                country["cases"].toString(),
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
