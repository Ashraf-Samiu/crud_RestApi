import 'dart:convert';
import 'package:crud_restapi/Style/Style.dart';
import 'package:http/http.dart' as http;

Future <bool> productCreateRequest(formValues) async{
  var url= Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var postBody= json.encode(formValues);
  var postHeader= {"Content-Type":"application/json"};

  var response= await http.post(url,headers: postHeader,body: postBody);
  var resultCode= response.statusCode;
  var responseBody= json.decode(response.body);

  if(resultCode==200 && responseBody["status"]=="success"){
    successToast("Request Success");
    return true;
  }else{
    errorToast("Request failed! try again");
    return false;
  }
}
Future <List> productGridViewListRequest() async {
  var url= Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var postHeader= {"Content-Type":"application/json"};
  var response= await http.get(url,headers: postHeader);
  var resultBody= json.decode(response.body);
  if(response.statusCode==200 && resultBody["status"]=="success"){
    successToast("Request Success");
    return resultBody["data"];
  }else{
    errorToast("Request Failed!");
    return [];
  }
}
Future <bool> productDeleteRequest(id) async{
  var url= Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
  await http.get(url);
  var postHeader= {"Content-Type":"application/json"};
  var response= await http.get(url,headers: postHeader);
  var resultCode= response.statusCode;
  var resultBody= json.decode(response.body);
  if(resultCode==200 && resultBody["status"]=="success"){
    successToast("Request Success");
    return true;
  }else{
    errorToast("Request Fail! Try Again");
    return false;
  }
}
Future <bool> productUpdateRequest(formValues,id) async{

  var url= Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/"+id);
  var postBody= json.encode(formValues);
  var postHeader= {"Content-Type":"application/json"};

  var response= await http.post(url,headers: postHeader,body: postBody);
  var resultCode= response.statusCode;
  var responseBody= json.decode(response.body);

  if(resultCode==200 && responseBody["status"]=="success"){
    successToast("Request Success");
    return true;
  }else{
    errorToast("Request failed! try again");
    return false;
  }
}