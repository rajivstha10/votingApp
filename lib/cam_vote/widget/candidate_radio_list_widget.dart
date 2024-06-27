import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateRadioListWidget extends StatefulWidget {
  final String documentName;

  final String? selectedCandidate;
  final ValueChanged<String?> onChanged;

  const CandidateRadioListWidget({
    Key? key,
    required this.selectedCandidate,
    required this.onChanged,
    required this.documentName,
  }) : super(key: key);

  @override
  _CandidateRadioListWidgetState createState() =>
      _CandidateRadioListWidgetState();
}

class _CandidateRadioListWidgetState extends State<CandidateRadioListWidget> {
  List<Map<String, dynamic>> candidates = [];

  @override
  void initState() {
    super.initState();
    fetchCandidates();
  }

  Future<void> fetchCandidates() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('category')
        .doc(widget.documentName)
        .get();
    setState(() {
      candidates = List<Map<String, dynamic>>.from(snapshot['candidates']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return candidates.isEmpty
        ? const CircularProgressIndicator()
        : SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: candidates.map((candidate) {
                return RadioListTile<String>(
                  title: Text(candidate['name']),
                  value: candidate['name'],
                  groupValue: widget.selectedCandidate,
                  onChanged: widget.onChanged,
                  activeColor: Colors.blue,
                );
              }).toList(),
            ),
          );
  }
}
