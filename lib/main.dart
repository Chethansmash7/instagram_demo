import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(TabBarBF());
}

class TabBarBF extends StatefulWidget {
  @override
  _TabBarBFState createState() => _TabBarBFState();
}

class _TabBarBFState extends State<TabBarBF> {
  List data = [];
  List data2 = [];
  List<String> imgUrl = [];
  List<String> imgUr2 = [];
  List<String> name1 = [];
  List<String> name2 = [];
  bool flag1 = false;
  bool flag2 = false;
  String url1 =
      "https://api.unsplash.com/collections/1580860/photos?client_id=AFgIi5qdW4QAKu4FqazpfuQjv0DSW4inIZ_9XPPMfqk";
  String url2 =
      "https://api.unsplash.com/collections/139386/photos?client_id=AFgIi5qdW4QAKu4FqazpfuQjv0DSW4inIZ_9XPPMfqk";
  ScrollController _scrollController = new ScrollController();

  getData() async {
    http.Response response = await http.get(url1);
    data = json.decode(response.body);
    _assign();
    setState(() {
      flag1 = true;
    });
  }

  _assign() {
    for (var i = 0; i < data.length; i++) {
      imgUrl.add(data.elementAt(i)["urls"]["regular"]);
      name1.add(data.elementAt(i)["description"]);
    }
  }

  getData2() async {
    http.Response response2 = await http.get(url2);
    data2 = json.decode(response2.body);
    _assign2();
    setState(() {
      flag2 = true;
    });
  }

  _assign2() {
    for (var i = 0; i < data2.length; i++) {
      imgUr2.add(data2.elementAt(i)["urls"]["regular"]);
      name2.add(data2.elementAt(i)["description"]);
      print(name2);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getData2();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData();
        getData2();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                //names
                Tab(child: Text("Random Works")),
                Tab(child: Text("Pets")),
              ],
            ),
            title: Text('Select Images Of'),
          ),
          body: TabBarView(
            children: [
//          ListView.builder(
//            controller: _scrollController,
//             itemCount: imgUrl.length,
              GridView.builder(
                  controller: _scrollController,
                  itemCount: imgUrl.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,crossAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(

                      child: !flag1
                          ? CircularProgressIndicator()
                          : Image.network(imgUrl[index], fit: BoxFit.cover),
                    );
                  }),

              GridView.builder(
                  controller: _scrollController,
                  itemCount: imgUr2.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,crossAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(

                      child: !flag1
                          ? CircularProgressIndicator()
                          : Image.network(imgUr2[index], fit: BoxFit.cover),

                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
