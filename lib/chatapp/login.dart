import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "data"
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "data"
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    child: Center(
                      child: Text("LOGIN"),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
