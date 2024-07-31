import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:final_pro/usable/Store/Store.dart';

class RESTAPI {
  static http.Client client = http.Client();

  static Future<int> sendOTP(String phone) async {
    try {
      final Map<String, String> content = {'phonenumber': phone};
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/auth/otp/send/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200 &&
              json.decode(utf8.decode(request.bodyBytes))['success'] == true
          ? 1
          : 0;
    } catch (error) {
      return 404;
    }
  }

  static Future<int> verifyOTP(String otp, String phone) async {
    try {
      final Map<String, dynamic> content = {'otp': otp, 'phone_number': phone};
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/auth/otp/validate/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200 &&
              json.decode(utf8.decode(request.bodyBytes))['success'] == true
          ? 1
          : 0;
    } catch (error) {
      return 404;
    }
  }

  static Future<String> createUser(
      String username, String password, String phone) async {
    try {
      final Map<String, dynamic> register = {
        'username': username,
        'password': password,
        'phonenumber': phone
      };
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/auth/register/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(register));
      return request.statusCode == 201
          ? json.decode(request.body)['token']
          : 'Something has error!';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<bool> login(String phone, String password) async {
    try {
      final Map<String, dynamic> content = {
        'phonenumber': phone,
        'password': password
      };
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/auth/login/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      if (request.statusCode == 200) {
        Store.accessToken = json.decode(request.body)['access'];
      }
      return request.statusCode == 200
          ? json.decode(request.body)['user']['is_active']
          : false;
    } catch (error) {
      return false;
    }
  }

  static Future<List<dynamic>> getPlaces() async {
    try {
      final request = await client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/shops/'),
          headers: {'Authorization': 'Bearer ${Store.accessToken}'});
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))['results']
          : [];
    } catch (error) {
      return [];
    }
  }

  static Future<List<dynamic>> eachPlaces(int id) async {
    try {
      List<dynamic> content = [];
      final request = await client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/shops/$id/'),
          headers: {'Authorization': 'Bearer ${Store.accessToken}'});
      if (request.statusCode == 200) {
        content.add(json.decode(utf8.decode(request.bodyBytes)));
      }
      return content;
    } catch (error) {
      return [error];
    }
  }

  static Future<List<dynamic>> getCustomPlaces(String service) async {
    try {
      final request = await client.get(
          Uri.parse(
              'https://admin-dev.carcare.mn/api/shopservices/?page=1&service=$service'),
          headers: {'Authorization': 'Bearer ${Store.accessToken}'});
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))['results']
          : '';
    } catch (error) {
      return [error];
    }
  }

  static Future<List<dynamic>> getServices() async {
    try {
      final request = await client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/categories/'),
          headers: {'Authorization': 'Bearer ${Store.accessToken}'});
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))['results']
          : [];
    } catch (error) {
      return [error];
    }
  }

  static Future<int> createExpense(
      String place, int amount, int id, String date) async {
    try {
      final Map<String, dynamic> content = {
        'service_place': place,
        'amount': amount,
        'service_id': id,
        'service_date': date
      };
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/expenses/'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
            'Content-Type': 'application/json'
          },
          body: json.encode(content));
      return request.statusCode == 200 ? 1 : 0;
    } catch (error) {
      return 0;
    }
  }

  static Future<String> updateUser(
      int id, String username, String phone, String password) async {
    try {
      final Map<String, dynamic> content = {
        "confirmationId": id,
        "username": username,
        "phone": phone,
        "password": password
      };
      final request = await client.patch(
          Uri.parse('https://dev-api.carcare.mn/v1/auth/update'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
            'Content-Type': 'application/json'
          },
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(request.body)['status']
          : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String> forgotPassword(int id, String password) async {
    try {
      final Map<String, dynamic> content = {
        "password": password,
        "confirmationId": id
      };
      final request = await client.post(
          Uri.parse('https://dev-api.carcare.mn/v1/auth/forgot'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(request.body)['status']
          : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<int> deleteExpense(int id) async {
    try {
      final request = await client.delete(
          Uri.parse('https://admin-dev.carcare.mn/api/expenses/$id/'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
          });
      return request.statusCode == 200 ? 1 : 0;
    } catch (error) {
      return 0;
    }
  }

  static Future<String> refreshToken() async {
    try {
      Map<String, String> content = {'refresh': Store.refresh};
      final request = await client.post(
          Uri.parse('https://admin-dev.carcare.mn/api/auth/refresh/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(content));
      return request.statusCode == 200
          ? json.decode(request.body)['access']
          : '';
    } catch (error) {
      return error.toString();
    }
  }

  static Future<List<dynamic>> serviceCategory() async {
    try {
      final request = await client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/categories/'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
          });
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))
          : [];
    } catch (error) {
      return [];
    }
  }

  static Future<List<dynamic>> filterShops(String service) async {
    try {
      final request = await client.get(
          Uri.parse(
              'https://admin-dev.carcare.mn/api/shopservices/?service=$service'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
          });
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))['results']
          : [];
    } catch (error) {
      return [error];
    }
  }

  static Future<List<dynamic>> serviceSubCategory() async {
    try {
      List<dynamic> category = [];
      int page = 1;
      while (page < 2) {
        final request = await client.get(
            Uri.parse('https://admin-dev.carcare.mn/api/services/?page=$page'),
            headers: {
              'Authorization': 'Bearer ${Store.accessToken}',
            });
        if (request.statusCode == 200) {
          List<dynamic> all =
              jsonDecode(utf8.decode(request.bodyBytes))['results'];
          category.addAll(all);
          page += 1;
        }
      }
      return category;
    } catch (error) {
      return [];
    }
  }

  static Future<List<dynamic>> serviceSubDir() async {
    try {
      List<dynamic> subcategory = [];
      int page = 1;
      while (page < 2) {
        final request = await client.get(
            Uri.parse(
                'https://admin-dev.carcare.mn/api/service-categories/?page=$page'),
            headers: {
              'Authorization': 'Bearer ${Store.accessToken}',
            });
        if (request.statusCode == 200) {
          List<dynamic> all =
              jsonDecode(utf8.decode(request.bodyBytes))['results'];
          subcategory.addAll(all);
          page += 1;
        }
      }
      return subcategory;
    } catch (error) {
      return [error];
    }
  }

  static Future<List<dynamic>> paginateShops(int page) async {
    try {
      final request = await client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/shops/?page=$page'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
          });
      return request.statusCode == 200
          ? json.decode(utf8.decode(request.bodyBytes))['results']
          : [];
    } catch (error) {
      return [error];
    }
  }

  static Future<List<dynamic>> fetchAllShops() async {
    List<dynamic> allShops = [];
    int page = 1;

    while (page <= 10) {
      final response = await client.get(
          Uri.parse('https://admin-dev.carcare.mn/api/shops/?page=$page'),
          headers: {
            'Authorization': 'Bearer ${Store.accessToken}',
          });
      if (response.statusCode == 200) {
        List<dynamic> all =
            jsonDecode(utf8.decode(response.bodyBytes))['results'];
        allShops.addAll(all);
        page += 1;
      }
    }
    return allShops;
  }
}
