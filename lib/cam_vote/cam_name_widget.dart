import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:votingapp/cam_vote/cam_vote_widget.dart';
import 'package:votingapp/core/theme/colors.dart';
import 'package:votingapp/widget/label_text_form_field.dart';
import 'package:votingapp/widget/raised_button.dart';

class CamNameWidget extends StatefulWidget {
  const CamNameWidget({super.key});

  @override
  State<CamNameWidget> createState() => _CamNameWidgetState();
}

final TextEditingController nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _CamNameWidgetState extends State<CamNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left)),
          title: Center(child: Text('Enter Name to Continue')),
          actions: [Gap(40)],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              LabelTextFormField(
                  label: 'Name',
                  textEditingController: nameController,
                  hintText: 'Enter your name',
                  inputType: TextInputType.name,
                  textFieldType: TextFieldType.name),
              const Gap(20),
              RaisedButton(
                  onPressed: () {
                    final userName = nameController.text.trim();
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CamVoteWidget(
                            name: userName,
                          ),
                        ),
                      );
                    }
                  },
                  color: primaryColor,
                  label: 'Next')
            ],
          ),
        ),
      ),
    );
  }
}
