import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_cli/model/data_model.dart';
import 'package:test_cli/utils/utils.dart';

class DataProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<DataModel> _data = [];

  List<DataModel> get data => _data;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createData(
    String userId,
    DataModel dataModel,
  ) async {
    setLoading(true);

    try {
      await _db
          .collection("user")
          .doc(userId)
          .collection("info")
          .add(dataModel.toJson())
          .then(
        (value) {
          Utils().toastMessage("add data Failed", Colors.red, Colors.white);
        },
      );
      setLoading(false);
    } catch (e) {
      Utils().toastMessage("add data Failed", Colors.red, Colors.white);
      setLoading(false);
    }
  }

  Stream<List<Map<String, dynamic>>> getInfo(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('info')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {'id': doc.id, ...doc.data()};
            }).toList());
  }

  Future<void> getData(String userId) async {
    QuerySnapshot snapshot =
        await _db.collection("user").doc(userId).collection("info").get();
    _data = snapshot.docs.map((doc) {
      return DataModel.fromJson(doc.data() as Map<String, dynamic>, );
    }).toList();

    // _data = snapshot.docs.map((doc) {
    //   return DataModel.fromJson(doc.data() as Map<String, dynamic>,);
    // }).toList();



    notifyListeners();
  }
}
//import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/info_model.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   // Add data to the 'info' subcollection
//   Future<void> addInfo(String userId, InfoModel info) async {
//     await _db.collection('users').doc(userId).collection('info').add(info.toMap());
//   }
//
//   // Retrieve all data as a list of InfoModel from the 'info' subcollection
//   Future<List<InfoModel>> getInfoList(String userId) async {
//     QuerySnapshot snapshot = await _db.collection('users').doc(userId).collection('info').get();
//     return snapshot.docs.map((doc) {
//       return InfoModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//     }).toList();
//   }
//
//   // Stream data as a list of InfoModel
//   Stream<List<InfoModel>> getInfoStream(String userId) {
//     return _db.collection('users').doc(userId).collection('info').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return InfoModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     });
//   }
//
//   // Update a specific document in the 'info' subcollection
//   Future<void> updateInfo(String userId, String docId, InfoModel info) async {
//     await _db.collection('users').doc(userId).collection('info').doc(docId).update(info.toMap());
//   }
//
//   // Delete a specific document in the 'info' subcollection
//   Future<void> deleteInfo(String userId, String docId) async {
//     await _db.collection('users').doc(userId).collection('info').doc(docId).delete();
//   }
// }
