import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),

      ),
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(onPressed: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=> HomeScreen()),);
          }, icon: Icon(Icons.arrow_back),color: Colors.white,),
          title: Text("\t \t \t \t Dashboard"),titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),

        ),
        body: Group8(),
      ),
    );
  }
}

class Group8 extends StatefulWidget {
  const Group8({super.key});

  @override
  State<Group8> createState() => _Group8State();
}

class _Group8State extends State<Group8> {
  String selectedTab = "DAY";
  String selectedAppliance = "HALL" "GARDEN";
  Map<String, double> barData = {};
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromDatabase();
  }

  void _setSelectedTab(String tab) {
    setState(() {
      selectedTab = tab;
      _fetchDataFromDatabase();
    });
  }

  void _setSelectedAppliance(String appliance) {
    setState(() {
      selectedAppliance = appliance;
      _fetchDataFromDatabase();
    });
  }

  Future<void> _fetchDataFromDatabase() async {
    Map<String, double> data = await fetchDataFromDatabase(selectedTab, selectedAppliance);
    setState(() {
      barData = data;
      labels = barData.keys.toList();
    });
  }

  Future<Map<String, double>> fetchDataFromDatabase(String tab, String appliance) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay


    if (tab == "DAY") {
      return {
        "12AM": 1000, "3AM": 3000, "6AM": 2500, "9AM": 4000, "12PM": 6000, "3PM": 7000, "6PM": 5000, "9PM": 3500,
      };
    } else if (tab == "WEEK") {
      return {
        "Mon": 4500, "Tue": 7500, "Wed": 3500, "Thu": 9500, "Fri": 6500, "Sat": 5500, "Sun": 2000,
      };
    } else if (tab == "MONTH") {
      return {
        "1": 7000, "5": 6000, "10": 8500, "15": 9200, "20": 5000, "25": 6200, "30": 8000,
      };
    } else if (tab == "YEAR") {
      return {
        "Jan": 7000, "Feb": 6000, "Mar": 800, "Apr": 200, "May": 500, "Jun": 6000, "Jul": 8000, "Aug": 9000, "Sep": 7500, "Oct": 8200, "Nov": 6700, "Dec": 7200,
      };
    } else if (tab == "GARDEN") {
      return {
        "Jan": 1000,
        "Feb": 1000,
        "Mar": 100,
        "Apr": 200,
        "May": 500,
        "Jun": 1000,
        "Jul": 1000,
        "Aug": 1000,
        "Sep": 1500,
        "Oct": 1200,
        "Nov": 1700,
        "Dec": 1200,
      };
    }
    return {}; // Fix for missing return statement
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 412,
        height: 750,
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeaderButtons(),
            _buildBarGraph(),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildScrollableApplianceList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0), // Add margin
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space buttons
        children: ["DAY", "WEEK", "MONTH", "YEAR" ].map((label) {
          return Expanded( // Ensures equal button width
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0), // Reduce spacing
              child: GestureDetector(
                onTap: () => _setSelectedTab(label),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedTab == label ? Colors.orange : Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }



  Widget _buildBarGraph() {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add margin around the graph
      child: SizedBox(
        height: 350,
        child: Row(
          children: [
            // Fixed Y-Axis (Left side values)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                double value = (10000 / 4) * (4 - index); // Generate values (0K to 10K)
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${(value ~/ 1000)}K", // Convert to "K" format (e.g., 2K, 5K)
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
            const SizedBox(width: 8), // Space between left Y-axis and graph
            // Scrollable Bar Graph
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Space around graph
                  child: SizedBox(
                    width: labels.length * 60, // Dynamic width based on number of bars
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceBetween,
                        maxY: 10000,
                        barGroups: barData.entries.map((entry) {
                          return BarChartGroupData(
                            x: labels.indexOf(entry.key),
                            barRods: [
                              BarChartRodData(
                                toY: entry.value,
                                color: Colors.orange,
                                width: 10, // Adjust bar width
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ],
                          );
                        }).toList(),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false), // Hide default Y-axis labels
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false), // Hide default right labels
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                int index = value.toInt();
                                if (index >= 0 && index < labels.length) {
                                  return Transform.rotate(
                                    angle: -0.5, // Rotate text slightly for better readability
                                    child: Text(labels[index]),
                                  );
                                }
                                return const SizedBox(); // Prevent out-of-bounds error
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8), // Space between graph and right Y-axis
            // Fixed Right Y-Axis (Right side values)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                double value = (10000 / 4) * (4 - index); // Generate values (0K to 10K)
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${(value ~/ 1000)}K", // Convert to "K" format
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildScrollableApplianceList() {
    List<String> appliances = [
      "HALL", "KITCHEN", "GARDEN", "LIVING ROOM", "ROOM 2", "ROOM 3", "ROOM 4"
    ];

    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 10,
          left: 10,
          right: 10,
          child: Container(
            height: 300,
            width: 450,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withAlpha((0.1 * 255).toInt()),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(10),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: appliances.length,
                itemBuilder: (context, index) {
                  String appliance = appliances[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                      onTap: () => _setSelectedAppliance(appliance),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        width: 148,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedAppliance == appliance ? Colors.orange : Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            appliance,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}


