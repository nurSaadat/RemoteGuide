import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_guide_firebase/pages/authenticate/authenticate.dart';
import 'home/home.dart';
import 'models/myuser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
