import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'main.dart';

class WorkingTimesStateful extends StatefulWidget {
  const WorkingTimesStateful({super.key});

  @override
  State<WorkingTimesStateful> createState() => _WorkingTimesStatefulState();
}

class _WorkingTimesStatefulState extends State<WorkingTimesStateful> {
  final storage = new FlutterSecureStorage();
  var _wtresponse;

  getWorkingTimes() async {
    final storage = new FlutterSecureStorage();
    var user = await storage.read(key: 'id');
    print(user);
    Dio dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["x-csrf-token"] = await storage.read(key: 'token');
    try {
      var tmp = await dio.get('http://localhost:4000/api/workingtimes/{user}');
      setState(() {
        _wtresponse = tmp.data["data"];
        print(_wtresponse);
      });
    } on DioError catch (e) {
      // print status code
      if (e.response != null && e.response?.statusCode == 401) {
        await storage.deleteAll();
        navigateToHome(context);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
    }
  }

  initState() {
    super.initState();
    getWorkingTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Expanded(
          flex: 8,
          child: Text('Historique',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ))),
      Expanded(
          flex: 92,
          child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _wtresponse?.length ?? 0,
              itemBuilder: (context, index) {
                var end = _wtresponse[index]["end"] != null
                    ? _wtresponse[index]["end"]
                    : "no end";
                return Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      _wtresponse[index]["start"].split("T")[0],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "heure d'entrée: " + _wtresponse[index]["start"],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                      title: Text(
                    "heure de sortie: " + end,
                    textAlign: TextAlign.center,
                  )),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 40,
                    endIndent: 40,
                    color: Colors.grey,
                  ),
                ]);
              }))
    ]);
  }
}
