import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:zoom_clone/variables.dart';

class ProfielScreen extends StatefulWidget {
  const ProfielScreen({super.key});

  @override
  State<ProfielScreen> createState() => _ProfielScreenState();
}

class _ProfielScreenState extends State<ProfielScreen> {
  String username = "";
  bool dataishere = false;
  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    // DocumentSnapshot userdoc =
    //     await usercollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    var userdoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = userdoc.data()!['username'];
      dataishere = true;
    });
  }

  openEditProfileDialoge() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: usernameController,
                      style: mystyle(
                        18,
                        Colors.black,
                      ),
                      decoration: InputDecoration(
                        label: const Text("Update Username"),
                        labelStyle: mystyle(16, Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () => editProfie(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.cherry),
                      ),
                      child: Center(
                        child: Text(
                          "Update Now",
                          style: mystyle(17, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  editProfie() async {
    usercollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'username': usernameController.text,
    });
    setState(() {
      username = usernameController.text;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataishere == false
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 64,
                    top: MediaQuery.of(context).size.height / 3.1,
                  ),
                  child: const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png"),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 300),
                      Text(
                        username,
                        style: mystyle(
                          40,
                          Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () => openEditProfileDialoge(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: const BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.cherry),
                          ),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: mystyle(17, Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
