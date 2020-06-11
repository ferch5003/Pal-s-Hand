import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../base_model.dart';

class WaitingViewModel extends BaseModel {
  
  deliveryReady() async {
    try {
      print('hola');

      FirebaseUser authUser = await FirebaseAuth.instance.currentUser();
      
      await DatabaseService(uid: authUser.uid).deliverReady();
    } catch (e) {
    }
  }
}