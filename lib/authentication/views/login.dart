import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get.dart';
import 'package:super_restaurants/authentication/views/register.dart';
import 'package:super_restaurants/home/restaurants/restaurants.dart';

import '../controllers/login-controller.dart';
import '../validators/validate-login.dart';




class ClientLogin extends StatelessWidget {
  const ClientLogin({Key? key}) : super(key: key);
  static const String _title = 'AdoptMe App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
          primarySwatch:Colors.deepOrange
      ),
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init:LoginController(),
        builder: (_){
          return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Restaurants',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: const Text(' ',),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        _.iniciarSesion( usernameController.text, passwordController.text);

                        void func() async{
                          bool validate = await Modelo.iniciarSesion(usernameController.text, passwordController.text);
                          if(validate==true)
                          {
                          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (BuildContext context) => Restaurants()),
                            ModalRoute.withName('/'),
                          );}
                        }
                        func();
                      },
                    ),
                  ),
                  SizedBox(height: 0),
                  Text(_.message,
                    style: TextStyle(
                      color: Colors.orange,
                    ),),

                  Row(
                    children: <Widget>[
                      const Text('Do not have an account?'),
                      TextButton(
                        child: const Text(
                          'Create account',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPageClient()));

                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ));
        }
    );
  }
}