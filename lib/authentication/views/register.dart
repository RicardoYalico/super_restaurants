import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_restaurants/authentication/views/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RegisterPageClient extends StatefulWidget {
  RegisterPageClient({Key? key}) : super(key: key);

  @override
  _RegisterPageClientState createState() => _RegisterPageClientState();
}
class _RegisterPageClientState extends State<RegisterPageClient> {
  final storage = const FlutterSecureStorage();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  final url = Uri.parse("https://probable-knowledgeable-zoo.glitch.me/users");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  String? claveError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "Restaurants",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 50, color: Theme.of(context).primaryColor),
                ),
                const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: firstName,
                    decoration: const InputDecoration(
                        hintText: "First name", border: InputBorder.none),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: lastName,
                    decoration: const InputDecoration(
                        hintText: "Last Name", border: InputBorder.none),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: username,
                    decoration: const InputDecoration(
                        hintText: "Username", border: InputBorder.none),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: claveError,
                        hintText: "Password",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 30),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).textTheme.subtitle1!.color),
                  child: Wrap(
                    //ItemsScreen
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                    ],
                  ),



                ),

                ElevatedButton(

                    onPressed: () {
                      if(firstName.text!=""&&
                          password.text!=""&&
                          lastName.text!=""&&
                          username.text!="") {
                        register();
                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => ClientLogin()));
                      }
                    },

                    child: const Text("Sign up")),
              ],
            ),
          ),
        )
    );
  }

  Future<void> register() async {

    setState(() {
      claveError = null;
    });

    final user = {
      "username": username.text,
      "last_name": lastName.text,
      "first_name": firstName.text,
      "password": password.text,
    };
    final res = await http.post(url, headers: headers, body: jsonEncode(user));

    print(res.body);
    if (res.statusCode == 401) {
      final data = Map.from((jsonDecode(res.body)));
      showSnackBar(data["error"]);
      return;
    }

    if (res.statusCode != 200) {
      showSnackBar("Ups Error!");
      return;
    }
    Navigator.of(context).pushNamed('restaurants');
  }

  void showSnackBar(String msg) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
