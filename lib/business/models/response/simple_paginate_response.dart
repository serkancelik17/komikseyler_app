// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'package:komix/business/models/response/absctracts/response_meta_data_abstract.dart';
import 'package:komix/business/models/response/response.dart';

class SimplePaginateResponse extends Response {
  SimplePaginateResponse({
    success,
    metaData,
    message,
  }) : super(success: success, metaData: metaData, message: message);

  SimplePaginateResponse fromJson(Map<String, dynamic> json) => SimplePaginateResponse(
        success: json["success"] == null ? null : json["success"],
        metaData: json["data"] == null ? null : SimplePaginateMetaData().fromJson(json['data']),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "metaData": metaData == null ? null : SimplePaginateMetaData().toJson(),
        "message": message == null ? null : message,
      };
}

class SimplePaginateMetaData extends ResponseMetaDataAbstract {
  int currentPage;
  String firstPageUrl;
  int from;
  String nextPageUrl;
  String path;
  dynamic perPage;
  dynamic prevPageUrl;
  int to;

  SimplePaginateMetaData({
    this.currentPage,
    data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  }) : super(data: data);

  SimplePaginateMetaData fromJson(Map<String, dynamic> json) => SimplePaginateMetaData(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null ? null : json['data'],
        firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        nextPageUrl: json["next_page_url"] == null ? null : json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toString())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "next_page_url": nextPageUrl == null ? null : nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
      };
}

class Data {
  Data({
    this.id,
    this.categoryId,
    this.path,
    this.likesCount,
    this.favoritesCount,
    this.sharesCount,
    this.userLikesCount,
    this.userFavoritesCount,
    this.userSharesCount,
  });

  int id;
  int categoryId;
  String path;
  int likesCount;
  int favoritesCount;
  int sharesCount;
  int userLikesCount;
  int userFavoritesCount;
  int userSharesCount;
}
