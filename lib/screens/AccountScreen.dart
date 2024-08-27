import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'LoginScreen.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  bool status = false;
  String groupValue = "arbic";

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Row(
              children: [
                CircleAvatar(
                  radius: 50,

                  backgroundImage: AssetImage(
                      "assets/images/amr.jpg"), // Update with your image path
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'John Doe',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      const Text('johndoe@example.com'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.settings),
              ],
            ),
            const SizedBox(height: 24.0),
            _buildSection(context, 'Orders', [
              _buildListTile(context, 'Order #12345', 'Completed'),
              _buildListTile(context, 'Order #12346', 'Shipped'),
            ]),
            const Divider(thickness: 1.0),
            const SizedBox(height: 16.0),
            _buildSection(context, 'Shipping Address', [
              _buildListTile(context, 'John Doe',
                  '123 Main Street, Apt 4B, Cityville, ST 12345, Country'),
            ]),
            const Divider(thickness: 1.0),
            const SizedBox(height: 16.0),
            _buildSection(context, 'Payment Methods', [
              _buildListTile(context, 'Visa **** 1234', '',
                  fontWeight: FontWeight.normal),
              _buildListTile(context, 'MasterCard **** 5678', '',
                  fontWeight: FontWeight.normal),
            ]),
            const Divider(thickness: 1.0),
            const SizedBox(height: 16.0),
            _buildSection(context, 'Settings', [
              _buildListTile(context, 'Change Password', '',
                  fontWeight: FontWeight.normal),
              _buildListTile(
                context,
                'Log Out',
                '',
                fontWeight: FontWeight.normal,
                onTap: () async {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Tapped on Logout')));
                  await FirebaseAuth.instance.signOut(); // Log out the user
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  ); // Navigate to the login screen
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Theme",
                    style: TextStyle(fontSize: 16),
                  ),
                  FlutterSwitch(
                    value: status,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                    showOnOff: true,
                    activeColor: Colors.blueAccent,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "language",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("arbic"),
                          Radio(
                            value: "arbic",
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value!;
                              });
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("english"),
                          Radio(
                            value: "english",
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() => groupValue = value!);
                            },
                          )
                        ],
                      ),
                    ],
                  )
                ],
              )
            ]),
            const Divider(thickness: 1.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ...items,
      ],
    );
  }

  Widget _buildListTile(BuildContext context, String title, String subtitle,
      {FontWeight fontWeight = FontWeight.bold, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(fontWeight: fontWeight),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Tapped on $title')));
          },
    );
  }
}
