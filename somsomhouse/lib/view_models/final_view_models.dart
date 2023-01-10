import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { registerSuccess, registerFail, loginSuccess, loginFail }

class FinalViewModel extends ChangeNotifier {
  LatLng currentLocation = const LatLng(37.570789, 126.916165);
  String apartName = "";
  String guName = "";
  String dongName = '';
  double zoomLevel = 17;

  changeApartName(String name) {
    apartName = name;
    notifyListeners();
  }

  changeGuName(String gu) {
    guName = gu;
    notifyListeners();
  }

  changeDongName(String dong) {
    dongName = dong;
    notifyListeners();
  }

  changeZoomLevel(double zoomLevel) {
    this.zoomLevel = zoomLevel;
    ChangeNotifier();
  }

  changeCurrentLocation(LatLng location) {
    currentLocation = location;
    ChangeNotifier();
  }

  /// model_auth
  FirebaseAuth authClient;
  User? user;

  FinalViewModel({auth}) : authClient = auth ?? FirebaseAuth.instance;

  Future<AuthStatus> registerWithEmail(String email, String password) async {
    try {
      UserCredential credential = await authClient
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthStatus.registerSuccess;
    } catch (e) {
      return AuthStatus.registerFail;
    }
  }

  Future<AuthStatus> loginWithEmail(String email, String password) async {
    try {
      await authClient
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credential) async {
        user = credential.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('email', email);
        prefs.setString('password', password);
        prefs.setString('uid', user!.uid);
      });
      return AuthStatus.loginSuccess;
    } catch (e) {
      return AuthStatus.loginFail;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('email', '');
    prefs.setString('password', '');
    prefs.setString('uid', '');
    user = null;
    await authClient.signOut();
  }

  /// model_signup
  String registerEmail = "";
  String registerPassword = "";
  String registerPasswordConfirm = "";

  void setRegisterEmail(String email) {
    this.registerEmail = email;
    notifyListeners();
  }

  void setRegisterPassword(String password) {
    this.registerPassword = password;
    notifyListeners();
  }

  void setRegisterPasswordConfirm(String passwordConfirm) {
    this.registerPasswordConfirm = passwordConfirm;
    notifyListeners();
  }

  /// model_login
  String loginEmail = "";
  String loginPassword = "";

  void setloginEmail(String email) {
    this.loginEmail = email;
    notifyListeners();
  }

  void setloginPassword(String password) {
    this.loginPassword = password;
    notifyListeners();
  }
}
