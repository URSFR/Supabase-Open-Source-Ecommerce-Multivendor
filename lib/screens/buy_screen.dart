import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:opem/screens/productdetails_screen.dart';
import 'package:opem/supabase/functions.dart';
import 'package:opem/widgets/drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/user_provider.dart';
import '../stream/stream.dart';
import 'package:provider/provider.dart' as proveedor;

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  List<ProductsStream> lista = [];


  @override
  void initState() {
    var userProvider = proveedor.Provider.of<UserProvider>(context, listen: false);

    if(userProvider.email==null&&userProvider.ID==null){
      userProvider.email = Supabase.instance.client.auth.currentUser!.email;
      userProvider.ID=  Supabase.instance.client.auth.currentUser!.id;

      print("EMAIL {${userProvider.email} ID ${userProvider.ID}}");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      drawer: GlobalDrawer(PageN: 0,

      ),
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
                        .stream(['id'])
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
                              child: Container(
                                decoration: BoxDecoration(color: Colors.black,border: Border.all(width: 2,color:Colors.grey
                                ),borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(city: lista[index].city,title: lista[index].title, price: lista[index].price, description: lista[index].description, owner: lista[index].owner, image: lista[index].image)));
                                  },
                                  child: Column(children: [
                                    Text(lista[index].title,style: GoogleFonts.archivoBlack(fontSize: 32,color: Colors.white)),
                                    SizedBox(height: 5,),
                                    Image.network(lista[index].image),
                                    SizedBox(height: 5,),
                                    Text(lista[index].description,style: GoogleFonts.archivoBlack(fontSize: 16,color: Colors.white),overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 5,),
                                    Text(lista[index].price.toString(),style: GoogleFonts.archivoBlack(fontSize: 16,color: Colors.white)),
                                    SizedBox(height: 5,),
                                    Text(lista[index].city,style: GoogleFonts.archivoBlack(fontSize: 10,color: Colors.white)),
                                    SizedBox(height: 5,),

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
