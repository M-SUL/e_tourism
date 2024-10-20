import 'dart:convert';
import 'package:e_tourism/util/globals.dart' as global;
import 'package:http/http.dart' as http;


class ClintsData{
  static const url = "http://mhdaliharmalani.pythonanywhere.com";
  Future<List<Map<String,String>>> getPrograms({required String name}) async {
    /// send search String to back and and return the results programs
    await Future.delayed(const Duration(seconds: 2));
    return [
      {"name":"SYRIA",
      "duration":"8 days",
        "image":"assets/images/pro1.png"
      },
      {"name":"TURKEY",
        "duration":"5 days",
        "image":"assets/images/pro2.png"
      }
    ];
  }

  Future<bool> registerUser({required Map<String, String> user}) async {
    final uri = Uri.parse('$url/api/auth/register/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );
    return response.statusCode == 201;
  }
  Future<bool> login({required Map<String, String> user}) async {
    final uri = Uri.parse('$url/api/auth/login/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );
    final Map<String,dynamic> data = json.decode(response.body);
    print(response.body);
    if(response.statusCode==200)
      {
        global.userToken=data["access"];
      }
    return response.statusCode == 200;
  }
  Future<List<List<dynamic>>> getSubTours() async {
    /// get sub tours for the client with same name as input
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/tour_registration/');

    final response = await http.get(url,  headers: {'Content-Type': 'application/json','Authorization':'Bearer ${global.userToken}'},);

    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);
      //print(id);
      print(data);
      List<List> tours = [];
      data.forEach((tour) {
          String dateS1 = tour['tour']['start_date'] as String;
          DateTime dateS2 = DateTime.parse(dateS1);
          String dateE1 = tour['tour']['end_date'] as String;
          DateTime dateE2 = DateTime.parse(dateE1);
          tours.add([
            tour['id'],
            tour['tour']['name'],
            tour['tour']['program'],
            "${dateS2.year}-${dateS2.month}-${dateS2.day}",
            "${dateE2.year}-${dateE2.month}-${dateE2.day}",
          ]);

      });

      return tours;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load drivers');
    }
  }
  Future<bool> addOneTour(Map<String, dynamic> data) async {
    /// get sub tours for the client with same name as input
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/tour_registration/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${global.userToken}'
      },
      body: json.encode(data),
    );

    // Check if the response is successful (status code 201 for creation success)
    if (response.statusCode == 201) {
      return true; // Guide added successfully
    } else {
      // Handle any errors or unsuccessful response
      print('Failed to add guide: ${response.body}');
      return false; // Guide creation failed
    }
  }
  Future<bool> addTours(Map<String,dynamic> data) async {
    /// get sub tours for the client with same name as input
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/tour_registration/multi_create/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${global.userToken}'
      },
      body: json.encode(data),
    );

    // Check if the response is successful (status code 201 for creation success)
    if (response.statusCode == 201) {
      return true; // Guide added successfully
    } else {
      // Handle any errors or unsuccessful response
      print('Failed to add pay: ${response.body}');
      return false; // Guide creation failed
    }
  }
}