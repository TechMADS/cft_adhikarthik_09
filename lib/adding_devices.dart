import 'package:carbon_footprint_tracker_by_teamtech_mads/homepage.dart';
import 'package:flutter/material.dart';


class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final List<Map<String, dynamic>> bluetoothDevices = [
    {'name': 'Bluetooth Device 1', 'icon': Icons.bluetooth, 'color': Colors.black},
    {'name': 'Bluetooth Device 2', 'icon': Icons.bluetooth, 'color': Colors.black},
  ];

  final List<Map<String, dynamic>> wifiDevices = [
    {'name': 'WiFi Device 1', 'icon': Icons.wifi, 'color': Colors.black},
    {'name': 'WiFi Device 2', 'icon': Icons.wifi, 'color': Colors.black},
  ];

  final List<Map<String, dynamic>> mqttDevices = [
    {'name': 'MQTT Device 1', 'icon': Icons.cloud, 'color': Colors.black},
    {'name': 'MQTT Device 2', 'icon': Icons.cloud, 'color': Colors.black},
  ];

  final TextEditingController deviceController = TextEditingController();
  String selectedDeviceType = 'WiFi';

  void addDevice(String name) {
    if (name.isEmpty) return;
    setState(() {
      if (selectedDeviceType == 'Bluetooth') {
        bluetoothDevices.add({'name': name, 'icon': Icons.bluetooth, 'color': Colors.black});
      } else if (selectedDeviceType == 'WiFi') {
        wifiDevices.add({'name': name, 'icon': Icons.wifi, 'color': Colors.black});
      } else if (selectedDeviceType == 'MQTT') {
        mqttDevices.add({'name': name, 'icon': Icons.cloud, 'color': Colors.black});
      }
    });
    deviceController.clear();
  }

  void deleteDevice(List<Map<String, dynamic>> deviceList, int index) {
    setState(() {
      deviceList.removeAt(index);
    });
  }

  Widget _buildDeviceSection(String title, List<Map<String, dynamic>> devices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
        const SizedBox(height: 10),
        ...devices.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> device = entry.value;
          return Card(
            color: Colors.orange,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(device['icon'], color: device['color']),
              title: Text(device['name'], style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteDevice(devices, index),
              ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Text('\t \t \t Available Devices'),titleTextStyle: TextStyle(color: Colors.white,fontSize: 28),
        leading: IconButton(onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> HomeScreen()),);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildDeviceSection('Bluetooth Devices', bluetoothDevices),
            _buildDeviceSection('WiFi Devices', wifiDevices),
            _buildDeviceSection('MQTT Devices', mqttDevices),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedDeviceType,
              decoration: InputDecoration(
                labelText: 'Select Device Type',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: ['Bluetooth', 'WiFi', 'MQTT']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDeviceType = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: deviceController,
              decoration: InputDecoration(
                labelText: 'Enter Device Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => addDevice(deviceController.text),
              child: Text('Add Device',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
