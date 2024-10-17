class AdminData {
  Future<List<List<String>>> getDrivers() async {
    /// no data for input and return the list of drivers like in the example
    await Future.delayed(Duration(seconds: 2));
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
    await Future.delayed(Duration(seconds: 2));
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
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  Future<List<List<String>>> getGuides() async {
    /// no data for input and return the list of drivers like in the example
    await Future.delayed(Duration(seconds: 2));
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

  Future<Map<String, String>> getOneGuide({required String fullname}) async {
    /// input the full name and get the driver data like this
    await Future.delayed(Duration(seconds: 2));
    return {
      'firstName': "mhd",
      'lastName': "sul",
      'mobile': "0973377296",
      'address': "damascus",
      'description': "some description",
    };
  }

  Future<bool> addGuide({required Map<String, String> data}) async {
    /// send data to back and and return true if added and false if not
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
