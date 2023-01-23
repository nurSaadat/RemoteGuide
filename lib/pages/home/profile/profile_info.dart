import 'package:flutter/material.dart';
import 'package:remote_guide_firebase/pages/home/profile/profile_image.dart';

class ProfileInfo extends StatefulWidget {
  final data;
  const ProfileInfo(this.data, {super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ProfileImage(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Name"),
                    Text("Email"),
                    Text("Status"),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Text(widget.data.get('name')),
                        Text(widget.data.get('email')),
                        Text(widget.data.get('guide') ? "Guide" : "Client"),
                      ],
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}