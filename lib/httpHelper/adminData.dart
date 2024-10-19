import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter/material.dart';

const url = "http://mhdaliharmalani.pythonanywhere.com";

class AdminData {
  Future<List<List<String>>> getDrivers() async {
    /// no data for input and return the list of drivers like in the example
    await Future.delayed(const Duration(seconds: 2));
    return [
      ["majd kamar", "some descriptions and some phone numbers "],
      ["majd kamar", "some descriptions and some phone numbers "],
      ["mohamad suleyman", "some descriptions and some phone numbers "],
      ["ali harmalani", "some descriptions and some phone numbers "],
      ["saeed saad", "some descriptions and some phone numbers "],
      ["hamid hamd", "some descriptions and some phone numbers "],
      ["tarek tark", "some descriptions and some phone numbers "],
      ["sami smsm", "some descriptions and some phone numbers "],
    ];
  }

  Future<Map<String, String>> getOneDriver({required String fullname}) async {
    /// input the full name and get the driver data like this
    await Future.delayed(const Duration(seconds: 2));
    return {
      'firstName': "mhd",
      'lastName': "sul",
      'mobile': "0973377296",
      'address': "damascus",
      'description': "some description",
    };
  }

  Future<bool> addDriver({required Map<String, String> data}) async {
    /// send data to back and and return true if added and false if not
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }



  Future<List<List>> getGuides() async {
    // Define the API endpoint
    final url = Uri.parse('http://mhdaliharmalani.pythonanywhere.com/api/tourism/guides/');

    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response as a List of Map<String, dynamic>
      final List<dynamic> data = json.decode(response.body);
      // final List<dynamic> data1 = json.decode(response.body);
      // Convert the JSON data into a list of guides
      // List<Map<String, dynamic>> data1 = [];  // Use a map to store each guide's details


      
      List<List> guides = data.map((guide) {
        
        return [
          guide['first_name'] as String,     // 'first_name' from the API
          // guide['last_name'] as String,
          guide['description'] as String,
          guide['id']

        ];
      }).toList();

      print(guides);

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
        'description': data['description'],
      };
    } else {
      throw Exception('Failed to fetch guide with id $id');
    }
  }

  // Method for updating a guide
  Future<bool> updateGuide({required int id, required Map<String, String> updateData}) async {
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
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

