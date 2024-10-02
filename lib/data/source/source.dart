import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/location.dart';

import 'package:http/http.dart' as http;

import '../model/customer.dart';
import '../model/service.dart';

abstract interface class DataSource {
  Future<List<Helper>?> loadCleanerData();
  Future<List<Location>?> loadLocationData();
  Future<List<Services>?> loadServicesData();
  Future<List<Customer>?> loadCustomerData();
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
}
