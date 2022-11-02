import 'dart:convert';
import 'package:drag_app/screens/card_detail.dart';
import 'package:drag_app/screens/main_one.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/apteka_model/apteka.dart';

class NewsDetailsPage extends StatefulWidget {
  final int index;
  NewsDetailsPage({Key? key, required this.index, }) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {

  Future<Apteka?>? getResult;

  Future<Apteka?> getData() async {
    String url = "https://pharmacy-app-management.herokuapp.com/api/drugs/${widget.index.toString()}";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String,dynamic>;
      return Apteka.fromJson(json);
    }

    return null;
  }
  @override
  void initState() {
    super.initState();
    getResult=getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       leading:IconButton(
         onPressed: (){
           Navigator.pop(context);
         },
         icon: Icon(Icons.arrow_back,color: Colors.black,),
       ),
        backgroundColor: Colors.transparent,
        actions: const [
          Icon(Icons.add_alert_rounded,size:25,color: Color(0xff090F47),),
          SizedBox(width:10,),
          Icon(Icons.shopping_bag_outlined,size:25,color:Color(0xff090F47),),
          SizedBox(width:10,),
        ],
      ),
      body: FutureBuilder<Apteka?>(
        future: getResult,
        builder: (BuildContext context, AsyncSnapshot<Apteka?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            Apteka? users = snapshot.data;
            return Dori(users!);
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
  Widget Dori(Apteka dori){
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dori.name??"",style: TextStyle(color: Colors.black,fontSize:25,fontWeight: FontWeight.bold),),
          Text("Shayana Parm",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold),),

         SizedBox(height: 15,),
          Container(
            width:double.infinity,
            height:250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.network(dori.imageUrl??"",fit: BoxFit.fill,),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dori.price.toString()??"0"),
                  Text("No discount",style: TextStyle(color: Colors.black,fontSize:14,fontWeight: FontWeight.bold),),
                ],
              ),
              InkWell(
                onTap: (){
                  list.add(dori.id);
                  if(list.length>1){
                    sum+=1;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CardDetail(index:dori.id,)));
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/plus.png",width: 20,height:20,),
                    SizedBox(width: 10,),
                    Text("Add to card",style: TextStyle(color: Color(0xff006AFF)),),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height:10,),
          const Divider(thickness: 2,),
          const SizedBox(height:10,),
          Text("Product Details",style:TextStyle(color: Colors.black,fontSize:18,fontWeight: FontWeight.w600),),
          Container(
            child: Text(dori.description??""),
          )
        ],
      ),
    );
  }
}
