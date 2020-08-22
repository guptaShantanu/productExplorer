import 'package:http/http.dart';
import 'dart:convert';

class NetworkService{

  String baseURL = "https://debug.qart.fashion/api/product/GetProductsWithSizes?retailerCode=";
  int retailerCode = 40984;

  Future<List> getData()async{
    try{
      Response response = await get(baseURL+retailerCode.toString());
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        return data['Products'];
      }else{
        print('Request failed '+response.statusCode.toString());
        return [];
      }
    }catch(e){
        print("Failed "+e.toString() );
        return [];
    }
  }
}