// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:votingapp/cam_vote/cam_name_widget.dart';
import 'package:votingapp/cam_vote/cam_vote_widget.dart';
import 'package:votingapp/core/theme/colors.dart';
import 'package:votingapp/features/candidates_list_widget.dart';
import 'package:votingapp/firebase/database_service.dart';
import 'package:votingapp/widget/label_dropdown_widget.dart';
import 'package:votingapp/widget/label_text_form_field.dart';
import 'package:votingapp/widget/raised_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dbService = DatabaseService();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController candidateNameController = TextEditingController();

  String? selectedCandidate;
  List<String> candidates = [];

  @override
  void dispose() {
    userNameController.dispose();
    candidateNameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    fetchCandidates();

    super.initState();
  }

  Future<void> fetchCandidates() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('candidates').get();
    setState(() {
      candidates = snapshot.docs.map((doc) => doc.id).toList();
    });
    // ignore: avoid_print
    print(candidates);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          leading: const Icon(Icons.how_to_vote_outlined),
          title: const Center(
              child: Text(
            'Voting App',
            style: TextStyle(fontFamily: 'TTMussels'),
          )),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CamNameWidget(),
                    ));
              },
              child: const Icon(Icons.grade_outlined),
            ),
            const Gap(20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                LabelTextFormField(
                    label: 'Username',
                    hintText: 'Enter Username',
                    textEditingController: userNameController,
                    inputType: TextInputType.name,
                    textFieldType: TextFieldType.name),
                const Gap(10),
                LabelDropdownWidget(
                    label: 'Candidate Name',
                    hint: 'Select Candidate',
                    value: selectedCandidate,
                    items: candidates,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCandidate = newValue!;
                      });
                    },
                    isLabelBold: true),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: RaisedButton(
                    onPressed: () async {
                      final userName = userNameController.text.trim();
                      // final candidateName = candidateNameController.text.trim();
                      if (_formKey.currentState!.validate()) {
                        try {
                          await dbService.vote(userName, selectedCandidate!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: successShadeColor,
                                content: Text('Vote Recorded Successfully!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    },
                    color: Colors.deepOrange,
                    label: 'Vote Here',
                    icons: Icons.how_to_vote,
                  ),
                ),
                const Gap(20),
                const Divider(),
                const Text(
                  'Votes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                const CandidatesListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
