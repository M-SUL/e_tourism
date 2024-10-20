import 'package:e_tourism/httpHelper/adminData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../httpHelper/clintsData.dart';

class Programdetailsscreen extends StatefulWidget {
  const Programdetailsscreen(
      {super.key, required this.id, required this.image});

  final int id;
  final String image;

  @override
  State<Programdetailsscreen> createState() => _ProgramdetailsscreenState();
}

class _ProgramdetailsscreenState extends State<Programdetailsscreen> {
  Map<String, dynamic> data = {};
  List<List<dynamic>> tours = [];
  List<bool> checked = [];
  bool dataIsset = false;

  Future<void> setData() async {
    data = await AdminData().getOneProgram(id: widget.id);
    tours = await AdminData().getToursForProgram(widget.id);
    for (int i = 0; i < tours.length; i++) {
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
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 0,
                  width: size.width,
                  height: 578,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(234, 221, 255, 1),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 10, right: 10),
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
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          checked.fillRange(
                                              0, checked.length, true);
                                        });
                                      },
                                      child: const Text(
                                        "select all",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color:
                                                Color.fromRGBO(79, 55, 138, 1)),
                                      ))
                                ],
                              ),
                              Column(
                                children: tours.map((element) {
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
                                              width: 250,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    element[1]!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20),
                                                  ),
                                                  //Text(element[6]!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Checkbox(
                                                  value: checked[
                                                      tours.indexOf(element)],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checked[tours.indexOf(
                                                          element)] = value!;
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
                                    child: ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.deepPurple)),
                                        onPressed: () {
                                          int sum = 0;
                                          int index = 0;
                                          int i = 0;
                                          checked.forEach((value) {
                                            if (value) {
                                              index = i;
                                              sum++;
                                            }
                                            i++;
                                          });
                                          if (sum == 1) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(tours[index][1]),
                                                  content: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text("from/to"),
                                                          Text(
                                                              "${tours[index][6]}/${tours[index][7]}"),
                                                        ],
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                              "Available seats"),
                                                          Text(
                                                              "${tours[index][8]}"),
                                                        ],
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                              "Driver name"),
                                                          Text(
                                                              "${tours[index][4]}"),
                                                        ],
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                              "guid name"),
                                                          Text(
                                                              "${tours[index][3]}"),
                                                        ],
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text("cost"),
                                                          Text(
                                                              "${tours[index][5]}"),
                                                        ],
                                                      ),
                                                      const Divider(),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('next'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();

                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            double price = double.parse(
                                                                "${tours[index][5]}");
                                                            double total = double.parse(
                                                                "${tours[index][5]}");
                                                            int count = 1;
                                                            return StatefulBuilder(builder: (context,setState){
                                                              return AlertDialog(
                                                                title: Text(
                                                                    tours[index]
                                                                    [1]),
                                                                content: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                count > 1 ? count-- : null;

                                                                                total = price * count;
                                                                              });
                                                                            },
                                                                            icon:
                                                                            Icon(Icons.indeterminate_check_box_sharp)),
                                                                        Text(count
                                                                            .toString()),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                count++;
                                                                                total = price * count;
                                                                              });
                                                                            },
                                                                            icon:
                                                                            Icon(Icons.add_box_sharp))
                                                                      ],
                                                                    ),
                                                                    Text("total"),
                                                                    Text(total
                                                                        .toString()),
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child:
                                                                    const Text(
                                                                        'pay'),
                                                                    onPressed:
                                                                        () async {
                                                                          Map<String, dynamic> data={
                                                                            "tour_id":tours[index][0],
                                                                            "total_number_of_people":count,
                                                                          };

                                                                          bool success = await ClintsData().addOneTour(data);
                                                                          if (success) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              const SnackBar(content: Text('payed successfully')),
                                                                            );
                                                                            Navigator.pop(context);  // Navigate back after deletion
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              const SnackBar(content: Text('Failed to pay')),
                                                                            );
                                                                          }
                                                                      Navigator.of(
                                                                          context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          else{
                                            i=0;
                                            double cost=0;
                                            checked.forEach((value) {
                                              if (value) {
                                                cost+=double.parse(tours[i][5]);
                                              }
                                              i++;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext
                                              context) {
                                                double price = cost;
                                                double total = cost;
                                                int count = 1;
                                                return StatefulBuilder(builder: (context,setState){
                                                  return AlertDialog(
                                                    title: Text(
                                                        tours[index]
                                                        [1]),
                                                    content: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () {
                                                                  setState(() {
                                                                    count > 1 ? count-- : null;

                                                                    total = price * count;
                                                                  });
                                                                },
                                                                icon:
                                                                Icon(Icons.indeterminate_check_box_sharp)),
                                                            Text(count
                                                                .toString()),
                                                            IconButton(
                                                                onPressed:
                                                                    () {
                                                                  setState(() {
                                                                    count++;
                                                                    total = price * count;
                                                                  });
                                                                },
                                                                icon:
                                                                Icon(Icons.add_box_sharp))
                                                          ],
                                                        ),
                                                        Text("total"),
                                                        Text(total
                                                            .toString()),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                        const Text(
                                                            'pay'),
                                                        onPressed:
                                                            () async {
                                                          List<Map<String, dynamic>> data=[];
                                                          i=0;
                                                          checked.forEach((value) {
                                                            if (value) {
                                                              data.add({
                                                                "tour_id":tours[i][0],
                                                                "total_number_of_people":count,
                                                              });
                                                            }
                                                            i++;
                                                          });
                                                          var  data1={
                                                            "registrations":data,
                                                          };
                                                              bool success = await ClintsData().addTours(data1);
                                                              if (success) {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  const SnackBar(content: Text('payed successfully')),
                                                                );
                                                                Navigator.pop(context);  // Navigate back after deletion
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  const SnackBar(content: Text('Failed to pay')),
                                                                );
                                                              }
                                                          Navigator.of(
                                                              context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                              },
                                            );
                                          }
                                        },
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )),
                              const SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
