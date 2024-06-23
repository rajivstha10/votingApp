import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CandidatesListWidget extends StatelessWidget {
  const CandidatesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('candidates')
          .orderBy('votes', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return ListTile(
                leading: Text((index + 1).toString()),
                title: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(
                            documentSnapshot['logo'],
                          ),
                        ),
                        const Gap(10),
                        Text(documentSnapshot['name']),
                      ],
                    ),
                  ],
                ),
                trailing: Text(documentSnapshot['votes'].toString()),
              );
            },
          );
        } else {
          return const Align(
            alignment: FractionalOffset.bottomCenter,
            child: CircularProgressIndicator(
                // strokeWidth: 20,
                ),
          );
        }
      },
    );
  }
}
