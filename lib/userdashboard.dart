import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:test_crud/service/firebase_service.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  PlatformFile? pickedFile;
  FilePickerResult? result;
  Future selectFile(context) async {
    result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile = result!.files.first;
      // print(pickedFile!.name);
    } else {
      print("not uploaded");
    }
  }

  Future<void> listGoogleDriveFiles() async {
    final driveApi = await FirebaseAuthMethod().getDriveApi();
    final folderId = await FirebaseAuthMethod().getFolderId(driveApi);
    var list;
    driveApi.files.list(spaces: folderId).then((value) {
      setState(() {
        list = value;
      });
      for (var i = 0; i < list.files.length; i++) {
        print("Id: ${list.files[i].id} File Name:${list.files[i].name}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          children: [
            Text("UserDashboard"),
            ElevatedButton(
              onPressed: () async {
                await selectFile(context);
                if (pickedFile != null) {
                  // ignore: use_build_context_synchronously
                  FirebaseAuthMethod().uploadToNormal(context, pickedFile!);
                  print(pickedFile);
                }

                // Navigator.pop(context);
              },
              child: Text('Upload File'),
            ),
            ElevatedButton(
              onPressed: () async {
                await listGoogleDriveFiles();

                // Navigator.pop(context);
              },
              child: Text('File list'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuthMethod().logOut();
              },
              child: Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
