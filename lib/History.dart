import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/History_details.dart';


class history extends StatelessWidget {
  const history({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(

    debugShowCheckedModeBanner: false,
    title: 'Reward Points',
    theme: ThemeData(primarySwatch: Colors.purple),
    home: const RewardPointsScreen(),
  );
}

class RewardPointsScreen extends StatefulWidget {
  const RewardPointsScreen({super.key});
  @override
  _RewardPointsScreenState createState() => _RewardPointsScreenState();
}

class _RewardPointsScreenState extends State<RewardPointsScreen> {
  bool showEarnCoins = false;
  final List<EarnMethod> earnMethods = [
    EarnMethod("Win a Challenge", "Earn big rewards!", "assets/trophy.webp"),
    EarnMethod("Participate in Challenge", "Earn for participation!", "assets/win.jpg"),
    EarnMethod("Reach Goals", "Complete goals for coins!", "assets/goals.webp"),
    EarnMethod("Refer a Friend", "Both get bonus coins!", "assets/refer.png"),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(title:Text("\t \t \t \t \t \t History"),titleTextStyle: TextStyle(color: Colors.white,fontSize: 29),
        backgroundColor: Colors.orange,
        leading:IconButton(onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
        actions: [
          IconButton(icon:Icon(Icons.history), onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => history_details()))),
        ]),
    body: SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildPointsSection(),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text("Reward Points History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
      ),
      Expanded(child: showEarnCoins ? _buildEarnCoinsScreen() : _buildTransactionList()),
    ])),
    bottomNavigationBar: _buildFixedButton(),
  );

  Widget _buildPointsSection() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.orange, Colors.orange])) ,
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: const [
      Text("Reward Points", style: TextStyle(color: Colors.white, fontSize: 22)),
      SizedBox(height: 10),
      Text("499", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Text("Redeem before they expire.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14)),
    ]),
  );

  Widget _buildTransactionList() {
    final transactions = [
      Transaction("Challenge Reward", "+1", "No Expiration Date"),
      Transaction("Redeemed", "-50", "No Expiration Date"),
      Transaction("Challenge Reward", "+51", "Expires: 26 Dec 2025"),
      Transaction("Redeemed", "-38", "No Expiration Date"),
    ];
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => ListTile(
        title: Text(transactions[i].title, style: const TextStyle(fontSize: 16,color: Colors.white)),
        subtitle: Text(transactions[i].subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: Text(transactions[i].points, style: TextStyle(fontSize: 20, color: transactions[i].points.startsWith('+') ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildEarnCoinsScreen() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: earnMethods.length,
    itemBuilder: (_, i) => Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(earnMethods[i].imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(earnMethods[i].title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(earnMethods[i].description),
      ),
    ),
  );

  Widget _buildFixedButton() => Container(
    padding: const EdgeInsets.all(16),
    color: Colors.black,
    child: ElevatedButton(
      onPressed: () => setState(() => showEarnCoins = !showEarnCoins),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Text(showEarnCoins ? "Back to Rewards" : "How to Earn Coins", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    ),
  );
}

// Models
class Transaction {
  final String title, points, subtitle;
  const Transaction(this.title, this.points, this.subtitle);
}

class EarnMethod {
  final String title, description, imagePath;
  EarnMethod(this.title, this.description, this.imagePath);
}