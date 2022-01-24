import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:etransact_vendor/model/sidebar.dart';
import 'package:etransact_vendor/api/firebase_api.dart';
import 'package:etransact_vendor/widget/button_widget.dart';
import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = 'eTransact';
  final String subTitle = 'Vendor';

  UploadTask? task;
  Uint8List? file;
  String? fileName;
  late String userEmail;
  late String userDirectory;
  late String displayedText;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    displayedText = (file != null ? fileName : 'No File Selected')!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.home_rounded),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            const SizedBox(width: 4),
            Text(
              subTitle,
              style: const TextStyle(color: Colors.white38),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 500.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(
                      text: 'Select File',
                      icon: Icons.attach_file,
                      onClicked: selectFile,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      displayedText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 48),
                    TextFormField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        userEmail = value;
                        userDirectory = userEmail + '/';
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter customer email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter an Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 48),
                    ButtonWidget(
                      text: 'Upload File',
                      icon: Icons.cloud_upload_outlined,
                      onClicked: () {
                        if (_formKey.currentState!.validate()) {
                          uploadFile();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    task != null ? buildUploadStatus(task!) : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      endDrawer: NavigateDrawer(uid: widget.uid),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final fileBytes = result.files.single.bytes!;

    setState(() {
      file = fileBytes;
      fileName = result.files.single.name;
    });
  }

  Future uploadFile() async {
    if (file == null) {
      kShowToast('Please select a file!');
      return;
    }

    final destination = '$userDirectory/$fileName';

    task = FirebaseApi.uploadBytes(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // ignore: avoid_print
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
