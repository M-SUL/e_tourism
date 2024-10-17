import 'package:e_tourism/httpHelper/adminData.dart';
import 'package:e_tourism/screens/addDriverScreen.dart';
import 'package:e_tourism/screens/editDriver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'guidesListScreen.dart';

class Driverslistscreen extends StatefulWidget {
  Driverslistscreen({super.key});

  @override
  State<Driverslistscreen> createState() => _DriverslistscreenState();
}

class _DriverslistscreenState extends State<Driverslistscreen> {
  List<List<String>> data = [];
  bool dataISset = false;
  Future<void> setData() async {
    data = await AdminData().getDrivers();
    setState(() {
      dataISset = true;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
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
      body: !dataISset
          ? Center(
              child: Container(
                width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ))
          : SizedBox(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height / 10),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Add Driver",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Adddriverscreen();
                              }));
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(234, 221, 255, 1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: data.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return  Editdriver(fullName: "${item[0]} ${item[1]}");
                                        }));
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                maxRadius: 20,
                                                minRadius: 10,
                                                child: Image.asset(
                                                    "assets/images/imageHolder.png"),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.elementAt(0),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                      width: size.width / 2,
                                                      child: Text(
                                                        item.elementAt(1),
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                        softWrap: true,
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
