import 'package:audio/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>> getUser() async {
    final request =
        await http.get("https://jsonplaceholder.typicode.com/users");
    return userFromJson(request.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Text(users[index].name);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
