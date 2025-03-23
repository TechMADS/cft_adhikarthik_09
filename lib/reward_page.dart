import 'package:scratcher/scratcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

import 'coupon_page.dart';

void main() {
  runApp(MaterialApp(home: RewardsPage()));
}

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  List<Map<String, String>> rewards = [
    {"text": "₹100 Green Cashback!", "type": "Cashback"},
    {"text": "20% off on Eco-friendly products", "type": "Discount"},
    {"text": "Free Reusable Bag!", "type": "Gift"},
    {"text": "Free Sapling to Plant!", "type": "Gift"},
    {"text": "Earn 50  Credits Points!", "type": "Points"},

  ];

  List<bool> scratched = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("\t \t \t \t  My Rewards",style: TextStyle(color: Colors.white,fontSize: 26),),backgroundColor: Colors.black,
      leading: IconButton(onPressed: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=> HomeScreen()),);
      }, icon: Icon(Icons.arrow_back),color: Colors.white,),),
      body:
      ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orange,
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.card_giftcard, color: Colors.black),
              title: Text(rewards[index]["text"]!, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(scratched[index] ? "Claimed" : "Tap to Scratch"),
              trailing: scratched[index]
                  ? Icon(Icons.check_circle, color: Colors.white)
                  : Icon(Icons.lock_open_rounded, color: Colors.black),
              onTap: scratched[index]
                  ? null
                  : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScratchCard(
                      rewardText: rewards[index]["text"]!,
                      onScratched: () {
                        setState(() {
                          scratched[index] = true;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ScratchCard extends StatefulWidget {
  final String rewardText;
  final VoidCallback onScratched;

  ScratchCard({required this.rewardText, required this.onScratched});

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  bool isRevealed = false;
  final ConfettiController _confettiController = ConfettiController(duration: Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Scratch & Win')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: -pi / 2,
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            maxBlastForce: 20,
            minBlastForce: 5,
          ),
          Center(
            child: isRevealed
                ? _rewardCard()
                : Scratcher(
              brushSize: 40,
              threshold: 50,
              color: Colors.orange!,
              onThreshold: () {
                setState(() {
                  isRevealed = true;
                  _confettiController.play();
                  widget.onScratched();
                });
              },
              child: _scratchableCard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scratchableCard() {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1)],
      ),
      alignment: Alignment.center,
      child: Text(
        "Scratch to reveal your reward",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      ),
    );
  }

  Widget _rewardCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 320,
          height: 320,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1)],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.rewardText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Reward claimed successfully! Keep reducing your carbon footprint. 🌿"),
            ));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VoucherInstructionsScreen(
                  voucherTitle: "10% Discount on Eco-Friendly Products",
                  voucherDescription: "Get 10% off on sustainable products at our partner stores.",
                  redemptionSteps: "1. Click 'Redeem Now'.\n" "2. You will receive a unique voucher code.\n" "3. Show this code at checkout or enter it online.",
                ),
              ),
            );
          },
          child: Text("Claim Reward"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}
