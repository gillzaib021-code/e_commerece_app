import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static String userIdKey= "USERKEY";
  static String usernameKey= "USENAMERKEY";
  static String useremailKey= "USEREMAILKEY";
  static String userImageIdKey= "USERIMAGEKEY";



  Future<bool> saveUserId(String getUserId)async{
   SharedPreferences prefs= await  SharedPreferences.getInstance();
   return prefs.setString(userIdKey, getUserId);
  }

   Future<bool> saveUserName(String getUserName)async{
   SharedPreferences prefs= await  SharedPreferences.getInstance();
   return prefs.setString(usernameKey, getUserName);
  }


   Future<bool> saveUserEmail(String getUserEmail)async{
   SharedPreferences prefs= await  SharedPreferences.getInstance();
   return prefs.setString(useremailKey, getUserEmail);
  }

   Future<bool> saveUserImage(String getUserImage)async{
   SharedPreferences prefs= await  SharedPreferences.getInstance();
   return prefs.setString(userImageIdKey, getUserImage);
  }

  Future<String?> getUserId()async{
    SharedPreferences prefs= await  SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserName()async{
    SharedPreferences prefs= await  SharedPreferences.getInstance();
    return prefs.getString(usernameKey);
  }

  Future<String?> getUserEmail()async{
    SharedPreferences prefs= await  SharedPreferences.getInstance();
    return prefs.getString(useremailKey);
  }

  Future<String?> getUserImage()async{
    SharedPreferences prefs= await  SharedPreferences.getInstance();
    return prefs.getString(userImageIdKey);
  }
}