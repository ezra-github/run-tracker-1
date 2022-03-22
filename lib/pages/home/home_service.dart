import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:run_keeper/model/run_data.dart';
import 'package:uuid/uuid.dart';

class HomeService{
  var db = FirebaseFirestore.instance;

  Future<dynamic> addRunData(String uid,data) async {
    try {
      String uuid = Uuid().v4();
      await db.collection("Users").doc(uid).collection("RunData").doc(uuid).set(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> updateRunData(String uid, String uuid,data) async {
    try {
      await db.collection("Users").doc(uid).collection("RunData").doc(uuid).update(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> deleteRunData(String uid, String uuid) async{
    try {
      await db.collection("Users").doc(uid).collection("RunData").doc(uuid).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<RunDataModel>> runDataStream(String uid){
    return db.collection("Users").doc(uid).collection("RunData").orderBy("dateCreated", descending: true).snapshots().map((QuerySnapshot query) {
      List<RunDataModel> retVal = [];
      query.docs.forEach((element) {
        RunDataModel runDataModel = RunDataModel(element.id, element.data());
        retVal.add(runDataModel);
      });
      return retVal;
    });
  }

  Future<List<RunDataModel>> getRunList(String uid) async {
    QuerySnapshot querySnapshot = await db.collection("Users").doc(uid).collection("RunData").orderBy("dateCreated", descending: true).get();
    List<RunDataModel> runDataList = [];
    querySnapshot.docs.forEach((element) {
      RunDataModel runDataModel = RunDataModel(element.id, element.data());
      runDataList.add(runDataModel);
    });

    return runDataList;
  }

}