import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:craftyfashions_webapp/Helper/CashOrder.dart';
import 'package:craftyfashions_webapp/Helper/Test.dart';
import 'package:craftyfashions_webapp/Models/CartProduct.dart';
import 'package:craftyfashions_webapp/Models/LoginData.dart';
import 'package:craftyfashions_webapp/Models/Order.dart';
import 'package:craftyfashions_webapp/Models/Products.dart';
import 'package:craftyfashions_webapp/Models/Profile.dart';
import 'package:craftyfashions_webapp/Models/SignUpData.dart';
import 'package:craftyfashions_webapp/UI/Styling/Styles.dart';
import 'package:craftyfashions_webapp/Utility/retry_interceptor.dart';
import 'package:craftyfashions_webapp/Utility/retry_refresh_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dio_connectivity_request_retrier.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  http.Response response;
  Dio dio;

  Future getProf(String id) async {
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
      response = await dio.post(url + "loginNew",
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
    if (response!=null) {
      print("Response ${response}");
      if (response.statusCode == 200) {
        print("Response : ${response.data}");
        return response.data;
      } else if (response.statusCode == 500) {
        return "Server Error";
      } else {
        return "User not found";
      }
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
    if (response!=null) {
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 500) {
        return "Server Error";
      } else {
        return "409";
      }
    } else {
      return "409";
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
    if (response != null) {
      if (response.statusCode == 200) {
        var data = response.data["products"] as List;
        List<Products> Data = data.map((e) => Products.fromJson(e)).toList();
        return Data;
      } else if (response.statusCode == 500) {
        return "Server Error";
      } else {
        return "Products not found";
      }
    } else {
      print("No productr");
      Styles.showWarningToast(
          Colors.red, "Swipe down and try again", Colors.white, 20);
    }
  }

  Future getSignature(var cashOrder) async{
    print("ADbv1 ${cashOrder}");
    if(Test.accessToken !=null&&Test.refreshToken!=null ){
      dio = Dio();
      dio.interceptors.add(
        RetryOnAccessTokenInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Map data ={
        'orderId':cashOrder['orderId'],
        'orderAmount' : cashOrder['orderAmount'].toString(),
        'orderCurrency':"INR",
        'orderNote':cashOrder['orderNote'].toString(),
        'customerName':cashOrder['customerName'].toString(),
        'customerPhone':cashOrder['customerPhone'].toString(),
        'customerEmail':cashOrder['customerEmail'].toString(),
        'returnUrl':'https://officialcraftybackend.herokuapp.com/users/getData',
        'notifyUrl':'https://officialcraftybackend.herokuapp.com/users/web'
      };
      var body;
      try {
        body = json.encode(data);
        print("Data is ${body}");
      } catch (e) {
        print(e);
      }
      print("Data 1q ${body}");
      Response response;
      try {
        response = await dio.post(url + "verify",
            data: body,
            options: Options(
                contentType: 'application/json',
                receiveTimeout: 10000,
                headers: {
                  'Accept': 'application/json',
                }));
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          response = Response(statusCode: 500);
        }
      }
      if (response.statusCode == 200) {
        print(response.data);
        var data = response.data;
        return data;
      } else if (response.statusCode == 500) {
        return "Server Error";
      } else {
        return "Products not found";
      }
    }else{
      print("ADbv");
    }
  }

  Future getCart(var id) async{
    if (Test.accessToken != null && Test.refreshToken !=null) {
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
            response = await dio.get(url + "getCart",options: Options(
                headers: {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer ${Test.accessToken}',
                  'uid':id,
                },
                contentType: 'application/json',receiveTimeout: 5000
            ));
          } on DioError catch (e) {
            print("${e.error} ${e.type.index}");
            if (e.error == DioErrorType.CONNECT_TIMEOUT) {
              print("DA");
              response = Response(statusCode: 500);
              response.statusCode = 500;
              print("response1 ${response.statusCode}");
            }
          }
      if (response.statusCode == 200) {
            var data = response.data as List;
            print("Data is ${data}");
            List<CartProduct> Data = data.map((e) => CartProduct.fromJson(e)).toList();
            return Data;
          } else if (response.statusCode == 500) {
            return "Server Error";
          } else {
            return "Unable to generate";
          }
    } else {

    }
  }
Future syncCart(List<CartProduct> cart,var id) async {
  var body = jsonEncode(cart.toList());
  print(body);
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
    response = await dio.post(url + "multiple", data: body, options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Test.accessToken}',
          'uid':id,
        },
        contentType: 'application/json', receiveTimeout: 5000
    ));
  } on DioError catch (e) {
    print("${e.error} ${e.type.index}");
    if (e.error == DioErrorType.CONNECT_TIMEOUT) {
      print("DA");
      response = Response(statusCode: 500);
      response.statusCode = 500;
      print("response1 ${response.statusCode}");
    }
  }
  if (response.statusCode == 200) {
    var data = response.data;
    return data;
  } else if (response.statusCode == 500) {
    return "Server Error";
  } else {
    return "Unabale";
  }
}


  Future addtoCart(CartProduct cartProduct)async{
    Map data ={
      'color':cartProduct.color,
      'name' : cartProduct.name,
      'price':cartProduct.payment,
      'quantity':cartProduct.quantity,
      'UID':cartProduct.UID,
      'picture':cartProduct.picture,
      'size':cartProduct.size,
      'Id':cartProduct.Id,
      'owner':cartProduct.getowner
    };
    var body = json.encode(data);
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
      response = await dio.post(url + "addtocart", data: body,options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Test.accessToken}',
          },
          contentType: 'application/json',receiveTimeout: 5000
      ));
    } on DioError catch (e) {
      print("${e.error} ${e.type.index}");
      if (e.error == DioErrorType.CONNECT_TIMEOUT) {
        print("DA");
        response = Response(statusCode: 500);
        response.statusCode = 500;
        print("response1 ${response.statusCode}");
      }
    }
    if (response.statusCode == 200) {
      var data = response.data;
      return data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Unable to generate";
    }

  }
  Future payOrder(CashOrder cashOrder) async {
    Map data = {
      'orderID': cashOrder.orderId
          .toString()
          .substring(1, cashOrder.orderId.toString().length - 1),
      'amount': cashOrder.orderAmount,
      'orderCurrency': 'INR',
      'orderNote': cashOrder.orderNote,
      'customerName': cashOrder.customerName,
      'email': cashOrder.customerEmail,
      'phone': cashOrder.customerPhone,
    };
    var body = json.encode(data);
    print("GIve $body");
    BaseOptions options =
    new BaseOptions(connectTimeout: 10000, receiveTimeout: 5000, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',

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
      response = await dio.post(url + "orderCASH", data: body,options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Test.accessToken}',
        },
        contentType: 'application/json',receiveTimeout: 5000
      ));
    } on DioError catch (e) {
      print("${e.error} ${e.type.index}");
      if (e.error == DioErrorType.CONNECT_TIMEOUT) {
        print("DA");
        response = Response(statusCode: 500);
        response.statusCode = 500;
        print("response1 ${response.statusCode}");
      }
    }
    print("response ${response}");
    if (response.statusCode == 200) {
      var data = response.data;
      print("The data isw ${data['body']}");
      print(data['body']['cftoken']);
      return data;
    } else if (response.statusCode == 500) {
      return "Server Error";
    } else {
      return "Unable to generate";
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
          url + "userNew",
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
