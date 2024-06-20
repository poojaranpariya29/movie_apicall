import 'package:flutter/material.dart';
import 'package:movie_apicall/View/view_screen.dart';
import '../Model/search_model.dart';

class DetailScreen extends StatefulWidget {
  final int? index;
  final Search? search;

  const DetailScreen({super.key, this.index, this.search});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "Detail Page",
          style: TextStyle(color: Colors.black54, fontSize: 22),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 300,
                width: 250,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.outer,
                        color: Colors.blue,
                        offset: Offset(0.2, 0.9),
                        spreadRadius: 10)
                  ],
                  color: Colors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Hero(
                  tag: widget.index!,
                  child: Image.network("${widget.search?.poster}",
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 23,
            ),
            Column(
              children: [
                Text(
                  " Movie name : ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                Text(
                  "${widget.search?.title}",
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 20,
            ),
            Hero(
              tag: "image",
              transitionOnUserGestures: true,
              placeholderBuilder: (context, heroSize, child) {
                return child;
              },
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(2),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewScreen(
                          id: widget.search?.imdbId, index: widget.index),
                    ),
                  );
                },
                child: Text(
                  "View More",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
