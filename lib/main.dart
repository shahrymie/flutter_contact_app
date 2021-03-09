import 'package:flutter/material.dart';
import 'package:flutter_contact_app/screens/contact_screen.dart';
import 'package:flutter_contact_app/viewmodels/contact_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ContactViewModel viewModel = ContactViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.generateRandomContact();
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => viewModel, child: ContactScreen()),
    );
  }
}
