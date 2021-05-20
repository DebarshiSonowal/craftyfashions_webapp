import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/LoginData.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Profile.dart';
import 'package:craftyfashions_webapp/Models/SignUpData.dart';
import 'package:craftyfashions_webapp/Utility/retry_interceptor.dart';
import 'package:craftyfashions_webapp/Utility/retry_refresh_token.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'dio_connectivity_request_retrier.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  http.Response response;
  Dio dio;

  Future getProf(String id) async {
    if (Test.accessToken != null) {
      // BaseOptions option =
      // new BaseOptions(connectTimeout: 7000, receiveTimeout: 3000, headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer ${Test.accessToken}',
      //   'id': id
      // });
      dio = Dio();
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Response response;
      try {
        response = await dio.get(url + "profile",
            options: Options(
                contentType: 'application/json',
                receiveTimeout: 3000,
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${Test.accessToken}',
                  'id': id
                }));
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.RESPONSE) {
          response = Response(statusCode: 500);
        }
      }
      if (response.statusCode == 200) {
        print("Hello ${response.data}");
        return response.data[0];
      } else {
        return response.data;
      }
    }
  }

  Future saveProf(Profile profile) async {
    if (Test.accessToken != null) {
      Map data = {
        'email': profile.email,
        'name': profile.name,
        'userId': profile.id,
        'phone': profile.phone,
        'address': profile.address,
        'pincode': profile.pincode,
        'gender': profile.gender
      };

      var body = json.encode(data);
      BaseOptions option =
          new BaseOptions(connectTimeout: 7000, receiveTimeout: 3000, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Test.accessToken}',
      });
      dio = Dio();
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Response response;
      try {
        response = await dio.patch(url + "profile",
            data: body,
            options: Options(
                contentType: 'application/json',
                receiveTimeout: 3000,
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${Test.accessToken}',
                }));
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.RESPONSE) {
          response = Response(statusCode: 500);
        }
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    }
  }

  Future log(LoginData loginData) async {
    Map data = {
      'email': loginData.email,
      'password': loginData.password,
      'googleId': loginData.googleId
    };
    var body = json.encode(data);
    print("Body $body");
    BaseOptions option =
        new BaseOptions(connectTimeout: 10000, receiveTimeout: 3000, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    });
    dio = Dio();
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Response response;
    try {
      response = await dio.post(url + "login",
          data: body,
          options: Options(
              contentType: 'application/json',
              receiveTimeout: 3000,
              headers: {
                'Accept': 'application/json',
              }));
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RESPONSE) {
        if (e.response == null || e.response.statusCode != 400) {
          response = Response(statusCode: 500);
        } else {
          response = Response(statusCode: 400);
        }
      }
    }
    if (response.statusCode == 200) {
      print("Response : ${response.data}");
      return response.data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "User not found";
    }
  }

  Future sign(SignUpData signUpData) async {
    BaseOptions option =
        new BaseOptions(connectTimeout: 7000, receiveTimeout: 3000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Test.accessToken}',
    });
    dio = Dio();
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Map data = {
      'name': signUpData.name,
      'email': signUpData.email,
      'password': signUpData.password,
      'googleId': signUpData.googleId,
      'gender': signUpData.gender
    };
    var body = json.encode(data);
    Response response;
    try {
      response = await dio.post(url + "signup",
          data: body,
          options: Options(
              contentType: 'application/json',
              receiveTimeout: 3000,
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer ${Test.accessToken}',
              }));
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        response = Response(statusCode: 500);
      }
    }
    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "User not found";
    }
  }

  Future getAll() async {
    dio = Dio();
    dio.interceptors.add(
      RetryOnAccessTokenInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Response response;
    try {
      response = await dio.get(url + "products",
          options: Options(
              contentType: 'application/json',
              receiveTimeout: 3000,
              headers: {
                'Accept': 'application/json',
              }));
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        response = Response(statusCode: 500);
      }
    }
    if (response.statusCode == 200) {
      var data = response.data["products"] as List;
      List<Products> Data = data.map((e) => Products.fromJson(e)).toList();
      return Data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Products not found";
    }
  }

  Future getRequired() async {
    BaseOptions option =
        new BaseOptions(connectTimeout: 7000, receiveTimeout: 6000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    dio = Dio();
    dio.interceptors.add(
      RetryOnAccessTokenInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Response response;
    try {
      response = await dio.get(url + "required",
          options: Options(
              contentType: 'application/json',
              receiveTimeout: 3000,
              headers: {
                'Accept': 'application/json',
              }));
    } on DioError catch (e) {
      print(e.error);
      if (e.error == DioErrorType.CONNECT_TIMEOUT) {
        response = Response(statusCode: 500);
      }
    }
    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Required info not found";
    }
  }

  Future cancel(dynamic orderId, dynamic email) async {
    BaseOptions options =
        new BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Test.accessToken}',
    });
    Map data = {'orderId': orderId, 'email': email};
    print("rEceived1");
    var body = json.encode(data);
    dio = Dio(options);
    dio.interceptors.add(
      RetryOnAccessTokenInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Response response;
    try {
      response = await dio.post(url + "cancel",
          data: body,
          options: Options(
              contentType: 'application/json',
              receiveTimeout: 3000,
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer ${Test.accessToken}',
              }));
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        response = Response(statusCode: 500);
        response.statusCode = 500;
      }
    }
    if (response.statusCode == 200) {
      print("rEceived");
      return "Your cancellation request is received";
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Please try again later";
    }
  }

  Future triggerResponse(dynamic orderId, dynamic email) async {
    BaseOptions options =
        new BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Test.accessToken}',
      'orderId': orderId,
    });
    Map data = {'orderId': orderId, 'email': email};
    var body = json.encode(data);
    dio = Dio(options);
    dio.interceptors.add(
      RetryOnAccessTokenInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Response response;
    try {
      response = await dio.post(url + "mail", data: body);
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        response = Response(statusCode: 500);
        response.statusCode = 500;
      }
    }
    if (response.statusCode == 200) {
      return "complete";
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Products not found";
    }
  }

  Future getorder(double price) async {
    if (Test.accessToken != null) {
      BaseOptions options =
          new BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Test.accessToken}',
        'price': price.toString(),
      });
      dio = Dio(options);
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Response response;
      try {
        response = await dio.get(url + "order");
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          response = Response(statusCode: 500);
          response.statusCode = 500;
        }
      }
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      } else if (response.statusCode == 500) {
        return "Server Error";
      } else {
        return "Products not found";
      }
    }
  }

  Future getordersforUser(dynamic id) async {
    BaseOptions options =
        new BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Test.accessToken}',
      'uid': id,
    });
    dio = Dio(options);
    dio.interceptors.add(
      RetryOnAccessTokenInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    Response response;
    try {
      response = await dio.get(url + "receiveOrders");
    } on DioError catch (e) {
      print(e.error);
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        response = Response(statusCode: 500);
      }
    }
    if (response.statusCode == 200) {
      var data = response.data as List;
      List<Order> Data = data.map((e) => Order.fromJson(e)).toList();
      return Data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Orders  not found";
    }
  }

  Future saveorder(dynamic body) async {
    if (Test.accessToken != null) {
      BaseOptions options =
          new BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Test.accessToken}',
      });
      dio = Dio();
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Response response;
      try {
        response = await dio.post(url + "payment", data: body,options: Options(
          contentType: 'application/json',
          receiveTimeout: 4000,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Test.accessToken}',
          }
        ));
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          response = Response(statusCode: 500);
        }
      }
      if (response.statusCode == 200) {
        var data = response.data;
        print("!%!%1");
        return data;
      } else if (response.statusCode == 500) {
        print("!%!%2");
        return "Server Error";
      } else {
        print("!%!%13");
        return "Failed to save";
      }
    }
  }

  Future getuser() async {
    if (Test.accessToken != null) {
      dio = Dio();
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Response response;
      try {
        response = await dio.get(
          url + "user",
          options: Options(contentType: 'application/json', headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Test.accessToken}',
          }),
        );
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          print("First ${e}");
          response = Response(statusCode: 500);
        } else {
          print("Else $e");
        }
      }
      try {
        if (response.statusCode == 200) {
          var data = response.data;
          print("ADAD  DAtat");
          print(data);
          return data;
        } else if (response.statusCode == 500) {
          return "Server Error";
        } else {
          return "User not found";
        }
      } catch (e) {
        print("CACAR ${jsonDecode(e)}");
        return "User not found";
      }
    } else {
      print("CCCvbbb");
      return "Server Error";
    }
  }

  Future saveOrderdatabase(Order order, String name) async {
    if (Test.accessToken != null) {
      Map data = {
        'email': order.email,
        'name': name,
        'orderId': order.orderId,
        'products': order.products,
        'payment': order.payment,
        'size': order.size,
        'price': order.price,
        'image': order.picture,
        'quantity': order.quantity,
        'color': order.color,
        'status': order.status,
        'address': order.address,
        'phone': order.phone,
        'UID': order.UID,
        'pincode': order.pin,
        'trackingId': order.trackingId
      };
      var body = json.encode(data);
      print("Data s ${body}");
      BaseOptions options =
          new BaseOptions(connectTimeout: 7000, receiveTimeout: 3000, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Test.accessToken}',
      });
      dio = Dio();
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Response response;
      try {
        response = await dio.post(url + "orders",
            data: body,
            options: Options(contentType: 'application/json',receiveTimeout:4000 , headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Test.accessToken}',
            }));
        print("sent");
      } on DioError catch (e) {
        print(e);
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          response = Response(statusCode: 500);
        }
      }
      if (response != null) {
        if (response.statusCode == 200) {
                return response.data;
              } else {
                return "Unable to save order";
              }
      }else{
        print("Response is null");
      }
    }
  }
}
