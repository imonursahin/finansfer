import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finansfer/core/network/di/dio_client.dart';
import 'package:finansfer/core/network/models/response/news_resp.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() {
    return _NewsHomePageState();
  }
}

class _NewsHomePageState extends State<NewsHomePage> {
  DioClient _dioClient = DioClient();
  NewsResp newsList = NewsResp();
  bool loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brightMainColor,
        title: Text("Finans & Ekonomi Haberleri"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.mainColor,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: newsList.result?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 130,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image.network(
                                newsList.result?[index].image != "" &&
                                        newsList.result?[index].image != null
                                    ? newsList.result![index].image.toString()
                                    : "https://www.samsunmanset.com/wp-content/uploads/2020/12/serbest-piyasada-d-viz-a-l-fiyatlar-14122020-ekonomi-haber-IVFqVbWv-740x420.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: ListTile(
                                      title: Text(
                                        newsList.result?[index].name
                                                .toString() ??
                                            "",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      subtitle: Text(
                                          newsList.result![index].description!
                                                      .length >
                                                  95
                                              ? newsList
                                                  .result![index].description
                                                  .toString()
                                                  .substring(0, 95)
                                              : newsList
                                                  .result![index].description!,
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text("Devamını Oku"),
                                          onPressed: () async {
                                            await launch(
                                                newsList.result?[index].url ??
                                                    "");
                                          },
                                        ),
                                        SizedBox(
                                          width: 8,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            flex: 8,
                          ),
                        ],
                      ),
                    ),
                    elevation: 8,
                    margin: EdgeInsets.all(10),
                  );
                }),
      ),
    );
  }

  getNews() async {
    try {
      setState(() {
        loading = true;
      });
      final res = await _dioClient.get(
          "https://api.collectapi.com/news/getNews?country=tr&tag=economy",
          options: Options(
            headers: {
              'Authorization':
                  'apikey 7mXJXdII53dF46z2TtXgIp:2OtAQc6yh2tPjALy0pMpBG'
            },
            method: "GET",
            receiveTimeout: 15000,
          ));
      setState(() {
        newsList = NewsResp.fromJson(res);
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
}
