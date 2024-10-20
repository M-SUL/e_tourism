import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:flutter/material.dart';
const url = "http://mhdaliharmalani.pythonanywhere.com";

class AdminData {
  Future<List<List>> getDrivers() async {
    /// no data for input and return the list of drivers like in the example
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/drivers/');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);

      List<List> drivers = data.map((driver) {
        return [
          driver['first_name'] as String, // 'first_name' from the API
          driver['description'] as String,
          driver['id']
        ];
      }).toList();

      return drivers;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load drivers');
    }
  }

  Future<Map<String, String>> getOneDriver({required int id}) async {
    final uri = Uri.parse('$url/api/tourism/drivers/$id/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return {
        'firstName': data['first_name'],
        'lastName': data['last_name'],
        'plate_number': data['plate_number'],
        'description': data['description']
      };
    } else {
      throw Exception('Failed to fetch driver with id $id');
    }
  }

  Future<bool> updateDriver(
      {required int id, required Map<String, String> updateData}) async {
    final uri = Uri.parse('$url/api/tourism/drivers/$id/');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateData),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteDriver({required int id}) async {
    final uri = Uri.parse('$url/api/tourism/drivers/$id/');
    final response = await http.delete(uri);

    return response.statusCode == 204;
  }

  Future<bool> addDriver({required Map<String, String> data}) async {
    /// send data to back and and return true if added and false if not
    final uri = Uri.parse('$url/api/tourism/drivers/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
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

  Future<List<List>> getGuides() async {
    // Define the API endpoint
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/guides/');

    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);

      List<List> guides = data.map((guide) {
        return [
          guide['first_name'] as String, // 'first_name' from the API
          guide['description'] as String,
          guide['id']
        ];
      }).toList();

      // print(guides);

      return guides;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load guides');
    }
  }

  // Method for fetching a single guide's details
  Future<Map<String, String>> getOneGuide({required int id}) async {
    final uri = Uri.parse('$url/api/tourism/guides/$id/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return {
        'firstName': data['first_name'],
        'lastName': data['last_name'],
        'mobile': data['mobile'],
        'address': data['address'],
        'description': data['description']
      };
    } else {
      throw Exception('Failed to fetch guide with id $id');
    }
  }

  // Method for updating a guide
  Future<bool> updateGuide(
      {required int id, required Map<String, String> updateData}) async {
    final uri = Uri.parse('$url/api/tourism/guides/$id/');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateData),
    );
    return response.statusCode == 200;
  }

  // Method for deleting a guide
  Future<bool> deleteGuide({required int id}) async {
    final uri = Uri.parse('$url/api/tourism/guides/$id/');
    final response = await http.delete(uri);

    return response.statusCode == 204;
  }

  Future<bool> addGuide({required Map<String, String> data}) async {
    /// send data to back and and return true if added and false if not
    final uri = Uri.parse('$url/api/tourism/guides/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
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

  Future<List<List>> getPrograms() async {
    /// no data for input and return the list of drivers like in the example
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/programs/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);
      int i = 0;
      List<List> programs = data.map((program) {
        i++;
        String dateS1 = program['start_date'] as String;
        DateTime dateS2 = DateTime.parse(dateS1);
        String dateE1 = program['end_date'] as String;
        DateTime dateE2 = DateTime.parse(dateE1);
        return [
          program['id'],
          program['name'] as String,
          program['type'] as String,
          program['description'] as String,
          "${dateS2.year}-${dateS2.month}-${dateS2.day}",
          "${dateE2.year}-${dateE2.month}-${dateE2.day}",
          i % 2 == 0 ? "assets/images/pro1.png" : "assets/images/pro2.png"
        ];
      }).toList();

      return programs;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load drivers');
    }
  }
  Future<List<List>> getProgramsWithSearch(String search) async {
    /// no data for input and return the list of drivers like in the example
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/programs/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);
      int i = 0;
      List<List> programss=[];
      List<List> programs = data.map((program) {
        i++;
        String dateS1 = program['start_date'] as String;
        DateTime dateS2 = DateTime.parse(dateS1);
        String dateE1 = program['end_date'] as String;
        DateTime dateE2 = DateTime.parse(dateE1);
        if(search==program['name'] as String)
          {
            programss.add([
              program['id'],
              program['name'] as String,
              program['type'] as String,
              program['description'] as String,
              "${dateS2.year}-${dateS2.month}-${dateS2.day}",
              "${dateE2.year}-${dateE2.month}-${dateE2.day}",
              i % 2 == 0 ? "assets/images/pro1.png" : "assets/images/pro2.png"
            ]);
          }
        return [
          program['id'],
          program['name'] as String,
          program['type'] as String,
          program['description'] as String,
          "${dateS2.year}-${dateS2.month}-${dateS2.day}",
          "${dateE2.year}-${dateE2.month}-${dateE2.day}",
          i % 2 == 0 ? "assets/images/pro1.png" : "assets/images/pro2.png"
        ];
      }).toList();

      return programss;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load drivers');
    }
  }
  Future<List<List>> getProgramsWithSearchdate(DateTime start,DateTime end) async {
    /// no data for input and return the list of drivers like in the example
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/programs/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);
      int i = 0;
      List<List> programss=[];
      List<List> programs = data.map((program) {
        i++;
        String dateS1 = program['start_date'] as String;
        DateTime dateS2 = DateTime.parse(dateS1);
        String dateE1 = program['end_date'] as String;
        DateTime dateE2 = DateTime.parse(dateE1);
        print(dateE2.isBefore(end));
        print(dateS2.isBefore(end));
        print(dateE2.isAfter(start));
        print(dateE2.isAfter(start));
        if(dateE2.isBefore(end)&&dateS2.isBefore(end)&&dateE2.isAfter(start)&&dateS2.isAfter(start))
          {
            programss.add([
              program['id'],
              program['name'] as String,
              program['type'] as String,
              program['description'] as String,
              "${dateS2.year}-${dateS2.month}-${dateS2.day}",
              "${dateE2.year}-${dateE2.month}-${dateE2.day}",
              i % 2 == 0 ? "assets/images/pro1.png" : "assets/images/pro2.png"
            ]);
          }
        return [
          program['id'],
          program['name'] as String,
          program['type'] as String,
          program['description'] as String,
          "${dateS2.year}-${dateS2.month}-${dateS2.day}",
          "${dateE2.year}-${dateE2.month}-${dateE2.day}",
          i % 2 == 0 ? "assets/images/pro1.png" : "assets/images/pro2.png"
        ];
      }).toList();

      return programss;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load drivers');
    }
  }

  Future<bool> addProgram({required Map<String, dynamic> data}) async {
    /// send data to back and and return true if added and false if not
    final uri = Uri.parse('$url/api/tourism/programs/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    // Check if the response is successful (status code 201 for creation success)
    if (response.statusCode == 201) {
      return true; // Guide added successfully
    } else {
      // Handle any errors or unsuccessful response
      print('Failed to add Program: ${response.body}');
      return false; // Guide creation failed
    }
  }

  Future<bool> addTour({required Map<String, dynamic> data}) async {
    /// send data to back and and return true if added and false if not
    final uri = Uri.parse('$url/api/tourism/tours/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    // Check if the response is successful (status code 201 for creation success)
    if (response.statusCode == 201) {
      return true; // Guide added successfully
    } else {
      // Handle any errors or unsuccessful response
      print('Failed to add tour: ${response.body}');
      return false; // Guide creation failed
    }
  }

  Future<bool> deleteProgram({required int id}) async {
    final uri = Uri.parse('$url/api/tourism/programs/$id/');
    final response = await http.delete(uri);

    return response.statusCode == 204;
  }

  Future<Map<String, String>> getOneProgram({required int id}) async {
    final uri = Uri.parse('$url/api/tourism/programs/$id/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String dateS1 = data['start_date'] as String;
      DateTime dateS2 = DateTime.parse(dateS1);
      String dateE1 = data['end_date'] as String;
      DateTime dateE2 = DateTime.parse(dateE1);
      return {
        'name': data['name'],
        "id": data['id'].toString(),
        'start_date': "${dateS2.year}-${dateS2.month}-${dateS2.day}",
        'end_date': "${dateE2.year}-${dateE2.month}-${dateE2.day}",
        'description': data['description']
      };
    } else {
      throw Exception('Failed to fetch program with id $id');
    }
  }

  Future<bool> updateProgram(
      {required int id, required Map<String, String> updateData}) async {
    final uri = Uri.parse('$url/api/tourism/programs/$id/');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateData),
    );
    return response.statusCode == 200;
  }

  Future<List<List>> getToursForProgram(int id) async {
    /// no data for input and return the list of drivers like in the example
    final url = Uri.parse(
        'http://mhdaliharmalani.pythonanywhere.com/api/tourism/tours/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);

      List<List> tours = [];
      data.forEach((tour) {
        if (tour['program']['id'] == id) {
          String dateS1 = tour['start_date'] as String;
          DateTime dateS2 = DateTime.parse(dateS1);
          String dateE1 = tour['end_date'] as String;
          DateTime dateE2 = DateTime.parse(dateE1);
          tours.add([
            tour['id'],
            tour['name'],
            tour['program']['id'],
            "${tour['guide']['first_name']} ${tour['guide']['last_name']}",
            "${tour['driver']['first_name']} ${tour['driver']['last_name']}",
            tour['price'],
            "${dateS2.year}-${dateS2.month}-${dateS2.day}",
            "${dateE2.year}-${dateE2.month}-${dateE2.day}",
            //   tour['description'],
            tour['max_people'],
          ]);
        }
      });

      return tours;
    } else {
      // Handle error if the response code is not 200
      throw Exception('Failed to load drivers');
    }
  }
}
