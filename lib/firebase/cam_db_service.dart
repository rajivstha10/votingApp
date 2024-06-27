import 'package:cloud_firestore/cloud_firestore.dart';

class CamDbService {
  final fire = FirebaseFirestore.instance;
  Future<void> vote(
      String userName, String candidateName, String documentName) async {
    final docRef =
        FirebaseFirestore.instance.collection('category').doc(documentName);

    final docSnapshot = await docRef.get();
    if (!docSnapshot.exists) {
      throw Exception("Document Doesn't Exist");
    }

    final userDoc = List<Map<String, dynamic>>.from(docSnapshot['user']);

    final candidateDoc =
        List<Map<String, dynamic>>.from(docSnapshot['candidates']);

//check if the user has already voted
    // final user = userDoc.firstWhere(
    //   (user) => user['name'] == userName,
    //   orElse:()=>null
    // );
    // if (user != null && user['hasVoted']) {
    //   throw Exception('You Have Already Voted!');
    // }
    bool hasVoted = false;
    for (var user in userDoc) {
      if (user['name'] == userName) {
        if (user['hasVoted']) {
          throw Exception('You Have Already Voted!');
        }
        hasVoted = true;
        break;
      }
    }

//check if candidate exists or not

    final candidateIndex = candidateDoc
        .indexWhere((candidate) => candidate['name'] == candidateName);
    if (candidateIndex == -1) {
      throw Exception("Candidate Doesn't Exist");
    }

    await fire.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(docRef);

      final freshUserDocs =
          List<Map<String, dynamic>>.from(freshSnapshot['user']);
      final freshCandidateDocs =
          List<Map<String, dynamic>>.from(freshSnapshot['candidates']);

      // Update the user's vote status
      // if (user['name'] != userName) {
      //   freshUserDocs.add({'name': userName, 'hasVoted': true});
      // } else {
      //   final userIndex =
      //       freshUserDocs.indexWhere((user) => user['name'] == userName);
      //   freshUserDocs[userIndex]['hasVoted'] = true;
      // }
      bool userFound = false;
      for (var user in freshUserDocs) {
        if (user['name'] == userName) {
          user['hasVoted'] = true;
          userFound = true;
          break;
        }
      }

      if (!userFound) {
        freshUserDocs.add({'name': userName, 'hasVoted': true});
      }
      // Increment the candidate's vote count
      freshCandidateDocs[candidateIndex]['vote'] += 1;

      // Update the Firestore document
      transaction.update(docRef, {
        'user': freshUserDocs,
        'candidates': freshCandidateDocs,
      });
    });
  }
}
