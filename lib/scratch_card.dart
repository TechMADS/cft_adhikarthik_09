// import 'package:flutter/material.dart';
// import 'package:scratcher/scratcher.dart';
//
// class ScratchCard extends StatefulWidget {
//   @override
//   _ScratchCardState createState() => _ScratchCardState();
// }
//
// class _ScratchCardState extends State<ScratchCard> {
//   bool isRevealed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(title: Text('Scratch Card')),
//       body: Center(
//         child: isRevealed
//             ? _rewardCard() // Show revealed reward
//             : Scratcher(
//           brushSize: 40,
//           threshold: 50, // 50% scratched to reveal
//           color: Colors.grey[400]!,
//           onThreshold: () {
//             setState(() {
//               isRevealed = true;
//             });
//           },
//           child: _scratchableCard(),
//         ),
//       ),
//     );
//   }
//
//   // Scratchable card UI
//   Widget _scratchableCard() {
//     return Container(
//       width: 300,
//       height: 150,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1),
//         ],
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         "Scratch to reveal",
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
//       ),
//     );
//   }
//
//   // Revealed reward UI
//   Widget _rewardCard() {
//     return Container(
//       width: 300,
//       height: 150,
//       decoration: BoxDecoration(
//         color: Colors.deepPurple,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 1),
//         ],
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         "🎉 You won ₹500! 🎉",
//         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//     );
//   }
// }
