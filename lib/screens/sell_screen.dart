import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opem/provider/user_provider.dart';
import 'package:opem/widgets/drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as proveedor;
import 'package:xid/xid.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {

  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productCity = TextEditingController();

  File? fileImage;
  ImagePicker _picker = ImagePicker();

  Future<void> chooseImage() async {
    final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 640,
        maxHeight: 480,
        imageQuality: 40 //0 - 100
    );
    if(file?.path != null){
      setState(() {
        fileImage = File(file!.path);
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    var userProvider = proveedor.Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      drawer: GlobalDrawer(PageN: 1,),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 25,),
          fileImage==null?Center(
            child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.orange[800]), onPressed: (){
              // print("LOGOBASE: "+logoBase64.toString());
              chooseImage();

            }, child: Text("Choose image")),
          ):fileImage!=null?Container(width: 200,height: 200,child: Image.file(fileImage!)):Container(),
          Center(child: Container(width:200,child: TextFormField(controller: productName,decoration: InputDecoration(hintText: "Product Name"),))),
          Center(child: Container(width:200,child: TextFormField(controller: productDescription,decoration: InputDecoration(hintText: "Product Description"),))),
          Center(child: Container(width:200,child: TextFormField(controller: productPrice,decoration: InputDecoration(hintText: "Product Price"),))),
          Center(child: Container(width:200,child: TextFormField(controller: productCity,decoration: InputDecoration(hintText: "Product City"),))),
          SizedBox(height: 15,),
          ElevatedButton(onPressed: () async {
            var xid = Xid();

            final responseStorage = Supabase.instance.client.storage.from("product-images").upload(xid.toString(), fileImage!).then((value) async {
              print(value.data.toString());

              // final responseStorach = Supabase.instance.client.storage.from("product-images").getPublicUrl(userProvider.ID!).data.toString()
              // print(Supabase.instance.client.storage.from("product-images").getPublicUrl(userProvider.ID!).data.toString());
              final response = await Supabase.instance.client.from("Products").insert({
                "Pid":xid.toString(),
                "title":productName.text,
                "description":productDescription.text,
                "price":double.parse(productPrice.text),
                "owner":userProvider.ID,
                "city":productCity.text,
                "image":Supabase.instance.client.storage.from("product-images").getPublicUrl(xid.toString()).data.toString(),
              }).execute().whenComplete(() {
                Fluttertoast.showToast(msg: "ADDED");
                Navigator.pop(context);
              });
            });

          }, child: Text("Publish")),
        ],),
      ),
    );
  }

}
