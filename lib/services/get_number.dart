class GetNumber{
  String? getFirst(String data){
    if(data.isEmpty){
      return null;
    }else{
      if(data.contains(".")){
        int index=data.indexOf(".");
        String raw=data.substring(index+2,index+3);
        return raw;
      }else{
        return null;
      }

    }
  }
  String? getLast(String data){
    if(data.isEmpty){
      return null;
    }else{
      if(data.contains(".")){
        int index=data.indexOf(".");
        String raw=data.substring(index-1,index);
        return raw;
      }else{
        return null;
      }

    }
  }
}