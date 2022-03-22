
import 'package:cloud_firestore/cloud_firestore.dart';

class RunDataModel{
  String id;
  String title;
  double distance;
  DateTime dateCreated;
  DateTime startDate;
  DateTime endDate;

  RunDataModel(String id, Map<String, dynamic> data){
    this.id = id;
    this.title = data['title'] ?? "";
    this.distance = data['distance'] ?? 0.0;

    if (data['dateCreated'] is DateTime) {
      this.dateCreated = data['dateCreated'];
    } else {
      if ((data['dateCreated'] as Timestamp) != null) {
        this.dateCreated = (data['dateCreated'] as Timestamp).toDate();
      }
    }

    if (data['startDate'] is DateTime) {
      this.startDate = data['startDate'];
    } else {
      if ((data['startDate'] as Timestamp) != null) {
        this.startDate = (data['startDate'] as Timestamp).toDate();
      }
    }

    if (data['endDate'] is DateTime) {
      this.endDate = data['endDate'];
    } else {
      if ((data['endDate'] as Timestamp) != null) {
        this.endDate = (data['endDate'] as Timestamp).toDate();
      }
    }
  }

  Map<String,dynamic> updateRunData(){
    return {
      "title" : this.title,
      "distance" : this.distance,
      "startDate" : this.startDate,
      "endDate" : this.endDate,
      "dateCreated" : this.dateCreated,
    };
  }




}