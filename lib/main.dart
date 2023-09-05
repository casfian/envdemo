import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bcrypt/flutter_bcrypt.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String myfoo = dotenv.get('FOO');

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print(myfoo);
  }

  Future login(String myusername, String mypassword) async {
    //code dotenv.get('FOO');
    var url = Uri.parse('https://www.example.com/apilogin');
    var hashpassword = await FlutterBcrypt.hashPw(
        password: mypassword, salt: r'$2b$06$C6UzMDM.H6dfI/f/IKxGhu');
    var response = await http.post(url,
        body: {'key': myfoo, 'usrname': myusername, 'password': hashpassword});
    if (response.statusCode == 200) {
      print('Success login');
      //can goto success page
    } else {
      print('Failed');
      //goto failed page or Alert
    }
    //code
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(dotenv.get('FOO')),
              TextFormField(
                controller: usernameController,
              ),
              TextFormField(
                controller: passwordController,
              ),
              ElevatedButton(
                  onPressed: () {
                    login(
                        usernameController.text,
                        passwordController.text);
                  },
                  child: const Text('Login sini'))
            ],
          ),
        ),
      ),
    );
  }
}
