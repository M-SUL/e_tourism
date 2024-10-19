import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../httpHelper/adminData.dart';
import 'ProgramsListScreen.dart';
import 'driversListScreen.dart';

class Editprogramscreen extends StatefulWidget {
  Editprogramscreen({super.key, required this.id});
  final int id;
  @override
  State<Editprogramscreen> createState() => _EditprogramscreenState();
}

class _EditprogramscreenState extends State<Editprogramscreen> {
  Map<String, String> data = {};
  bool dataIsset=false;
  Future<void> setData() async {
    data =await AdminData().getOneProgram(id: widget.id);
    formControllers["name"]!.text=data["name"]!;
    formControllers["description"]!.text=data["description"]!;
    setState(() {
      dataIsset=true;
    });
  }
  final Map<String, TextEditingController> formControllers = {
    'name': TextEditingController(),
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
                Text("${data["name"]}",style: const TextStyle(fontSize: 25),),
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
                          controller:formControllers["name"] ,
                          decoration: InputDecoration(
                            labelText: 'name',
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
                                        'name': formControllers['name']!.text,
                                        'description': formControllers['description']!.text,
                                      };
                                      // Call updateGuide method from AdminData
                                      bool success = await AdminData().updateProgram(id: widget.id, updateData: updateData);
                                      // Send PUT request to update guide
                                      if (success) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Guide updated successfully')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Failed to update guide')),
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
                                  bool success = await AdminData().deleteProgram(id: widget.id);
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('program deleted successfully')),
                                    );
                                    Navigator.pop(context);  // Navigate back after deletion
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Failed to delete program')),
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
