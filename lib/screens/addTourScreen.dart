import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../httpHelper/adminData.dart';
import 'ProgramsListScreen.dart';
import 'driversListScreen.dart';
import 'guidesListScreen.dart';

class Addtourscreen extends StatefulWidget {
  final int programId;

   Addtourscreen({super.key, required this.programId});

  @override
  State<Addtourscreen> createState() => _AddtourscreenState();
}

class _AddtourscreenState extends State<Addtourscreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<List<dynamic>> drivers = [];
  List<List<dynamic>> guids = [];
  int selectedDriver=0;
  int selectedGuid=0;
  bool dataIsset = false;
  Future<void> setData() async {
    drivers = await AdminData().getDrivers();
    guids = await AdminData().getGuides();
    if(guids.length==0||drivers.length==0)
      {
        Navigator.pop(context);
      }
    selectedGuid=guids.elementAt(0)[2];
    selectedDriver=drivers.elementAt(0)[2];
    setState(() {
      dataIsset = true;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }
  final Map<String, TextEditingController> formControllers = {
    'name': TextEditingController(),
    'cost': TextEditingController(),
    'capacity': TextEditingController(),
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
                        child: const Icon(Icons.bookmark_outline)),
                    const Text("Drivers")
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
      body:!dataIsset
          ? const Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ))
          : ListView(
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "new Tour",
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
                            labelText: 'tour name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter tour name';
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
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text(_endDate == null
                              ? 'Select End Date'
                              : 'End Date:${_endDate!.year}-${_endDate!.month}-${_endDate!.day}'),
                        ),

                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: formControllers["cost"],
                          decoration: InputDecoration(
                            labelText: 'tour cost',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter cost';
                            }
                            if(!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)*').hasMatch(value))
                              {
                                return 'Please enter a valid cost';
                              }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: formControllers["capacity"],
                          decoration: InputDecoration(
                            labelText: 'tour capacity',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter capacity';
                            }
                            if(!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)*').hasMatch(value))
                            {
                              return 'Please enter a valid capacity';
                            }
                            return null;
                          },
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Driver"),
                        const SizedBox(width: 30,),
                        Center(
                          child: DropdownButton<int>(
                            hint: const Text('driver'),
                            value:selectedDriver ,
                            onChanged: (int? newValue) {
                              setState(() {
                                if(newValue!=null)
                                  {
                                    selectedDriver = newValue;
                                  }
                              });
                            },
                            items: drivers.map<DropdownMenuItem<int>>((List<dynamic> driver) {

                              return DropdownMenuItem<int>(
                                value: driver[2],
                                child: Text(driver[0]),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Guid"),
                        const SizedBox(width: 30,),
                        Center(
                          child: DropdownButton<int>(
                            hint: const Text('guid'),
                            value:selectedGuid ,
                            onChanged: (int? newValue) {
                              setState(() {
                                if(newValue!=null)
                                  {
                                    selectedGuid = newValue;
                                  }
                              });
                            },
                            items: guids.map<DropdownMenuItem<int>>((List<dynamic> guid) {
                              return DropdownMenuItem<int>(
                                value: guid[2],
                                child: Text(guid[0]),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Collect form data
                              final tourData = {
                                'name': formControllers['name']!.text,
                                'price': formControllers['cost']!.text,
                                'max_people': formControllers['capacity']!.text,
                                'driver_id': selectedDriver,
                                'program_id': widget.programId,
                                'guide_id': selectedGuid,
                                'start_date': _startDate.toString(),
                                'tour_date': '2025-12-15T01:00:01Z',
                                'end_date':
                                _endDate.toString(),
                                'type': "eco",
                              };
                              // Call addGuide method from AdminData
                              bool success = await AdminData().addTour(data: tourData);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('tour added successfully')),
                                );
                                Navigator.pop(context);  // Optionally navigate back after success
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to add guide')),
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
