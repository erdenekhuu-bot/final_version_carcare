import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:final_pro/usable/Store/Store.dart';
import 'package:final_pro/usable/Components/Helper.dart';

class AuthService {
  final Dio dio = Dio();
  String access;
  String refresh;

  AuthService(this.access, this.refresh) {
    dio.interceptors.add(
        InterceptorsWrapper(
            onRequest: (RequestOptions options, RequestInterceptorHandler handler){
              if(access.isNotEmpty){
                options.headers['Authorization'] = 'Bearer ${access}';
                options.headers['Content-Type'] = 'application/json';
              }
              return handler.next(options);
            },
            onError: (DioException error, ErrorInterceptorHandler handler) async {
              if(error.response?.statusCode == 401){
                try{
                  final refreshing = await dio.post(
                      'https://admin-dev.carcare.mn/api/auth/refresh/', data: {'refresh': refresh});
                  if(refreshing.statusCode == 200){
                    access = refreshing.data['access'];
                    error.requestOptions.headers['Authorization'] = 'Bearer ${access}';
                    return handler.resolve(await dio.fetch(error.requestOptions));
                  }
                } catch(error){
                  return;
                }
              }
              return handler.next(error);
            }
        )
    );
  }
   Future<List<dynamic>> getPlaces() async {
    try {
      final request = await dio.get('https://admin-dev.carcare.mn/api/shops/');
      return request.statusCode == 200 ? request.data['results'] : [];
    } catch (error) {
      return [];
    }
  }

   Future<List<dynamic>> eachPlaces(int id) async {
    try {
      List<dynamic> content = [];
      final request = await dio.get('https://admin-dev.carcare.mn/api/shops/$id/');
      if (request.statusCode == 200) {
        content.add(request.data);
      }
      return content;
    } catch (error) {
      return [];
    }
  }

   Future<List<dynamic>> getServices() async {
    try {
      final request = await dio.get('https://admin-dev.carcare.mn/api/categories/');
      return request.statusCode == 200? request.data['results'] : [];
    } catch (error) {
      return [];
    }
  }

   Future<int> createExpense(String place, int amount, int id, String date) async {
    try {
      final Map<String, dynamic> content = {'service_place': place, 'amount': amount, 'service_id': id, 'service_date': date};
      final request = await dio.post('https://admin-dev.carcare.mn/api/expenses/', data: json.encode(content));
      return request.statusCode == 200 ? 1 : 0;
    } catch (error) {
      return 0;
    }
  }

   Future<String> updateUser(String username, String phone, String password) async {
    try {
      String? name = await Helper.readUsername();
      await Helper.saveValue('username', username);
      await Helper.saveValue('phone', phone);
      await Helper.saveValue('password', password);
      final Map<String, dynamic> content = {"username": username, "phonenumber": phone, "password": password};
      final request = await dio.patch('https://admin-dev.carcare.mn/api/auth/update/${name}/', data: json.encode(content));
      if(request.statusCode == 200){
        Store.storePhone=phone;
      }
      return request.statusCode == 200 ? request.data['token'] : '';
    } catch (error) {
      return error.toString();
    }
  }

   Future<String> forgotPassword(String phone, String password) async {
    try {
      final Map<String, dynamic> content = {"phonenumber": phone, "password": password};
      final request = await dio.put('https://admin-dev.carcare.mn/api/forgotpassword/', data: json.encode(content));
      return request.statusCode == 200 ? request.data['token'] : '';
    } catch (error) {
      return error.toString();
    }
  }

   Future<int> deleteExpense(int id) async {
    try {
      final request = await dio.delete('https://admin-dev.carcare.mn/api/expenses/$id/');
      return request.statusCode == 200 ? 1 : 0;
    } catch (error) {
      return 0;
    }
  }

   Future<List<dynamic>> serviceSubCategory() async {
    try {
      List<dynamic> category = [];
      int page = 1;
      while (page < 2) {
        final request = await dio.get('https://admin-dev.carcare.mn/api/services/?page=$page');
        if (request.statusCode == 200) {
          List<dynamic> all = request.data['results'];
          category.addAll(all);
          page += 1;
        }
      }
      return category;
    } catch (error) {
      return [];
    }
  }
   Future<List<dynamic>> serviceSubDir() async {
    try {
      List<dynamic> subcategory = [];
      int page = 1;
      while (page < 2) {
        final request = await dio.get('https://admin-dev.carcare.mn/api/service-categories/?page=$page');
        if (request.statusCode == 200) {
          List<dynamic> all = request.data['results'];
          subcategory.addAll(all);
          page += 1;
        }
      }
      return subcategory;
    } catch (error) {
      return [];
    }
  }
   Future<List<dynamic>> paginateShops(int page) async {
    try {
      final request = await dio.get('https://admin-dev.carcare.mn/api/shops/?page=$page');
      return request.statusCode == 200 ? request.data['results'] : [];
    } catch (error) {
      return [];
    }
  }

   Future<List<dynamic>> fetchAllShops() async {
    List<dynamic> allShops = [];
    int page = 1;

    while (page <= 10) {
      final response = await dio.get('https://admin-dev.carcare.mn/api/shops/?page=$page');
      if (response.statusCode == 200) {
        List<dynamic> all = response.data['results'];
        allShops.addAll(all);
        page += 1;
      }
    }
    return allShops;
  }


   Future<List<dynamic>> getCustomServices(String service) async {
    try {
      List<dynamic> result = [];
      final request = await dio.get('https://admin-dev.carcare.mn/api/shopservices/?service=$service');
      if (request.statusCode == 200)
        for (var item in request.data['results'])
          result.add(item['shop']);
      return result;
    } catch (error) {
      return [];
    }
  }

   Future<List<dynamic>> takeBanner() async {
    try {
      final request = await dio.get('https://admin-dev.carcare.mn/api/banner/');
      return request.statusCode == 200 ? request.data['results'] : [];
    } catch (error) {
      return [];
    }
  }

   Future<List<dynamic>> getUser() async {
    try {
      final request = await dio.get('https://admin-dev.carcare.mn/api/user/');
      return request.statusCode == 200 ? request.data['results'] : [];
    } catch (error) {
      return [];
    }
  }

}

