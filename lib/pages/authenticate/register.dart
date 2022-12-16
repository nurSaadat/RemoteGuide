import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  bool guide = false;
  String email = '';
  String username = '';
  String name = '';
  String password = '';
  String repeatedPassword = '';
  String error = '';

  @override

  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 0.0,
          title: Text('Registration'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign in'),
              onPressed: () {
                widget.toggleView();
              },
              style: TextButton.styleFrom(
                  primary: Colors.white
              ),
            )
          ],
        ),
        body: Container (
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter the username' : null,
                      onChanged: (val) {
                        setState(() => username = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Full name',
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter the name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Repeat password',
                      ),
                      obscureText: true,
                      validator: (val) => val != password ? 'Passwords do not match' : null,
                      onChanged: (val) {
                        setState(() => repeatedPassword = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SwitchListTile(
                      title: const Text('I want to be a guide'),
                      value: guide,
                      onChanged: (bool value) {
                        setState(() {
                          guide = value;
                        });
                      },
                  ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        child: const Text('Sign up'),
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white)),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(24.0)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password, guide, name);
                            if(result == null){
                              setState(() {
                                error = 'You are entering not valid credentials';
                                loading = false;
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                )
            )
        )
    );
  }
}
