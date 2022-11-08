import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
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
        '/home': (context) => const MyStatefulWidget(),
      },
      home: const LoginPageStateful(),
    );
  }
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
    return Material(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
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
              labelText: 'Email',
            ),
          ),
          TextFormField(
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
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Login'),
          ),
        ],
      ),
    ));
  }

  Future _submit() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      try {
        var response = await Dio().post('http://localhost:4000/api/users/login',
            data: {'email': _email, 'password': _password});
        navigateToHome(context);
      } catch (e) {
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
void navigateToHome(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
}

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
    const Text(
      'Business',
      style: optionStyle,
    ),
    const Text(
      'School',
      style: optionStyle,
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
      ),
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
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
  bool _isPointed = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _isPointed = !_isPointed;
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                _isPointed ? Colors.green : Colors.red)),
        child: SizedBox(
          width: 300,
          height: 100,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colors.black,
                ),
                Text(
                  'Entrée',
                  style: TextStyle(color: Colors.black, fontSize: 40),
                )
              ]),
        ),
      ),
    );
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
