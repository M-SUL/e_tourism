import 'package:e_tourism/httpHelper/clintsData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Programsscreen extends StatefulWidget {
  const Programsscreen({super.key, required this.searchString});
  final String searchString;

  @override
  State<Programsscreen> createState() => _ProgramsscreenState();
}

class _ProgramsscreenState extends State<Programsscreen> {
  List<Map<String, String>> programs = [];
  List<Map<String, String>> subTours = [];
  bool dataIsset = false;
  TextEditingController searchString=TextEditingController();

  Future<void> setData() async {
    programs = await ClintsData().getPrograms(name: widget.searchString);
    subTours = await ClintsData().getSubTours(name: "");
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
                              controller: TextEditingController(),
                              decoration: InputDecoration(
                                hintText: 'Search for a tour',
                                suffixIcon: IconButton(onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return Programsscreen(searchString: searchString.text);
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
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/imageHolder.png"),
                            radius: 28,
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
                      const SizedBox(height:10,),
                      SizedBox(
                        height: 267,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: programs.map((element){
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 267,
                                width: 213.6,
                                color:  const Color.fromRGBO(234, 221, 255, 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(element["image"]!,height: 213.6,width:213.6,fit: BoxFit.fill,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(element["name"]!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                          const SizedBox(width: 10,),
                                          const Icon(Icons.circle,color: Color.fromRGBO(79, 55, 138, 1),size:13,),
                                          const SizedBox(width: 10,),
                                          Text(element["duration"]!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height:30,),
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
                      const SizedBox(height:10,),
                      Container(
                        height: 215,
                        width: 362,
                        decoration: const BoxDecoration(
                          color:  Color.fromRGBO(234, 221, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child:Scrollbar(

                          child: ListView(
                            children: subTours.map((element){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical:10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(element['name']!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                        Row(
                                         children: [
                                           Text(element['from']!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                                           const Icon(Icons.arrow_forward,size: 23,),
                                           Text(element['to']!,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
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
}
