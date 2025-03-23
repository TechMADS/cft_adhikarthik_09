import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarbonCoinPage extends StatefulWidget {
  @override
  _CarbonCoinPageState createState() => _CarbonCoinPageState();
}

class _CarbonCoinPageState extends State<CarbonCoinPage> {
  int totalCoins = 0;
  Map<String, Map<String, dynamic>> tasks = {
    "Reduce 1 hour of screen time": {"completed": false, "coins": 10},
    "Use public transport for a day": {"completed": false, "coins": 20},
    "Turn off unused lights": {"completed": false, "coins": 5},
    "Use energy-efficient appliances": {"completed": false, "coins": 15},
  };

  void claimCoins(String task) {
    if (!tasks[task]!['completed']) {
      setState(() {
        tasks[task]!['completed'] = true;
        totalCoins += tasks[task]?['coins'] as int;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen()),);
        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        backgroundColor: Colors.black,
        title: Text("Carbon Coin Collection",style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.yellow),
                SizedBox(width: 5),
                Text("$totalCoins", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: tasks.keys.map((task) {
                  return Card(
                    color: Colors.orange,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(task),
                      subtitle: Text(tasks[task]!['completed'] ? "Completed" : "Pending"),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Icon(Icons.monetization_on, color: Colors.yellow),
                          SizedBox(width: 5),
                          Text("${tasks[task]!['coins']}")
                        ],
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white
                        ),
                        onPressed: tasks[task]!['completed'] ? null : () => claimCoins(task),
                        child: Text("Claim"),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Complete these tasks daily to reduce your carbon footprint and earn rewards!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.orange),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}