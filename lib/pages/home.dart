import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quote_day/api/api.dart';
import 'package:quote_day/model/quote_model.dart';
import 'package:quote_day/pages/favt_quote.dart';
import 'package:quote_day/pages/show_quote.dart';
import 'package:provider/provider.dart';
import 'package:quote_day/provider/favt_pro.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final fontHeight = MediaQuery.of(context).size.height;
    final List<Color> circleColors = [
      Colors.red.withOpacity(0.5),
      Colors.blue.withOpacity(0.5),
      Colors.green.withOpacity(0.5),
    ];
    Color randomGenerator() {
      return circleColors[new Random().nextInt(3)];
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff67cea3),
        title: const Text(
          'Quote App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoriteQuote()));
              },
              icon: Icon(
                Icons.favorite,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<QuoteModel>> snapshot) {
                    return ListView.builder(
                        itemCount: quoteList.length,
                        itemBuilder: (context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return waiting();
                          } else {
                            return Card(
                              margin: EdgeInsets.all(fontHeight * 0.02),
                              color: randomGenerator(),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowQuote(
                                          title: quoteList[index].text,
                                          author: quoteList[index].author,
                                          color: randomGenerator(),
                                        ),
                                      ));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data![index].text.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic),
                                          textAlign: TextAlign.center,
                                        ),
                                        Spacer(),
                                        Text(
                                          snapshot.data![index].author
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Consumer<FavoriteProviderClass>(
                                                builder:
                                                    (context, value, child) {
                                              return IconButton(
                                                  onPressed: () {
                                                    if (value.SelectedItem
                                                        .contains(index)) {
                                                      value.removeItem(index);
                                                    } else {
                                                      value.addItem(index);
                                                    }
                                                  },
                                                  icon: Icon(value.SelectedItem
                                                          .contains(index)
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_border_outlined));
                                            })
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Shimmer waiting() {
    return Shimmer.fromColors(
      baseColor: Color(0xff67cea3),
      highlightColor: Color(0xff67cea3),
      child: ListTile(
        title: Container(
          height: MediaQuery.of(context).size.height * 0.025,
          width: MediaQuery.of(context).size.width * 0.12,
          color: Colors.white,
        ),
        subtitle: Container(
          height: MediaQuery.of(context).size.height * 0.025,
          width: MediaQuery.of(context).size.width * 0.12,
          color: Colors.white,
        ),
        leading: Container(
          height: MediaQuery.of(context).size.height * 0.025,
          width: MediaQuery.of(context).size.width * 0.12,
          color: Colors.white,
        ),
      ),
    );
  }
}
