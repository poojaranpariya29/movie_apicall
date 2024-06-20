import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/movie_provider.dart';
import 'detail_screen.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Like Page",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: Hero(
            tag: "movie",
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        body: Consumer<MovieProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return (value.likeList.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.heart_broken,
                            color: Colors.pinkAccent,
                            size: 150,
                          ),
                        ),
                      ),
                      Hero(
                        tag: "like",
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                          onPressed: () {
                            Navigator.pushNamed(context, "Home");
                          },
                          child: Text(
                            "Like Movies",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                : GridView.builder(
                    clipBehavior: Clip.antiAlias,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: value.likeList.length,
                    itemBuilder: (context, index) {
                      String sData = value.likeList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  index: value.index,
                                ),
                              ));
                        },
                        child: Stack(
                          children: [
                            Container(
                                margin: EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  sData,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 200,
                                )),
                            Positioned(
                                left: 0,
                                top: 0,
                                child: IconButton(
                                    onPressed: () {
                                      value.removeMovie(sData);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.lightBlue,
                                          duration: Duration(milliseconds: 200),
                                          content: Center(
                                            child: Text(
                                              "Sucessfully remove.... ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      CupertinoIcons.heart_solid,
                                      color: Colors.pinkAccent,
                                    )))
                          ],
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
