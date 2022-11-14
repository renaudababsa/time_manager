import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'params.dart';
import 'workingtimes.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');
  if (token != null) {
    runApp(const MyAppLogged());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      // home: MyStatefulWidget(),
      // create two routes for the app and set the login screen as the home
      routes: {
        // '/': (context) => const LoginPageStateful(),
        '/homePage': (context) => const MyStatefulWidget(),
        '/login': (context) => const LoginPageStateful(),
      },
      home: const LoginPageStateful(),
    );
  }
}

class MyAppLogged extends StatelessWidget {
  const MyAppLogged({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      // home: MyStatefulWidget(),
      // create two routes for the app and set the login screen as the home
      routes: {
        // '/': (context) => const LoginPageStateful(),
        '/homePage': (context) => const MyStatefulWidget(),
        '/login': (context) => const LoginPageStateful(),
      },
      home: const MyStatefulWidget(),
    );
  }
}

void navigateToHome(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/homePage');
}

void navigateToLogin(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/login');
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class LoginPageStateful extends StatefulWidget {
  const LoginPageStateful({super.key});

  @override
  State<LoginPageStateful> createState() => _LoginPageStatefulState();
}

//create a login class to navigate to the home page
class _LoginPageStatefulState extends State<LoginPageStateful> {
  dynamic _email;
  dynamic _password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(78, 115, 223, 1),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/timeManager.png'),
                margin: const EdgeInsets.only(bottom: 106),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value != null && value.contains('@')) {
                        return null;
                      }
                      return 'Not a valid email.';
                    },
                    onSaved: (val) {
                      _email = val;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value != null) {
                        return null;
                      }
                      return 'Not a valid email.';
                    },
                    onSaved: (val) {
                      _password = val;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(211, 51),
                  ),
                  onPressed: _submit,
                  child: const Text('Login'),
                ),
              )
            ],
          ),
        ));
  }

  Future _submit() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      final storage = new FlutterSecureStorage();
      try {
        Response response;
        response = await Dio().post('http://localhost:4000/api/users/login',
            data: {'email': _email, 'password': _password});
        print(response.data["data"]);
        await storage.write(
            key: 'token', value: response.data["token"].toString());
        await storage.write(
            key: 'team_id', value: response.data["data"]["team_id"].toString());
        await storage.write(
            key: 'id', value: response.data["data"]["id"].toString());
        await storage.write(
            key: 'group_id',
            value: response.data["data"]["group_id"].toString());
        await storage.write(
            key: 'email', value: response.data["data"]["email"]);
        await storage.write(
            key: 'username', value: response.data["data"]["username"]);
        // ignore: use_build_context_synchronously
        navigateToHome(context);
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                title: Text('Erreur'),
                content: Text("Identifiants incorrects"));
          },
        );
      }
    }
  }
}

//create a function to navigate to the home page when the login is successful

// Future<http.Response> fetchAlbum() {
//   return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
// }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      children: const <Widget>[
        Expanded(child: FilledCardStateful()),
      ],
    ),
    Column(
      children: const <Widget>[
        Expanded(child: WorkingTimesStateful()),
      ],
    ),
    Column(
      children: const <Widget>[
        Expanded(child: ParamsStateful()),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Time manager'),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_sharp),
            label: 'ENREGIST.',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'HISTORIQUE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'PARAM.',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
    );
  }
}

class FilledCardStateful extends StatefulWidget {
  const FilledCardStateful({super.key});

  @override
  State<FilledCardStateful> createState() => _FilledCardStatefulState();
}

/// An example of the elevated card type.
///
/// The default settings for [Card] will provide an elevated
/// card matching the spec:
///
/// https://m3.material.io/components/cards/specs#a012d40d-7a5c-4b07-8740-491dec79d58b
class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Elevated Card')),
        ),
      ),
    );
  }
}

/// An example of the filled card type.
///
/// To make a [Card] match the filled type, the default elevation and color
/// need to be changed to the values from the spec:
///
/// https://m3.material.io/components/cards/specs#0f55bf62-edf2-4619-b00d-b9ed462f2c5a
class _FilledCardStatefulState extends State<FilledCardStateful> {
  var _wtresponse;
  var _textDisplay = "Entrée";
  bool _isPointed = false;
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
        if (_wtresponse.last["end"] == null) {
          _isPointed = true;
          _textDisplay = "Sortie";
        } else {
          _isPointed = false;
          _textDisplay = "Entrée";
        }
      });
    } on DioError catch (e) {
      // print status code
      if (e.response != null && e.response?.statusCode == 401) {
        await storage.deleteAll();
        navigateToLogin(context);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
    }
  }

  void updateWorkingTimes(workingTime) async {
    final storage = new FlutterSecureStorage();
    var user = await storage.read(key: 'id');
    var id = workingTime["id"];
    var clock = {"time": DateTime.now().toIso8601String(), "status": false};
    workingTime["end"] = DateTime.now().toIso8601String();
    Dio dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["x-csrf-token"] = await storage.read(key: 'token');
    try {
      print(workingTime["id"]);
      var tmp = await dio.patch(
          'http://localhost:4000/api/workingtimes/' +
              user.toString() +
              '/' +
              id.toString(),
          data: {
            'working_time': {"end": DateTime.now().toIso8601String()}
          });
      await dio.post("http://localhost:4000/api/clocks/" + user.toString(),
          data: {"clock": clock});
      _wtresponse.last = tmp.data["data"];
      setState(() {
        _isPointed = false;
        _textDisplay = "Entrée";
      });
    } on DioError catch (e) {
      // print status code
      print(e);
      if (e.response != null && e.response?.statusCode == 401) {
        await storage.deleteAll();
        navigateToLogin(context);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
    }
  }

  void newWorkingTimes() async {
    final storage = new FlutterSecureStorage();
    var user = await storage.read(key: 'id');
    // create datetime string in YYYY-MM-DDTHH:MM:SS format
    var workingTime = {"start": DateTime.now().toIso8601String()};
    var clock = {"time": DateTime.now().toIso8601String(), "status": true};
    print(user);
    Dio dio = new Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["x-csrf-token"] = await storage.read(key: 'token');
    try {
      var tmp = await dio.post(
          'http://localhost:4000/api/workingtimes/' + user.toString(),
          data: {'working_time': workingTime});
      await dio.post("http://localhost:4000/api/clocks/" + user.toString(),
          data: {"clock": clock});
      _wtresponse.add(tmp.data["data"]);
      setState(() {
        _isPointed = true;
        _textDisplay = "Sortie";
      });
    } on DioError catch (e) {
      // print status code
      if (e.response != null && e.response?.statusCode == 401) {
        await storage.deleteAll();
        navigateToLogin(context);
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
    // getWorkingTimes();
    return Column(children:
        //many widgets
        <Widget>[
      Clock(),
      Container(
          //add a border
          decoration: BoxDecoration(
            border: Border.all(
              color: !_isPointed
                  ? Color.fromRGBO(83, 181, 126, 0.3)
                  : Color.fromRGBO(208, 95, 90, 0.3),
              width: 40,
            ),
            borderRadius: BorderRadius.circular(250),
          ),
          child: Container(
            //add a border
            decoration: BoxDecoration(
              border: Border.all(
                color: !_isPointed
                    ? Color.fromRGBO(83, 181, 126, 0.6)
                    : Color.fromRGBO(208, 95, 90, 0.6),
                width: 20,
              ),
              borderRadius: BorderRadius.circular(250),
            ),
            child: OutlinedButton(
              onPressed: () {
                if (_isPointed) {
                  updateWorkingTimes(_wtresponse.last);
                } else {
                  newWorkingTimes();
                }
                setState(() {
                  _isPointed = !_isPointed;
                  if (_isPointed) {
                    _textDisplay = "Sortie";
                  } else {
                    _textDisplay = "Entrée";
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(24),
                  backgroundColor: !_isPointed
                      ? Color.fromRGBO(83, 181, 126, 1)
                      : Color.fromRGBO(208, 95, 90, 1)),
              child: SizedBox(
                width: 205,
                height: 205,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _textDisplay,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      )
                    ]),
              ),
            ),
          ))
    ]);
  }
}

/// An example of the outlined card type.
///
/// To make a [Card] match the outlined type, the default elevation and shape
/// need to be changed to the values from the spec:
///
/// https://m3.material.io/components/cards/specs#0f55bf62-edf2-4619-b00d-b9ed462f2c5a
class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Outlined Card')),
        ),
      ),
    );
  }
}

class Clock extends StatelessWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 100,
      margin: EdgeInsets.only(top: 50, bottom: 90),
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Center(
              child: Column(children: <Widget>[
            Text(
              "Aujourd'hui . " +
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('hh:mm:ss').format(DateTime.now()),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]));
        },
      ),
    );
  }
}
