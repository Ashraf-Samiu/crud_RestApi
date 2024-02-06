import 'package:crud_restapi/RestApi/RestClient.dart';
import 'package:crud_restapi/Screen/ProductGridViewScreen.dart';
import 'package:crud_restapi/Style/Style.dart';
import 'package:flutter/material.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen(this.productItem, {super.key});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  Map<String,String> formValues= {
    "Img":"",
    "ProductCode":"",
    "ProductName":"",
    "Qty":"",
    "TotalPrice":"",
    "UnitPrice":"",
  };
  bool loading= false;

  @override
  initState(){
    super.initState();
    setState(() {
      formValues.update("Img", (value) => widget.productItem["Img"]);
      formValues.update("ProductCode", (value) => widget.productItem["ProductCode"]);
      formValues.update("ProductName", (value) => widget.productItem["ProductName"]);
      formValues.update("Qty", (value) => widget.productItem["Qty"]);
      formValues.update("TotalPrice", (value) => widget.productItem["TotalPrice"]);
      formValues.update("UnitPrice", (value) => widget.productItem["UnitPrice"]);
    });
  }

  inputOnChanged(mapKey,textValue){
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async{
    ///(isEmpty/length==0)=same..
    if(formValues["Img"]!.isEmpty){
      errorToast("Image Link Required!");
    }else if(formValues["ProductCode"]!.isEmpty){
      errorToast("Product Code Required!");
    }else if(formValues["ProductName"]!.isEmpty){
      errorToast("Product Name Required");
    }else if(formValues["Qty"]!.isEmpty){
      errorToast("Product Qty Required");
    }else if(formValues["TotalPrice"]!.isEmpty){
      errorToast("Total Price Required");
    }else if(formValues["UnitPrice"]!.isEmpty){
      errorToast("Unit Price Required");
    }else{
      setState(() {
        loading=true;
      });
      await productUpdateRequest(formValues, widget.productItem["_id"]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context)=>ProductGridViewScreen(),
          ), (Route route) => false
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UpdateProduct Screen"),
      ),
      body: Stack(
        children: [
          screenBackGround(context),
          Container(
            child: loading? Center(child: (CircularProgressIndicator()),) : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: formValues["ProductName"],
                    onChanged: (textValue){
                      inputOnChanged("ProductName", textValue);
                    },
                    decoration: appInputDecoration("ProductName"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: formValues["ProductCode"],
                    onChanged: (textValue){
                      inputOnChanged("ProductCode", textValue);
                    },
                    decoration: appInputDecoration("productCode"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: formValues["Img"],
                    onChanged: (textValue){
                      inputOnChanged("Img", textValue);
                    },
                    decoration: appInputDecoration("productImage"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: formValues["UnitPrice"],
                    onChanged: (textValue){
                    inputOnChanged("UnitPrice", textValue);
                  },
                    decoration: appInputDecoration("Unit Price"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: formValues["TotalPrice"],
                    onChanged: (textValue){
                      inputOnChanged("TotalPrice", textValue);
                    },
                    decoration: appInputDecoration("Total Price"),
                  ),
                  SizedBox(height: 20,),
                  appDropDownStyle(
                    DropdownButton(
                      value: formValues["Qty"],
                      items: [
                        DropdownMenuItem(
                          child: Text("Select Qty"),
                          value: "",
                        ),
                        DropdownMenuItem(
                          child: Text("1 pcs"),
                          value: "1 pcs",
                        ),
                        DropdownMenuItem(
                          child: Text("2 pcs"),
                          value: "2 pcs",
                        ),
                        DropdownMenuItem(
                          child: Text("3 pcs"),
                          value: "3 pcs",
                        ),
                        DropdownMenuItem(
                          child: Text("4 pcs"),
                          value: "4 pcs",
                        ),
                      ],
                      onChanged: (textValue){
                        inputOnChanged("Qty", textValue);
                      },
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    child: ElevatedButton(
                      style: appButtonStyle(),
                      onPressed: (){
                        formOnSubmit();
                      }, child: successButtonChild("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
