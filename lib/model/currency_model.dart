

import 'dart:convert';


class CurrencyModel {
    CurrencyModel({
        this.title,
        this.code,
        this.cbPrice,
        this.nbuBuyPrice,
        this.nbuCellPrice,
        this.date,
    });

    String? title;
    String? code;
    String? cbPrice;
    String? nbuBuyPrice;
    String? nbuCellPrice;
    Date? date;

    factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        title: json["title"],
        code: json["code"],
        cbPrice: json["cb_price"],
        nbuBuyPrice: json["nbu_buy_price"],
        nbuCellPrice: json["nbu_cell_price"],
        date: dateValues.map[json["date"]],
    );


}

enum Date { THE_08122022 }

final dateValues = EnumValues({
    "08.12.2022": Date.THE_08122022
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
