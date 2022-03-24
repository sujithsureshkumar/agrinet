import 'package:flutter/cupertino.dart';

class ProfileData extends ChangeNotifier{
  List<bool> _setProfile=[false, false, false];

  List<bool> get getProfile => _setProfile;

  void setProfile(int index){
    _setProfile[index] =!_setProfile[index];
    notifyListeners();
  }



}