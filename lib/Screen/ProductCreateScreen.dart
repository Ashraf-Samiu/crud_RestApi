import 'package:crud_restapi/RestApi/RestClient.dart';
import 'package:crud_restapi/Style/Style.dart';
import 'package:flutter/material.dart';
///svg= scalable vector graphics(it is used to create clean image)
class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  Map<String,String> formValues= {
    "Img":"",
    "ProductCode":"",
    "ProductName":"",
    "Qty":"",
    "TotalPrice":"",
    "UnitPrice":"",
  };
  bool loading= false;

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
      await productCreateRequest(formValues);
      setState(() {
        loading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
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
                    onChanged: (textValue){
                      inputOnChanged("ProductName", textValue);
                    },
                    decoration: appInputDecoration("ProductName"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    onChanged: (textValue){
                      inputOnChanged("ProductCode", textValue);
                    },
                    decoration: appInputDecoration("productCode"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    onChanged: (textValue){
                      inputOnChanged("Img", textValue);
                    },
                    decoration: appInputDecoration("productImage"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField
                    (onChanged: (textValue){
                    inputOnChanged("UnitPrice", textValue);
                  },
                    decoration: appInputDecoration("Unit Price"),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
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
                      }, child: successButtonChild("Submit"),
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
