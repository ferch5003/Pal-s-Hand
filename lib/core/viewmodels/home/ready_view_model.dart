import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/services/database_service.dart';
import 'package:pals_hand/core/viewmodels/base_model.dart';

class ReadyViewModel extends BaseModel {
  
  deliveryFinished() async {
    try {
      print('hola');
      FirebaseUser authUser = await FirebaseAuth.instance.currentUser();
      
      await DatabaseService(uid: authUser.uid).deliverFinished();
      
    } catch (e) {
    }
  }
}