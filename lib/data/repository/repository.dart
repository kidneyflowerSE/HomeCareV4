import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/message.dart';
import 'package:foodapp/data/model/policy.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/requestdetail.dart';

import '../model/TimeOff.dart';
import '../model/location.dart';
import '../model/service.dart';
import 'package:foodapp/data/source/source.dart';

abstract interface class Repository {
  Future<List<Helper>?> loadCleanerData();

  Future<List<Location>?> loadLocation();

  Future<List<Services>?> loadServices();

  Future<List<Customer>?> loadCustomer();

  Future<List<Requests>?> loadRequest();

  Future<List<Policy>?> loadPolicy();

  Future<List<RequestDetail>?> loadRequestDetail();

  Future<List<TimeOff>?> loadTimeOff();

  Future<void> sendRequest(Requests requests);

  Future<void> sendMessage(String phone);

  Future<List<Message>?> loadMessage(Message message);
}

class DefaultRepository implements Repository {
  final remoteDataSource = RemoteDataSource();

  @override
  Future<List<Helper>?> loadCleanerData() async {
    return await remoteDataSource.loadCleanerData();
  }

  @override
  Future<List<Location>?> loadLocation() async {
    return await remoteDataSource.loadLocationData();
  }

  @override
  Future<List<Customer>?> loadCustomer() async {
    return await remoteDataSource.loadCustomerData();
  }

  @override
  Future<List<Services>?> loadServices() async {
    return await remoteDataSource.loadServicesData();
  }

  @override
  Future<List<Requests>?> loadRequest() async {
    return await remoteDataSource.loadRequestData();
  }

  @override
  Future<List<RequestDetail>?> loadRequestDetail() async {
    return await remoteDataSource.loadRequestDetailData();
  }

  @override
  Future<void> sendRequest(Requests request) async {
    await remoteDataSource.sendRequests(request);
  }

  @override
  Future<List<TimeOff>?> loadTimeOff() async {
    return await remoteDataSource.loadTimeOffData();
  }

  @override
  Future<List<Message>?> loadMessage(Message message) async{
    return await remoteDataSource.loadMessageData(message);
  }

  @override
  Future<void> sendMessage(String phone) async{
    return await remoteDataSource.sendMessage(phone);
  }

  @override
  Future<List<Policy>?> loadPolicy() async{
    return await remoteDataSource.loadPolicy();
  }
}
