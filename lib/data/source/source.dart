import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/location.dart';
import 'package:foodapp/data/model/requestdetail.dart';

import 'package:http/http.dart' as http;

import '../model/customer.dart';
import '../model/request.dart';
import '../model/service.dart';

abstract interface class DataSource {
  Future<List<Helper>?> loadCleanerData();

  Future<List<Location>?> loadLocationData();

  Future<List<Services>?> loadServicesData();

  Future<List<Customer>?> loadCustomerData();

  Future<List<Request>?> loadRequestData();

  Future<List<RequestDetail>?> loadRequestDetailData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Helper>?> loadCleanerData() async {
    const url = 'https://homecareapi.vercel.app/api/helper';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> cleanerList = jsonDecode(bodyContent);
      return cleanerList.map((cleaner) => Helper.fromJson(cleaner)).toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<Location>?> loadLocationData() async {
    const url = 'https://homecareapi.vercel.app/api/location';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> locationList = jsonDecode(bodyContent);
      return locationList
          .map((location) => Location.fromJson(location))
          .toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<Customer>?> loadCustomerData() async {
    const url = 'https://homecareapi.vercel.app/api/customer';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> customerList = jsonDecode(bodyContent);
      return customerList
          .map((customer) => Customer.fromJson(customer))
          .toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<Services>?> loadServicesData() async {
    const url = 'https://homecareapi.vercel.app/api/service';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> servicesList = jsonDecode(bodyContent);
      return servicesList
          .map((services) => Services.fromJson(services))
          .toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<Request>?> loadRequestData() async {
    const url = 'https://homecareapi.vercel.app/api/request';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> requestList = jsonDecode(bodyContent);
      return requestList.map((request) => Request.fromJson(request)).toList();
    } else {
      return null;
    }
  }

  @override
  Future<List<RequestDetail>?> loadRequestDetailData() async {
    const url = 'https://homecareapi.vercel.app/api/request';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> requestList = jsonDecode(bodyContent);

      List<String> requestIds = [];

      for (var request in requestList) {
        Request req = Request.fromJson(request);
        if (req.scheduleIds.isNotEmpty) {
          requestIds.addAll(req.scheduleIds);
        }
      }
      return await loadRequestDetailId(requestIds);
    } else {
      return null;
    }
  }

  Future<List<RequestDetail>?> loadRequestDetailId(List<String> id) async {
    final String idString = id.join(',');
    String url =
        'https://homecareapi.vercel.app/api/requestDetail?ids=$idString';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final List<dynamic> detailsList = jsonDecode(bodyContent);
      return detailsList
          .map((detail) => RequestDetail.fromJson(detail))
          .toList();
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Helper>?> loadCleanerData() async {
    final String response = await rootBundle.loadString('assets/cleaners.json');
    final List<dynamic> cleanerList = jsonDecode(response);
    return cleanerList.map((cleaner) => Helper.fromJson(cleaner)).toList();
  }

  @override
  Future<List<Location>?> loadLocationData() async {
    final String response = await rootBundle.loadString('assets/location.json');
    final List<dynamic> locationList = jsonDecode(response);
    return locationList.map((location) => Location.fromJson(location)).toList();
  }

  @override
  Future<List<Customer>?> loadCustomerData() async {
    final String response = await rootBundle.loadString('assets/customer.json');
    final List<dynamic> customerList = jsonDecode(response);
    return customerList.map((customer) => Customer.fromJson(customer)).toList();
  }

  @override
  Future<List<Services>?> loadServicesData() async {
    final String response = await rootBundle.loadString('assets/services.json');
    final List<dynamic> servicesList = jsonDecode(response);
    return servicesList.map((services) => Services.fromJson(services)).toList();
  }

  @override
  Future<List<Request>?> loadRequestData() async {
    final String response = await rootBundle.loadString('assets/request.json');
    final List<dynamic> requestList = jsonDecode(response);
    return requestList.map((request) => Request.fromJson(request)).toList();
  }

  @override
  Future<List<RequestDetail>?> loadRequestDetailData() async {
    final String response = await rootBundle.loadString('assets/customer.json');
    final List<dynamic> requestDetailList = jsonDecode(response);
    return requestDetailList
        .map((detail) => RequestDetail.fromJson(detail))
        .toList();
  }
}
