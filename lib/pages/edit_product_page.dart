import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  EditProductPage({Key? key}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit item'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Title'),
                ),
                textInputAction: TextInputAction.next,
              )
            ],
          )),
        ),
      ),
    );
  }
}
