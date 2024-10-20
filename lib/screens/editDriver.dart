import 'package:e_tourism/httpHelper/adminData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DriverToursScreen.dart';
import 'ProgramsListScreen.dart';
import 'guidesListScreen.dart';

class Editdriver extends StatefulWidget {
  const Editdriver({super.key, required this.id});
  final int id;

  @override
  State<Editdriver> createState() => _EditdriverState();
}

class _EditdriverState extends State<Editdriver> {
  Map<String, String> data = {};
  bool dataIsset=false;
  Future<void> setData() async {
    data =await AdminData().getOneDriver(id: widget.id);
    formControllers["firstName"]!.text=data["firstName"]!;
    formControllers["lastName"]!.text=data["lastName"]!;
    formControllers["plate_number"]!.text=data["plate_number"]!;
    formControllers["description"]!.text=data["description"]!;
    setState(() {
      dataIsset=true;
    });
  }
  final Map<String, TextEditingController> formControllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'plate_number': TextEditingController(),
    'description': TextEditingController(),
  };


  @override
  void initState() {
    super.initState();
    setData();

  }

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
            icon:  const Icon(Icons.arrow_back)),
      ),
      bottomNavigationBar:Container(
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
                    GestureDetector(onTap: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DriverToursScreen();
                      }));
                    },child: const Icon(Icons.settings)),
                    const Text("settings")],
                )
              ],
            ),
          ),
        ),
      ),
      body: !dataIsset
          ? Center(
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ))
          : ListView(
        children: [
          Center(
            child: Column(
              children: [
                Text("${data["firstName"]} ${data["lastName"]} ",style: const TextStyle(fontSize: 25),),
                const SizedBox(height: 5,),
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
                          controller:formControllers["firstName"] ,
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
                              return 'Please enter your plate number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller:formControllers["description"] ,
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final updateData = {
                                        'first_name': formControllers['firstName']!.text,
                                        'last_name': formControllers['lastName']!.text,
                                        'plate_number': formControllers['plate_number']!.text,
                                        'description': formControllers['description']!.text,
                                      };
                                      // Call updateGuide method from AdminData
                                      bool success = await AdminData().updateDriver(id: widget.id, updateData: updateData);
                                      // Send PUT request to update guide
                                      if (success) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Driver updated successfully')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Failed to update Driver')),
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text('update'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:const Color.fromRGBO(243, 237, 247, 1),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool success = await AdminData().deleteDriver(id: widget.id);
                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Driver deleted successfully')),
                                      );
                                      Navigator.pop(context);  // Navigate back after deletion
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Failed to delete driver')),
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text('delete'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:const Color.fromRGBO(243, 237, 247, 1),
                                ),
                              ),
                            ),
                          ],
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
