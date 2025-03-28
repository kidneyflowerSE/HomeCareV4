import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/F.A.Q.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/message.dart';
import 'package:foodapp/data/model/Policy.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/requestdetail.dart';

import '../model/TimeOff.dart';
import '../model/coefficient.dart';
import '../model/location.dart';
import '../model/service.dart';
import 'package:foodapp/data/source/source.dart';

abstract interface class Repository {
  Future<List<Helper>?> loadCleanerData();

  Future<List<Location>?> loadLocation();

  Future<List<Services>?> loadServices();

  Future<List<Customer>?> loadCustomer();

  Future<void> updateCustomer(Customer customer);

  Future<List<Requests>?> loadRequest();

  Future<List<Policy>?> loadPolicy();

  Future<List<FAQ>?> loadFAQ();

  Future<List<RequestDetail>?> loadRequestDetail();

  Future<List<RequestDetail>?> loadRequestDetailId(List<String> id);

  Future<List<TimeOff>?> loadTimeOff();

  Future<void> sendRequest(Requests requests);

  Future<void> canceledRequest(String id);

  Future<void> payRequest(String id);

  Future<void> doneConfirmRequest(String id);

  Future<void> sendMessage(String phone);

  Future<List<Message>?> loadMessage(Message message);

  Future<List<CostFactor>?> loadCostFactor();

  Future<CoefficientOther?> loadCoefficientOther();

  Future<List<CoefficientOther>?> loadCoefficientService();

  Future<Map<String, dynamic>?> calculateCost(
      num servicePrice,
      String startTime,
      String endTime,
      String startDate,
      CoefficientOther coefficientOther,
      num serviceFactor);

  Future<void> sendCustomerRegisterRequest(Customer customer);
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
  Future<void> updateCustomer(Customer customer) async {
    await remoteDataSource.updateCustomerInfo(customer);
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
  Future<List<Message>?> loadMessage(Message message) async {
    return await remoteDataSource.loadMessageData(message);
  }

  @override
  Future<void> sendMessage(String phone) async {
    return await remoteDataSource.sendMessage(phone);
  }

  @override
  Future<List<CostFactor>?> loadCostFactor() async {
    return await remoteDataSource.loadCostFactorData();
  }

  @override
  Future<List<Policy>?> loadPolicy() async {
    return await remoteDataSource.loadPolicy();
  }

  @override
  Future<List<FAQ>?> loadFAQ() async {
    return await remoteDataSource.loadFAQ();
  }

  @override
  Future<void> canceledRequest(String id) async {
    return await remoteDataSource.cancelRequest(id);
  }

  @override
  Future<void> payRequest(String id) async {
    return await remoteDataSource.paymentRequest(id);
  }

  @override
  Future<void> doneConfirmRequest(String id) async {
    return await remoteDataSource.paymentRequest(id);
  }

  @override
  Future<Map<String, dynamic>?> calculateCost(
      num servicePrice,
      String startTime,
      String endTime,
      String startDate,
      CoefficientOther coefficientOther,
      num serviceFactor) async {
    return await remoteDataSource.calculateCost(servicePrice, startTime,
        endTime, startDate, coefficientOther, serviceFactor);
  }

  @override
  Future<CoefficientOther?> loadCoefficientOther() async {
    return await remoteDataSource.loadCoefficientOther();
  }

  @override
  Future<List<CoefficientOther>?> loadCoefficientService() async {
    return await remoteDataSource.loadCoefficientService();
  }

  @override
  Future<List<RequestDetail>?> loadRequestDetailId(List<String> id) async {
    return await remoteDataSource.loadRequestDetailId(id);
  }

  @override
  Future<void> sendCustomerRegisterRequest(Customer customer) async {
    return await remoteDataSource.sendCustomerRegisterRequest(customer);
  }
}
