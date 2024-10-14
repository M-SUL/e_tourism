import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'driversListScreen.dart';

class Editguide extends StatefulWidget {
   Editguide({super.key});

  @override
  State<Editguide> createState() => _EditguideState();
}

class _EditguideState extends State<Editguide> {
   final Map<String, String> data = {
     'firstName': "mhd",
     'lastName': "sul",
     'mobile': "0973377296",
     'address': "damascus",
     'description': "some description",
   };

  final Map<String, TextEditingController> formControllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'mobile': TextEditingController(),
    'address': TextEditingController(),
    'description': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    formControllers["firstName"]!.text=data["firstName"]!;
    formControllers["lastName"]!.text=data["lastName"]!;
    formControllers["mobile"]!.text=data["mobile"]!;
    formControllers["address"]!.text=data["address"]!;
    formControllers["description"]!.text=data["description"]!;
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
      bottomNavigationBar: Container(
        height: 80,
        color: const Color.fromRGBO(243, 237, 247, 1),
        child:  Center(
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
                    GestureDetector(child: const Icon(Icons.bookmark_border), onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Driverslistscreen();
                      }));
                    },),
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
                  children: [
                    Icon(Icons.settings),
                    Text("settings")
                  ],
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
                          controller: formControllers["mobile"],
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Please enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: formControllers["address"],
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Processing Data')),
                                      );
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
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
