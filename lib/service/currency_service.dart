import 'package:currencyapp/model/currency_model.dart';
import 'package:dio/dio.dart';

class GetCurrencyService {
  CurrencyModel? resData;

  static Future<List<CurrencyModel>?> getCurrency() async {
    try {
      Response response =
          await Dio().get("https://nbu.uz/uz/exchange-rates/json/");
          var resData = (response.data as List)
          .map((e) => CurrencyModel.fromJson(e))
          .toList();
      return (response.data as List)
          .map((e) => CurrencyModel.fromJson(e))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
