import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class history_details extends StatelessWidget {
  final Map<String, List<PointEntry>> pointsData = {
    "November 2023": [
      PointEntry("Rewards", "+25", "Nov 13, 2023 at 5:30 PM"),
      PointEntry("Redeemed", "-15", "Nov 11, 2023 at 1:30 PM"),
      PointEntry("Completion daily goal in Challenge", "+15", "Nov 10, 2023 at 11:00 AM"),
    ],
    "October 2023": [
      PointEntry("Rewards", "+20", "Oct 13, 2023 at 5:30 PM"),
      PointEntry("Completion daily goal in Challenge", "+15", "Oct 12, 2023 at 4:35 PM"),
      PointEntry("Participation in Challenge", "+10", "Oct 11, 2023 at 1:30 PM"),
      PointEntry("3rd Place in Challenge", "+85", "Oct 10, 2023 at 3:30 PM"),
    ],
    "December 2023": [
      PointEntry("Rewards", "+20", "Oct 13, 2023 at 5:30 PM"),

    ],};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("\t \t \t Points History",style: TextStyle(color: Colors.white,fontSize: 25),),backgroundColor: Colors.black,),

      body: ListView.builder(

        padding: const EdgeInsets.all(10),
        itemCount: pointsData.keys.length,
        itemBuilder: (context, index) {
          String month = pointsData.keys.elementAt(index);
          List<PointEntry> entries = pointsData[month]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  month,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
              ...entries.map((entry) => Card(
                color: Colors.orange,
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(entry.title),
                  subtitle: Text(entry.date),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: entry.points.startsWith('+') ? Colors.green[100] : Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: entry.points.startsWith('+') ? Colors.green : Colors.red,
                      ),
                    ),
                    child: Text(
                      entry.points,
                      style: TextStyle(
                        color: entry.points.startsWith('+') ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}

class PointEntry {
  final String title;
  final String points;
  final String date;

  PointEntry(this.title, this.points, this.date);
}