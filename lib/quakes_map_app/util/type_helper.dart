// This class is using for fix the type error when converting apı file json to dart
// you need other apps project this dart file

class TypeHelper {
// takes care of converting whatever type that we are passing here into an integer that is recognizable
  static int toInt (num val ){
    try{
      if(val==null){
        return 0;
      }
      if(val is int){
        return val;
      }
      else{
        return val.toInt();

      }
    }
    catch(error){
      print(error);
      return 0;

    }
  }
  static double toDouble(num val ){
    try {
      if(val == null){
        return 0;
      }
      if(val is double){
        return val;
      }
      else{
        return val.toDouble();

      }
    }
    catch(error){
      print(error);
      return 0;

    }
  }

}