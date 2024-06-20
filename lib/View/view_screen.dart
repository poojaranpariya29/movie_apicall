import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Model/movie_model.dart';
import '../Utils/api_helper.dart';

class ViewScreen extends StatefulWidget {
  final String? id;
  final int? index;

  const ViewScreen({super.key, this.id, this.index});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: ApiHelper().iSearch(widget.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(color: Colors.black54),
            );
          } else if (snapshot.hasData) {
            IdModel? data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.inner,
                              color: Colors.black,
                              offset: Offset(0.9, 0.9),
                            )
                          ], borderRadius: BorderRadius.circular(10)),
                          child: Hero(
                            tag: "image",
                            placeholderBuilder: (context, heroSize, child) {
                              return child;
                            },
                            child: Image.network(
                              "${data?.poster}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              " Name :",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${data?.title}",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        " Releasing : ${data?.released}, ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        " Year : ${data?.year}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(" Duration : ${data?.runtime}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black54)),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Casting type : ${data?.genre}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Type : ${data?.type}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Direcoter : ${data?.director}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Weiters : ${data?.writer}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Actors : ${data?.actors}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Language : ${data?.language}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Country : ${data?.country}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Awards : ${data?.awards}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Description : ${data?.plot}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Rating : ${data?.imdbRating}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Boxoffice : ${data?.boxOffice}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " IMDB Rating : ${data?.imdbRating}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " MetaScore : ${data?.metascore}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Production : ${data?.production}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        " Website : ${data?.website}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black54,
              ),
            );
          }
        },
      ),
    );
  }
}
