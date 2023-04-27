import 'package:flutter/material.dart';
import 'package:easy_form_kit/easy_form_kit.dart';

class AddData2 extends StatefulWidget {
  const AddData2({super.key, required this.title});

  final String title;

  @override
  State<AddData2> createState() => _AddData2State();
}

class _AddData2State extends State<AddData2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [MyCustomForm()],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final List<String> textFieldsValue = [];
  // final _formKey = GlobalKey<FormState>();

  sendToArd(data) {
    var data1 = data;
    data1['n'] = 2;
  }

  @override
  Widget build(BuildContext context) {
    return EasyForm(
      onSave: (values, form) async {},
      onSaved: (response, values, form) {
        sendToArd(values);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          EasyTextFormField(
            name: 'Name',
            decoration: const InputDecoration(
              icon: Icon(Icons.square),
              hintText: 'Name of the Medicine',
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 16.0),
          EasyTextFormField(
            name: 'Decription',
            decoration: const InputDecoration(
              icon: Icon(Icons.text_format),
              hintText: 'Number of Doses',
              labelText: 'Decription',
            ),
          ),
          EasyTextFormField(
            name: 'Time',
            decoration: const InputDecoration(
              icon: Icon(Icons.timelapse),
              hintText: 'Time of Intake',
              labelText: 'TIme',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: EasyFormSaveButton.text('Submit'),
          ),
        ],
      ),
    );
  }
}
