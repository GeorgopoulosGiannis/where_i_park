import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/core/data/models/car_location_model.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/services/storage_manager.dart';

@lazySingleton
class GetAllLocations {
  final StorageManager mgr;

  GetAllLocations(this.mgr);

  Future<List<CarLocation>> call() async {
    final locs = await mgr.getListByKey(Constants.carLocations);

    return locs.map((l) => CarLocationModel.fromJson(l)).toList();
  }
}
