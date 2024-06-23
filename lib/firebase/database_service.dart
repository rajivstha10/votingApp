import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final fire = FirebaseFirestore.instance;

  Future<void> vote(String userName, String candidateName) async {
    final userDoc = fire.collection('users').doc(userName);
    final candidateDoc = fire.collection('candidates').doc(candidateName);

    final userSnapshot = await userDoc.get();
    final candidateSnapshot = await candidateDoc.get();

    if (userSnapshot.exists) {
      final user = userSnapshot.data();
      if (user?['hasVoted']) {
        throw Exception('You Have Already Voted!');
      }
    }

    if (candidateSnapshot.exists &&
        candidateSnapshot['name'] == candidateName) {
      await fire.runTransaction((transaction) async {
        if (!userSnapshot.exists) {
          transaction.set(userDoc, {
            'name': userName,
            'hasVoted': true,
          });
        } else {
          transaction.update(userDoc, {'hasVoted': true});
        }
        final newVotes = candidateSnapshot['votes'] + 1;
        transaction.update(candidateDoc, {'votes': newVotes});
      });
    } else {
      throw Exception("Candidate Doesn't Exists");
    }
  }
}
