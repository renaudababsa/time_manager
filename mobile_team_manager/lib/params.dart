import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'main.dart';

class ParamsStateful extends StatefulWidget {
  const ParamsStateful({super.key});

  @override
  State<ParamsStateful> createState() => _ParamsStatefulState();
}

class _ParamsStatefulState extends State<ParamsStateful> {
  final storage = new FlutterSecureStorage();
  var username = "loading";
  var email = "loading";
  initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var tmpUsername = await storage.read(key: 'username');
    var tmpEmail = await storage.read(key: "email");
    setState(() {
      username = tmpUsername ?? "error";
      email = tmpEmail ?? "error";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            height: 80,
            child: Text('Paramètres',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ))),
        Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.only(top: 80),
                child: Text('username: ' + username,
                    style: const TextStyle(
                      fontSize: 25,
                    ))),
            Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(left: 10, bottom: 20),
                padding: const EdgeInsets.only(top: 30, bottom: 80),
                child: Text('email: ' + email,
                    style: Theme.of(context).textTheme.headline5)),
          ],
        ),
        Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  storage.deleteAll();
                  navigateToLogin(context);
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.black)),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.arrow_forward,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )
                      ]),
                ),
              ),
            ))
      ],
    );
  }
}
