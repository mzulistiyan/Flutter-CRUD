import 'package:flutter/material.dart';
import 'package:flutter_http_request_simple/add_user_page.dart';
import 'package:flutter_http_request_simple/model/model_user.dart';
import 'package:flutter_http_request_simple/services/services_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/add-user': (context) => const AddUserPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UsersModel> listuser = [];

  UserService userService = UserService();

  getData() async {
    listuser = await userService.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/add-user');
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).popAndPushNamed(
                      '/add-user',
                      arguments: [
                        listuser[index].name,
                        listuser[index].id,
                      ],
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listuser[index].id),
                          Text(
                            listuser[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        bool response =
                            await userService.deleteData(listuser[index].id);
                        if (response) {
                          print('Delete Data berhasil');
                          CircularProgressIndicator();
                        } else {
                          print('Delete Data gagal');
                        }
                        getData();
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listuser.length),
    );
  }
}
