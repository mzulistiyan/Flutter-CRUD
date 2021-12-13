import 'package:flutter/material.dart';
import 'package:flutter_http_request_simple/services/services_user.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  UserService userService = UserService();
  final _nameController = TextEditingController();

  postdata() async {
    bool response = await userService.postData(_nameController.text);
    if (response) {
      Navigator.of(context).popAndPushNamed('/home');
    } else {
      print('Post Gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[0].isNotEmpty) {
      _nameController.text = args[0];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Users'),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Name',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Color(0xffE4E5E7),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Color(0xffE4E5E7),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                postdata();
              },
              child: const Text('submit'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await userService.putData(
                    int.parse(args[1]), _nameController.text);
                if (response) {
                  Navigator.of(context).popAndPushNamed('/home');
                } else {
                  print('Post Gagal');
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
