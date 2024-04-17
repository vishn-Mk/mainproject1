import 'package:shared_preferences/shared_preferences.dart';

class DbService{

  static SharedPreferences ? prefs;


  static Future<void> init() async{

     prefs = await SharedPreferences.getInstance();
  }


  static setLoginId(String id){

    prefs!.setString('loginid',id );
  }


   static setUserId(String id){

    prefs!.setString('userid',id );
  }



   static String?  getLoginId(){

    return prefs!.getString('loginid');
  }


  static String?  getUserId(){
    return prefs!.getString('userid');
  }




  

}