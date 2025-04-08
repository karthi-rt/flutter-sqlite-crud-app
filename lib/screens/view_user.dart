import 'package:flutter/material.dart';
import 'package:sqlite_crud_operation/model/user.dart';

class ViewUser extends StatefulWidget {
  final User user;

  const ViewUser({super.key, required this.user});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View User")),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Details",
              style: TextStyle(
                fontSize: 20, color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20,),

            // Name
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    'Name: ',
                    style: TextStyle(
                      color: Colors.blueGrey, fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.user.name ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),

            // Contact
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    'Contact: ',
                    style: TextStyle(
                      color: Colors.blueGrey, fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.user.contact ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),

            // Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: const Text(
                    'Description: ',
                    style: TextStyle(
                      color: Colors.blueGrey, fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(
                    widget.user.description ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
