import 'package:e_tourism/screens/guidesListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../httpHelper/adminData.dart';

class Adddriverscreen extends StatelessWidget {
  Adddriverscreen({super.key});

  final Map<String, TextEditingController> formControllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'plate_number': TextEditingController(),
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
                    GestureDetector(onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_outlined),
                    Text("Programs")
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
                  "new Driver",
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
                          controller: formControllers["firstName"],
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: formControllers["lastName"],
                          decoration: InputDecoration(
                            labelText: 'Second Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your second name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: formControllers["plate_number"],
                          decoration: InputDecoration(
                            labelText: 'plate number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your plate_number';
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
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Collect form data
                              final newDriverData = {
                                'first_name': formControllers['firstName']!.text,
                                'last_name': formControllers['lastName']!.text,
                                'plate_number': formControllers['plate_number']!.text,
                                'description': formControllers['description']!.text,
                              };
                              // Call addGuide method from AdminData
                              bool success = await AdminData().addDriver(data: newDriverData);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Guide added successfully')),
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
}
