

import 'package:cloud_firestore/cloud_firestore.dart';

class FetchAnouncements {
  getAnouncement(DateTime date) {
     Firestore.instance
        .collection('days')
        .where('date', isEqualTo: date.toString())
        .getDocuments();
  }
}
