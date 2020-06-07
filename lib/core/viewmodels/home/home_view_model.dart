import '../base_model.dart';

class HomeViewModel extends BaseModel {
  int _index = 0;

  int get index => _index;

  void changeTab(value){
    _index = value;
    notifyListeners();
  }
}
