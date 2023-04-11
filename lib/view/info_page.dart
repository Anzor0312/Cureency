import 'package:currencyapp/model/currency_model.dart';
import 'package:currencyapp/service/currency_service.dart';
import 'package:flutter/material.dart';


class InfoPage extends StatelessWidget {
  const InfoPage({super.key, required List data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 3, 6),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Currency Informoations"),
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset("assets/Chart.png"),
          ),
        ],
      ),
      body: FutureBuilder(
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
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data![index].cbPrice.toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 30),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 75),
                                  child: Text(
                                    snapshot.data![index].code.toString(),
                                    style: const TextStyle(color: Colors.greenAccent, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 315,
                        height: 263.37,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://source.unsplash.com/random/"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 135,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Text(
                                  "Buy",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 135,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                child: Text(
                                  "Sell",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Quick watch",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 190,
                          ),
                          const Text(
                            "See all >",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 295,),
                                child: Container(
                                  width: 315,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        snapshot.data![index].cbPrice
                                            .toString(),
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
                    ],
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
        },
      ),
    );
  }
}
