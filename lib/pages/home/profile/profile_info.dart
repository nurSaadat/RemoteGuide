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
                Expanded(
                  flex: 1,
                  child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Name:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Email:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text("Status:",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ),
                Expanded(
                  flex: 3,
                  child:
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.data.get('name'),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Text(widget.data.get('email'),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(top: 10.0),
                            ),
                            Text(widget.data.get('guide') ? "Guide" : "Client",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        )
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