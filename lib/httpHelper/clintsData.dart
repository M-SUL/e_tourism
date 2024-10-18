class ClintsData{
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
  Future<List<Map<String,String>>> getSubTours({required String name}) async {
    /// get sub tours for the client with same name as input
    await Future.delayed(const Duration(seconds: 2));
    return [
      {"name":"Damascus",
        "from":"25/10/2024",
        "to":"28/10",
        "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
      },
      {"name":"Homs",
        "from":"28/10/2024",
        "to":"30/10",
        "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
      },
      {"name":"Latakia",
        "from":"30/10/2024",
        "to":"2/11",
        "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
      },
      {"name":"Istanbul",
        "from":"10/10/2024",
        "to":"15/10",
        "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
      }
    ];
  }
  Future<Map<String,dynamic>> getProgramData({required String name}) async {
    /// get program details with same name as input
    await Future.delayed(const Duration(seconds: 2));
    return
      {
        "name":"syria",
        "image":"assets/images/pro1.png",
        "tours":[
          {"name":"Damascus",
            "from":"25/10/2024",
            "to":"28/10",
            "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
          },
          {"name":"Homs",
            "from":"28/10/2024",
            "to":"30/10",
            "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
          },
          {"name":"Latakia",
            "from":"30/10/2024",
            "to":"2/11",
            "description":"Supporting line text lorem ipsum dolor sit amet, consectetur"
          },
        ],
      }

    ;
  }
}