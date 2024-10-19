import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../httpHelper/adminData.dart';
import 'ProgramsListScreen.dart';
import 'driversListScreen.dart';
import 'guidesListScreen.dart';

class Addprogramscreen extends StatefulWidget {
  Addprogramscreen({super.key});

  @override
  State<Addprogramscreen> createState() => _AddprogramscreenState();
}

class _AddprogramscreenState extends State<Addprogramscreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  final Map<String, TextEditingController> formControllers = {
    'name': TextEditingController(),
    'description': TextEditingController(),
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
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
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const Guideslistscreen();
                          }));
                        },
                        child: const Icon(Icons.location_on_outlined)),
                    const Text("Guids")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const Driverslistscreen();
                          }));
                        },
                        child: Icon(Icons.bookmark_outline)),
                    Text("Drivers")
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
                        child: const Icon(Icons.notifications)),
                    const Text("Programs")
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Icon(Icons.settings), Text("settings")],
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "new Program",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                const CircleAvatar(
                  maxRadius: 55,
                  minRadius: 50,
                  backgroundImage: AssetImage("assets/images/imageHolder.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: formControllers["name"],
                          decoration: InputDecoration(
                            labelText: 'name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter program name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: formControllers["description"],
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text(_startDate == null
                              ? 'Select Start Date'
                              : 'Start Date: ${_startDate!.year}-${_startDate!.month}-${_startDate!.day}'),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text(_endDate == null
                              ? 'Select End Date'
                              : 'End Date:${_endDate!.year}-${_endDate!.month}-${_endDate!.day}'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_validateDates() != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          _validateDates() ?? "sdasdasdd")),
                                );
                                return;
                              }
                              //todo send data to backend
                              // Collect form data
                              final newProgram = {
                                'name': formControllers['name']!.text,
                                'description':
                                    formControllers['description']!.text,
                                'start_date':
                                    "${_startDate!.year}-${_startDate!.month}-${_startDate!.day}",
                                'end_date':
                                    "${_endDate!.year}-${_endDate!.month}-${_endDate!.day}",
                                'type': "eco",
                              };
                              print(newProgram["start_date"]);
                              // Call addGuide method from AdminData
                              bool success = await AdminData()
                                  .addProgram(data: newProgram);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('program added successfully')),
                                );
                                
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Failed to add program')),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(243, 237, 247, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String? _validateDates() {
    if (_startDate != null && _endDate != null) {
      if (_endDate!.isBefore(_startDate!)) {
        return 'End date must be after start date';
      }
    }
    return null;
  }
}
