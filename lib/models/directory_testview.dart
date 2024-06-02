import 'package:flutter/material.dart';
import 'package:jongsul/models/library/library_data.dart';
import 'package:jongsul/models/library/library.dart';
import 'package:jongsul/models/directory/directory.dart';
import 'package:jongsul/models/directory/directory_data.dart';


class DirectoryTestView extends StatefulWidget {
  Library library;
  DirectoryTestView({
    required this.library,
    super.key
  });


  @override
  State<DirectoryTestView> createState() => _DirectoryTestViewState();
}

class _DirectoryTestViewState extends State<DirectoryTestView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
