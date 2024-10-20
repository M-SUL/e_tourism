import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProgramsListScreen.dart';

class DriverToursScreen extends StatefulWidget {
  @override
  _DriverToursScreenState createState() => _DriverToursScreenState();
}

class _DriverToursScreenState extends State<DriverToursScreen> {
  List<Map<String, dynamic>> drivers = [];
  int? selectedDriverId;
  DateTime? startDate;
  DateTime? endDate;
  int? toursNumber;

  @override
  void initState() {
    super.initState();
    fetchDrivers();
  }

  // Fetch drivers from the API and populate the dropdown
  Future<void> fetchDrivers() async {
    final url = Uri.parse('mhdaliharmalani.pythonanywhere.com/api/tourism/drivers');
    final response = await http.get(url);


    if (response.statusCode == 200) {
      setState(() {
        // print('ok'*5);
        print('Response body: ${response.body}');

        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> drivers = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('no'*5);
      // Handle the error
      print('Failed to load drivers');
    }
  }

  // Function to select a date using showDatePicker
  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != (isStartDate ? startDate : endDate)) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  // Function to fetch tours number for the selected driver and dates
  Future<void> fetchToursNumber() async {
    if (selectedDriverId != null && startDate != null && endDate != null) {
      final url = Uri.parse('mhdaliharmalani.pythonanywhere.com/api/tourism/tours/get_number_of_driver_tours/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'driver_id': selectedDriverId,
          'start_date': startDate!.toIso8601String(),
          'end_date': endDate!.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        setState(() {
          toursNumber = data['number_of_driver_tours'];
        });
      } else {
        // Handle error
        print('Failed to load tours number');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        color: const Color.fromRGBO(243, 237, 247, 1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width/6,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(234, 221, 255, 1),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right: Radius.circular(20))
                      ),
                      child: const Icon(Icons.location_on),
                    ),
                    const Text("Guids")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: size.width / 6,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(234, 221, 255, 1),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20))),
                        child: const Icon(Icons.bookmark)),
                    const Text("Drivers")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Programslistscreen();
                      }));
                    },child: const Icon(Icons.notifications_outlined)),
                    const Text("Programs")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: size.width / 6,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(234, 221, 255, 1),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20))),
                        child: const Icon(Icons.settings)),
                    /*GestureDetector(onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Programslistscreen();
                      }));
                    },child: const Icon(Icons.settings)),*/
                    const Text("settings")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(title: Text('Driver Tours Number')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown for driver names
            DropdownButton<int>(
              isExpanded: true,
              hint: Text('Driver name'),
              value: selectedDriverId,
              onChanged: (int? newValue) {
                setState(() {
                  selectedDriverId = newValue;
                });
              },
              items: drivers.map<DropdownMenuItem<int>>((driver) {
                return DropdownMenuItem<int>(
                  value: driver['id'],
                  child: Text(driver['name']),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Date picker for start date
            GestureDetector(
              onTap: () => selectDate(context, true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(startDate != null
                    ? 'From: ${startDate!.toLocal()}'.split(' ')[0]
                    : 'From date'),
              ),
            ),
            const SizedBox(height: 16),

            // Date picker for end date
            GestureDetector(
              onTap: () => selectDate(context, false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(endDate != null
                    ? 'To: ${endDate!.toLocal()}'.split(' ')[0]
                    : 'To date'),
              ),
            ),
            const SizedBox(height: 32),

            // Button to fetch tours number
            ElevatedButton(
              onPressed: fetchToursNumber,
              child: Text('Get Tours Number'),
            ),
            const SizedBox(height: 32),

            // Display the number of tours
            if (toursNumber != null)
              Text(
                'Tours Number: $toursNumber',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
