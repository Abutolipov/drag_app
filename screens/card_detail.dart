import 'dart:convert';

import 'package:drag_app/models/apteka_model/apteka.dart';
import 'package:drag_app/screens/main_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
num all=0;
class CardDetail extends StatefulWidget {
  final int index;

  const CardDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {

  Future<List<Apteka>?>? getResult;

  Future<List<Apteka>> getData() async {

    String url = "https://pharmacy-app-management.herokuapp.com/api/drugs";
   // https://github.com/Abutolipov/exam_ecommerce
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body) as List;
      List<Apteka> dori = json.map((e) => Apteka.fromJson(e)).toList();
      return dori;
    }

    return List.empty();
  }
  @override
  void initState() {
    super.initState();
    getResult = getData();
    print(list.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Your Card",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
      body: FutureBuilder<List<Apteka>?>(
        future: getResult,
        builder: (BuildContext context, AsyncSnapshot<List<Apteka>?> snapshot) {
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
            List<Apteka>? users = snapshot.data;
            return Buy(users!);
          }
          return Container();
        },
      ),
      floatingActionButton:SizedBox(
        height:100,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff4157FF),
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
     ),
            onPressed: () {},
            child:Text("Place order ${all}"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget Buy(List<Apteka> apteka) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Item in your Card",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ThirdPage()));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.add,
                      color: Color(0xff006AFF),
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add more",
                      style: TextStyle(color: Color(0xff006AFF)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ConCon(apteka)
        ],
      ),
    );
  }
  Widget ConCon(List<Apteka> apteka) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.85,
      child: ListView.builder(
        itemCount:list.length,
        itemBuilder: (context,index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top:20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white10,
                ),
               clipBehavior: Clip.hardEdge,
               // padding: EdgeInsets.all(10),
                height: 120,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:145,
                      child: Image.network(apteka[index].imageUrl,fit: BoxFit.cover,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(child: Text(apteka[index].name.substring(0, 6),style:TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize:16),)),
                              SizedBox(width:70,),
                              InkWell(
                                 onTap: (){
                                   setState(() {
                                     list.removeAt(index);
                                   });
                                 },
                                  child: Container(child: Icon(Icons.cancel_outlined,size:23,))),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(apteka[index].price.toString().substring(0,4),style:TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize:16),),
                               SizedBox(width:5,),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      if(all>apteka[index].price){
                                        setState(() {
                                          all -= apteka[index].price;
                                          apteka[index].summa -= 1;
                                        });
                                      }
                                    },
                                    icon:Icon(CupertinoIcons.minus_circle,color: Color(0xffDFE3FF),),
                                  ),
                                  SizedBox(width:4,),
                                  Container(
                                    width: 20,
                                    child: Text(apteka[index].summa.toString(),style: TextStyle(color: Colors.black,fontSize:16),),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      setState(() {

                                        apteka[index].summa+=1;
                                        all+=apteka[index].price;
                                        print(all);
                                      });
                                    },
                                    icon:Icon(Icons.add_circle,color: Color(0xffA0ABFF),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
              SizedBox(height:10,),
              Divider(thickness: 2,)
            ],
          );
        }
      ),
    );
  }
}
