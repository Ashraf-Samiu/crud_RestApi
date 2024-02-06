import 'package:crud_restapi/RestApi/RestClient.dart';
import 'package:crud_restapi/Screen/ProductCreateScreen.dart';
import 'package:crud_restapi/Screen/ProductUpdateScreen.dart';
import 'package:crud_restapi/Style/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {

  List productList= [];
  bool isLoading= true;

  @override
  void initState(){
    callData();
    super.initState();
  }

  callData() async{
    isLoading= true;
    var data= await productGridViewListRequest();
    setState(() {
      productList= data;
      isLoading= false;
    });
  }
  deleteItem(id) async{
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Delete!"),
            content: Text("Once Delete,you can't get it back"),
            actions: [
              OutlinedButton(onPressed: () async{
                Navigator.pop(context);
                setState(() {
                 isLoading= true;
                });
                await productDeleteRequest(id);
                await callData();
                setState(() {
                 isLoading= false;
                });
              }, child: Text("Yes"),),
              OutlinedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("No"),),
            ],
          );
        },
    );
  }
  gotoUpdate(context,productItem){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=>
                ProductUpdateScreen(productItem),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListProduct"),
      ),
      body: Stack(
        children: [
          screenBackGround(context),
          Container(
            child: isLoading
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : RefreshIndicator(
                    onRefresh: () async{
                      await callData();
                    },
                  ///sweep to refresh (pull the screen upper to lower with finger)
                  child: GridView.builder(
                      itemCount: productList.length,
                      gridDelegate: productGridViewStyle(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Image.network(
                                  productList[index]["Img"],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productList[index]["ProductName"]),
                                    SizedBox(height: 7,),
                                    Text("Price: "+productList[index]["UnitPrice"]+"BDT"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            gotoUpdate(context,productList[index]);
                                          },
                                          child: Icon(
                                            CupertinoIcons.ellipsis_vertical_circle,
                                            size: 18,
                                            color: colorGreen,
                                          ),
                                        ),
                                        SizedBox(width: 4,),
                                        OutlinedButton(
                                            onPressed: () {
                                              deleteItem(
                                                  productList[index]["_id"]);
                                            },
                                            child: Icon(
                                              CupertinoIcons.delete,
                                              size: 18,
                                              color: colorRed,
                                            ),
                                          ),
                                        ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=>
                    ProductCreateScreen(),
              ),
            );
          },child: Icon(Icons.add),),
    );
  }
}
