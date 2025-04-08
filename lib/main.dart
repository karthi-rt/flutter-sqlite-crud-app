import 'package:flutter/material.dart';
import 'package:sqlite_crud_operation/model/user.dart';
import 'package:sqlite_crud_operation/screens/add_user.dart';
import 'package:sqlite_crud_operation/screens/edit_user.dart';
import 'package:sqlite_crud_operation/screens/view_user.dart';
import 'package:sqlite_crud_operation/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _userList = [];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();

    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];

        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text("Are you Sure to Delete?",
          style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                var result = await _userService.deleteUser(userId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllUserDetails();
                  _showSuccessSnackBar(
                    "User Detail Deleted Successfully",
                  );
                }
              },
              child: const Text("Delete"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite CRUD")),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUser(user: _userList[index]),
                  ),
                );
              },
              leading: const Icon(Icons.person),
              title: Text(_userList[index].name ?? ''),
              subtitle: Text(_userList[index].contact ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EditUser(user: _userList[index]),
                        ),
                      ).then((data) {
                        if (data != null) {
                          getAllUserDetails();
                          _showSuccessSnackBar(
                            "User Detail Updated Successfully",
                          );
                        }
                      });
                      ;
                    },
                    icon: const Icon(Icons.edit, color: Colors.teal),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteFormDialog(context, _userList[index].id);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUser()),
          ).then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar("User Detail Added Successfully");
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
