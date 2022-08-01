// import 'dart:js';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:test_crud/userdashboard.dart';
import '../main.dart';

class FirebaseAuthMethod {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final userDoc = snapshot.data;
          return UserDashboard();
        } else {
          return const HomeScreen();
        }
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<drive.DriveApi> getDriveApi() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>[
      "email",
      "https://www.googleapis.com/auth/drive",
      "https://www.googleapis.com/auth/drive.file"
    ]).signIn();
    final headers = await googleUser?.authHeaders;

    final client = GoogleAuthClient(headers!);
    // final client = googleUser?.GoogleAuthClient(headers);
    final driveApi = drive.DriveApi(client);
    return driveApi;
  }

  Future<void> uploadToHidden() async {
    // try {
    //   final driveApi = await _getDriveApi();
    //   if (driveApi == null) {
    //     return;
    //   }
    //   // Not allow a user to do something else
    //   showGeneralDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     transitionDuration: Duration(seconds: 2),
    //     barrierColor: Colors.black.withOpacity(0.5),
    //     pageBuilder: (context, animation, secondaryAnimation) => Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // } finally {
    //   // Remove a dialog
    //   Navigator.pop(context);
    // }

// Create data here instead of loading a file
    const contents = "Technical Feeder";
    final Stream<List<int>> mediaStream =
        Future.value(contents.codeUnits).asStream().asBroadcastStream();
    var media = drive.Media(mediaStream, contents.length);

// Set up File info
    var driveFile = drive.File();
    final timestamp = DateTime.now();
    driveFile.name = "technical-feeder-$timestamp.txt";
    driveFile.modifiedTime = DateTime.now().toUtc();
    driveFile.parents = ["appDataFolder"];
    final driveApi = await getDriveApi();
    final response = await driveApi.files.create(driveFile, uploadMedia: media);
  }

  Future<String?> getFolderId(drive.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "Flutter-sample-by-tf";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      final files = found.files;
      if (files == null) {
        print("Sign in First");
        return null;
      }

      // The folder already exists
      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      var folder = drive.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      print("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> uploadToNormal(
      BuildContext context, PlatformFile pickedFile) async {
    try {
      final driveApi = await getDriveApi();
      print(driveApi);
      // Check if the folder exists. If it doesn't exist, create it and return the ID.
      final folderId = await getFolderId(driveApi);
      if (folderId == null) {
        print("null");
        return;
      }

      // // Create data here instead of loading a file
      // const contents = "Technical Feeder";
      // final Stream<List<int>> mediaStream =
      //     Future.value(contents.codeUnits).asStream().asBroadcastStream();
      // var media = drive.Media(mediaStream, contents.length);

      // Set up File info
      var driveFile = drive.File();
      final timestamp = DateTime.now();
      driveFile.name = pickedFile.name;
      print(driveFile.name);
      driveFile.modifiedTime = DateTime.now().toUtc();

      // !!!!!! Set the folder ID here !!!!!!!!!!!!
      driveFile.parents = [folderId];
      File file = File(pickedFile.path ?? '');
      print(file.path);
      // Upload
      final response = await driveApi.files.create(driveFile,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()));
      print("response: $response");

      // simulate a slow process
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      // Remove a dialog
      
      return Navigator.pop(context);
    }
  }


}


class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

final googleSignIn = GoogleSignIn.standard(scopes: [
  drive.DriveApi.driveAppdataScope,
]);
