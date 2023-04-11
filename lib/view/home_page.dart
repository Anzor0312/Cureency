import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currencyapp/model/currency_model.dart';
import 'package:currencyapp/model/search_model.dart';
import 'package:currencyapp/service/currency_service.dart';
import 'package:currencyapp/view/info_page.dart';
import 'package:currencyapp/view/no_conntection_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool isConnected = false;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkConnection();
    scrollItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 3, 6),
      body: SafeArea(
        child: FutureBuilder(
          future: GetCurrencyService.getCurrency(),
          builder: (context, AsyncSnapshot<List<CurrencyModel>?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          color: Colors.grey[900]),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "https://source.unsplash.com/random/"),
                                            radius: 26),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4, left: 6, top: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      "Welcome Back",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.only(
                                                            right: 40, top: 10),
                                                    child: Text(
                                                      "John",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 100),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color.fromARGB(
                                                        190, 10, 10, 10),
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/Wallet.png"),
                                                        scale: 0.8)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color.fromARGB(
                                                        190, 10, 10, 10),
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/Scan.png"),
                                                        scale: 0.8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 335,
                              height: 48,
                              child: TextFormField(
                                enabled: false,
                                showCursor: false,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  prefixIcon: Image.asset("assets/Search.png"),
                                  suffixIcon: Image.asset(
                                    "assets/Filter.png",
                                  ),
                                  contentPadding: const EdgeInsets.only(top: 5),
                                  hintText: "Search...",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: const Color.fromARGB(190, 10, 10, 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                 
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: pageController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://phonoteka.org/uploads/posts/2021-06/1624425200_15-phonoteka_org-p-oboi-na-rabochii-stol-karta-mira-krasivo-20.jpg"),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data![index].title
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data![index].cbPrice
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 35,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 285),
                    child: Text(
                      "Watchlist",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoPage(
                                            data: [snapshot.data![index]],
                                          )));
                            },
                            child: Container(
                              width: 335,
                              height: 65,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(23, 87, 87, 86),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellowAccent,
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://cdn.onlinewebfonts.com/svg/download_202966.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].title.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    snapshot.data![index].cbPrice.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(onPressed: () {
                           
                          },backgroundColor: Colors.greenAccent, child:  const Icon(Icons.add, color: Colors.white,),),
                        ],
                      )
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: "",
          ),
        ],
      ),
    );
  }

  checkConnection() {
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        isConnected = true;
        Fluttertoast.showToast(msg: "You are online", textColor: Colors.white);
        setState(() {});
      } else {
        isConnected = false;
        Fluttertoast.showToast(msg: "You are offline");
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription!.cancel();
    super.dispose();
  }

  void scrollItem() async {
    for (int i = 0; i < 10; i) {
      await Future.delayed(const Duration(seconds: 4));
      pageController.nextPage(
          duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
    }
  }
}
