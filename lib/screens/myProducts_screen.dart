import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opem/screens/productdetails_screen.dart';
import 'package:opem/screens/productedit_screen.dart';
import 'package:opem/stream/stream.dart';
import 'package:opem/widgets/drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as proveedor;

import '../provider/user_provider.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  List<ProductsStream> lista = [];

  @override
  Widget build(BuildContext context) {
    var userProvider = proveedor.Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      drawer: GlobalDrawer(PageN: 2,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 0,
              ),
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: Supabase.instance.client
                        .from('Products')
                        .stream([userProvider.ID!,"owner"])
                        .execute()
                        .handleError((e) => {
                      print('error $e'),
                    }),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else {
                        lista = [];
                        for (var data in snapshot.data!) {
                          lista.add(ProductsStream.fromJson(data));
                        }
                        return ListView.builder(
                          itemCount: lista.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProductEditScreen(title: lista[index].title, price: lista[index].price, description: lista[index].description, image: lista[index].image, id: lista[index].id, Pid: lista[index].Pid,)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.black,border: Border.all(width: 2,color:Colors.grey
                                  ),borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Column(children: [
                                    Text(lista[index].title,style: GoogleFonts.archivoBlack(color: Colors.white,fontSize: 32),),
                                    SizedBox(height: 5,),
                                    Image.network(lista[index].image),
                                    SizedBox(height: 5,),
                                    Text(lista[index].description,style: GoogleFonts.archivoBlack(color: Colors.white,fontSize: 16),),
                                    SizedBox(height: 5,),
                                    Text(lista[index].price.toString(),style: GoogleFonts.archivoBlack(color: Colors.white,fontSize: 16),),


                                  ],),
                                ),
                              ),
                              // child: ListTile(
                              //   leading: CircleAvatar(
                              //     child: Text(
                              //       lista[index].title
                              //     ),
                              //   ),
                              //   title: Text(
                              //     lista[index].description,
                              //   ),
                              //   trailing: Image.network(
                              //     lista[index].price.toString(),
                              //   ),
                              // ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      // body: FutureBuilder<PostgrestResponse<dynamic>>(future: Supabase.instance.client.from("TEST").select().execute()
      //     ,builder: (context,AsyncSnapshot snapshot){
      //   if(!snapshot.hasData){
      //     return Text("NO DATA");
      //   }
      //   return ListView.builder(
      //       itemCount: snapshot.data.length==null?0:snapshot.data.length,
      //       itemBuilder: (context,index){
      //         return Container(
      //           child: Column(children: [
      //             Text(snapshot.data[index]["id"]),
      //             Text(snapshot.data[index]["title"]),
      //             Text(snapshot.data[index]["description"]),
      //             Text(snapshot.data[index]["owner"]),
      //             Text(snapshot.data[index]["city"]),
      //             Text(snapshot.data[index]["price"].toString()),
      //           ],),
      //         );
      //   });
      // }),


    );
  }
}
