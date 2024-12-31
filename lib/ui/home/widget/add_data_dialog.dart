import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_cli/model/data_model.dart';
import 'package:test_cli/provider/data_provider.dart';

import '../../../widget/button.dart';

class AddDataDialog extends StatefulWidget {
  const AddDataDialog({super.key, required this.uid});

  final String uid;

  @override
  State<AddDataDialog> createState() => _AddDataDialogState();
}

class _AddDataDialogState extends State<AddDataDialog> {
  final _name = TextEditingController();

  final _email = TextEditingController();

  final _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return AlertDialog(
      title: const Text('Add Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _name,
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return "Enter Name";
              }
              return null;
            },
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                labelText: "Enter Name",
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return "Enter Email";
              }
              return null;
            },
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                labelText: "Enter Email",
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _address,
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return "Enter Address";
              }
              return null;
            },
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                labelText: "Enter Address",
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
        ],
      ),
      actions: [
        Row(
          children: <Widget>[
            Expanded(
              child: ButtonWidget(
                buttonText: "Cancel",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: dataProvider.isLoading?Center(child: CircularProgressIndicator(),): ButtonWidget(
                buttonText: "Add",
                onTap: () async {
                  dataProvider.createData(
                      widget.uid,
                      DataModel(
                        email: _email.text,
                        address: _address.text,
                        name: _name.text,
                      )).then((value) {
                        _address.clear();
                        _name.clear();
                        _email.clear();
                        Navigator.pop(context);
                      },);

                },
              ),
            ),
          ],
        ),
      ],
    );
    ;
  }
}
