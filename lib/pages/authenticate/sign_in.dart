import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/services/auth.dart';
import 'package:remote_guide_firebase/shared/constants.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0.0,
        title: const Text('Login'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person_add),
            label: const Text('Register'),
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
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    // hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  // hintText: 'Enter your password',
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(24.0))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          loading = false;
                        });
                      }
                    }
                  },
                  child: const Text('Sign in')),
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
