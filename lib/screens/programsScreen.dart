import 'package:e_tourism/httpHelper/adminData.dart';
import 'package:e_tourism/httpHelper/clintsData.dart';
import 'package:e_tourism/screens/programDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Programsscreen extends StatefulWidget {
  Programsscreen({super.key, required this.searchString});

  final String searchString;

  @override
  State<Programsscreen> createState() => _ProgramsscreenState();
}

class _ProgramsscreenState extends State<Programsscreen> {
  List<List<dynamic>> programs = [];
  List<List<dynamic>> subTours = [];
  DateTime? _startDate;
  DateTime? _endDate;
  bool dataIsset = false;
  TextEditingController searchString = TextEditingController();

  Future<void> setData() async {
    if (widget.searchString != "") {
      programs = await AdminData().getProgramsWithSearch(widget.searchString);
    } else {
      programs = await AdminData().getPrograms();
    }
    subTours = await ClintsData().getSubTours();
    setState(() {
      dataIsset = true;
    });
  }
Future<void> withdate() async {
    setState(() {
      dataIsset=false;
    });
    programs = await AdminData().getProgramsWithSearchdate(_startDate!,_endDate!);
  setState(()  {
    dataIsset=true;
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
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: size.width / 1.5,
                            child: TextField(
                              controller: searchString,
                              decoration: InputDecoration(
                                hintText: 'Search for a program',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return Programsscreen(
                                            searchString: searchString.text);
                                      }));
                                    },
                                    icon: const Icon(Icons.search)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(234, 221, 255, 1),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 28,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      int count = 1;
                                      return StatefulBuilder(
                                          builder: (context, setState) {

                                        return AlertDialog(
                                          title: const Text("chose dates"),
                                          content:  Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
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
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('search'),
                                              onPressed: () async {
                                                if(_endDate!=null&&_startDate!=null)
                                                  {
                                                    await withdate();
                                                  }
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                    },
                                  );
                                },
                                icon: const Icon(Icons.filter_alt)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Available Programs",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Color.fromRGBO(79, 55, 138, 1)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 267,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: programs.map((element) {
                            DateTime dateTime = DateTime.parse(element[4]);
                            DateTime dateTime2 = DateTime.parse(element[5]);
                            final difference =
                                dateTime2.difference(dateTime).inDays;
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (comtext) {
                                  return Programdetailsscreen(
                                    id: element[0],
                                    image: element[6],
                                  );
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 267,
                                  width: 213.6,
                                  color: const Color.fromRGBO(234, 221, 255, 1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        element[6]!,
                                        height: 213.6,
                                        width: 213.6,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              element[1]!,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              Icons.circle,
                                              color: Color.fromRGBO(
                                                  79, 55, 138, 1),
                                              size: 13,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              difference.toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Subscribed Tours",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                              color: Color.fromRGBO(79, 55, 138, 1)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 215,
                        width: 362,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(234, 221, 255, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Scrollbar(
                          child: ListView(
                            children: subTours.map((element) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          element[1]!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              element[3]!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 23,
                                            ),
                                            Text(
                                              element[4]!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
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
