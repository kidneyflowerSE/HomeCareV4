import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/requestdetail.dart';

import '../model/location.dart';
import '../model/service.dart';
import 'package:foodapp/data/source/source.dart';

abstract interface class Repository {
  Future<List<Helper>?> loadCleanerData();
  Future<List<Location>?> loadLocation();
  Future<List<Services>?> loadServices();
  Future<List<Customer>?> loadCustomer();
  Future<List<Request>?> loadRequest();
  Future<List<RequestDetail>?> loadRequestDetail();
}

class DefaultRepository implements Repository {
  final remoteDataSource = RemoteDataSource();
  final localDataSource = LocalDataSource();

  @override
  Future<List<Helper>?> loadCleanerData() async {
    List<Helper> cleaners = [];
    await remoteDataSource.loadCleanerData().then((remoteCleaner) {
      if (remoteCleaner == null) {
        localDataSource.loadCleanerData().then((localCleaners) {
          if (localCleaners != null) {
            cleaners.addAll(localCleaners);
          }
        });
      } else {
        cleaners.addAll(remoteCleaner);
      }
    });
    return cleaners;
  }

  @override
  Future<List<Location>?> loadLocation() async {
    List<Location> locations = [];
    await remoteDataSource.loadLocationData().then((remoteLocation) {
      if (remoteLocation == null) {
        localDataSource.loadLocationData().then((localLocation) {
          if (localLocation != null) {
            locations.addAll(localLocation);
          }
        });
      } else {
        locations.addAll(remoteLocation);
      }
    });
    return locations;
  }

  @override
  Future<List<Customer>?> loadCustomer() async {
    List<Customer> customers = [];
    await remoteDataSource.loadCustomerData().then((remoteCustomer) {
      if (remoteCustomer == null) {
        localDataSource.loadCustomerData().then((localCustomer) {
          if (localCustomer != null) {
            customers.addAll(localCustomer);
          }
        });
      } else {
        customers.addAll(remoteCustomer);
      }
    });
    return customers;
  }

  @override
  Future<List<Services>?> loadServices() async {
    List<Services> services = [];
    await remoteDataSource.loadServicesData().then((remoteServices) {
      if (remoteServices == null) {
        localDataSource.loadServicesData().then((localServices) {
          if (localServices != null) {
            services.addAll(localServices);
          }
        });
      } else {
        services.addAll(remoteServices);
      }
    });
    return services;
  }

  @override
  Future<List<Request>?> loadRequest() async {
    List<Request> requests = [];
    await remoteDataSource.loadRequestData().then((remoteRequests) {
      if (remoteRequests == null) {
        localDataSource.loadRequestData().then((localRequests) {
          if (localRequests != null) {
            requests.addAll(localRequests);
          }
        });
      } else {
        requests.addAll(remoteRequests);
      }
    });
    return requests;
  }

  @override
  Future<List<RequestDetail>?> loadRequestDetail() async {
    List<RequestDetail>? requestDetail = [];
    await remoteDataSource.loadRequestDetailData().then((remoteRequestDetail) {
      if (remoteRequestDetail == null) {
        localDataSource.loadRequestDetailData().then((localRequestDetail) {
          if (localRequestDetail != null) {
            requestDetail.addAll(localRequestDetail);
          }
        });
      } else {
        requestDetail.addAll(remoteRequestDetail);
      }
    });
    return requestDetail;
  }
}
