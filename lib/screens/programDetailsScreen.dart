import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../httpHelper/clintsData.dart';

class Programdetailsscreen extends StatefulWidget {
  const Programdetailsscreen({super.key, required this.programName});

  final String programName;

  @override
  State<Programdetailsscreen> createState() => _ProgramdetailsscreenState();
}

class _ProgramdetailsscreenState extends State<Programdetailsscreen> {
  Map<String, dynamic> data = {};
  List<Map<String, String>> tours = [];
  List<bool> checked=[];
  bool dataIsset = false;

  Future<void> setData() async {
    data = await ClintsData().getProgramData(name: widget.programName);
    tours=data["tours"];
    for(int i=0;i<tours.length;i++)
      {
        checked.add(false);
      }
    setState(() {
      dataIsset = true;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: !dataIsset
          ? const Center(
              child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ))
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  width: size.width,
                  height: 277,
                  child: Image.asset(data["image"],fit: BoxFit.cover,),
                ),
                Positioned(
                  top: 270,
                  left: 0,
                  width: size.width,
                  height: 578,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(234, 221, 255, 1),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data["name"]} Program",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Color.fromRGBO(79, 55, 138, 1)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){
                                    setState(() {
                                      checked.fillRange(0, checked.length,true);
                                    });
                                  }, child:  const Text(
                                    "select all",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Color.fromRGBO(79, 55, 138, 1)),
                                  ))
                                ],
                              ),
                              Column(
                                children: tours.map((element){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 103,
                                      width: 376,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width:250,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(element['name']!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                                  Text(element['description']!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Checkbox(value: checked[tours.indexOf(element)], onChanged: (value){
                                                setState(() {
                                                  checked[tours.indexOf(element)]=value!;
                                                });
                                              }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                width: 365,
                                  height: 56,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(Colors.deepPurple)
                                    ),onPressed: (){}, child: const Text("Register",style: TextStyle(color: Colors.white),)),
                                  )),
                              const SizedBox(height: 100,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  left: size.width/1.5,
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.filter_list_alt,color: Color.fromRGBO(79, 55, 138, 1),size: 40,),
                  ),
                ),
              ],
            ),
    );
  }
}
