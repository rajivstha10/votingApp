// ignore_for_file: public_member_api_docs, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:votingapp/cam_vote/widget/candidate_radio_list_widget.dart';
import 'package:votingapp/core/extensions/app_theme_extensions.dart';
import 'package:votingapp/core/theme/colors.dart';
import 'package:votingapp/firebase/cam_db_service.dart';
import 'package:votingapp/widget/raised_button.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({
    required this.documentName,
    this.label = '',
    required this.name,
  });
  final String documentName;
  final String label;
  final String name;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String? selectedCandidate;
  final camDbService = CamDbService();
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Gap(10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
          const Divider(),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              textAlign: TextAlign.center,
              widget.label,
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
            ),
          ),
          const Gap(10),
          Expanded(
            child: CandidateRadioListWidget(
              documentName: widget.documentName,
              selectedCandidate: selectedCandidate,
              onChanged: (value) {
                setState(() {
                  selectedCandidate = value!;
                });
              },
            ),
          ),
          const Gap(20),
          RaisedButton(
              onPressed: () async {
                if (selectedCandidate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a candidate to vote.'),
                    ),
                  );
                  Navigator.pop(context);

                  return;
                }

                try {
                  await camDbService.vote(
                      widget.name, selectedCandidate!, widget.documentName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: successShadeColor,
                        content: Text('Vote Recorded Successfully!')),
                  );
                  Navigator.pop(context, true);
                } catch (e) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                  throw Exception(e);
                }
              },
              color: primaryColor,
              label: 'Vote'),
        ],
      ),
    );
  }
}
