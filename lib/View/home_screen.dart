import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../Model/search_model.dart';
import '../Provider/movie_provider.dart';
import '../Provider/search_provider.dart';
import '../Utils/api_helper.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreen> {
  String sModel = "animal";
  String value1 = "";

  @override
  void initState() {
    SearchProvider sp = Provider.of<SearchProvider>(context, listen: false);
    sp.sMovie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Animal Movie",
          style: TextStyle(
              color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w900),
        ),
        actions: [
          Hero(
            tag: "like",
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "Like");
              },
              icon: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.pinkAccent,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<SearchProvider>(
            builder: (context, value, child) => FutureBuilder(
              future: ApiHelper()
                  .searchApi(value.sMovie.isEmpty ? sModel : value.sMovie),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Image.asset("assets/noconnection.png")),
                      Text(
                        "${snapshot.error.runtimeType}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  SearchModel? data = snapshot.data;
                  return Consumer2<MovieProvider, SearchProvider>(
                    builder: (context, value, value2, child) {
                      return Expanded(
                        child: Column(
                          children: [
                            value.isShow
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      onChanged: (value) {
                                        value2.searchApi(value);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        hintText: "Search",
                                        enabled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        focusColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        suffixIconColor: Colors.white,
                                        suffixIcon: Hero(
                                          tag: "search",
                                          child: IconButton(
                                            onPressed: () {
                                              value.hide();
                                            },
                                            icon: Icon(Icons.cancel),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            value.show();
                                          },
                                          child: Text(
                                            "Search",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20),
                                          )),
                                      SizedBox(width: 220),
                                      Hero(
                                        tag: "search",
                                        child: IconButton(
                                          onPressed: () {
                                            value.show();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.search,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            (snapshot.hasData)
                                ? Expanded(
                                    child: GridView.builder(
                                      clipBehavior: Clip.antiAlias,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: data?.search?.length,
                                      itemBuilder: (context, index) {
                                        var sData = data?.search![index];
                                        var dat = sData?.poster;
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                          index: value.index,
                                                          search: sData),
                                                ));
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.all(10),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Hero(
                                                    tag: index,
                                                    child: Image.network(
                                                      "${sData?.poster}",
                                                      fit: BoxFit.cover,
                                                      height: 200,
                                                      width: 200,
                                                    ),
                                                  )),
                                              Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        value.likeMovie(dat);

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .blueAccent,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            200),
                                                                    content:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Successfully like....",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )));
                                                        value.likeIndex(index);
                                                      },
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .heart_solid,
                                                        color:
                                                            Colors.pinkAccent,
                                                      )))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black54,
                                        backgroundColor: Colors.black),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Colors.black54, backgroundColor: Colors.black),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
