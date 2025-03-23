import 'package:flutter/material.dart';

class VoucherInstructionsScreen extends StatelessWidget {
  final String voucherTitle;
  final String voucherDescription;
  final String redemptionSteps;

  const VoucherInstructionsScreen({
    Key? key,
    required this.voucherTitle,
    required this.voucherDescription,
    required this.redemptionSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to Redeem"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              voucherTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              voucherDescription,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              "How to Use:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              redemptionSteps,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic to redeem the voucher
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Voucher Redeemed Successfully!")),
                  );
                },
                child: Text("Redeem Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



