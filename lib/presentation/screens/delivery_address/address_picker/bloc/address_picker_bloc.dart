import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/data/model/location_model.dart';
import 'package:littleshops/data/repository/location_repository/location_repository.dart';

import 'address_picker_event.dart';
import 'address_picker_state.dart';

class AddressPickerBloc extends Bloc<AddressPickerEvent, AddressPickerState> {
  LocationRepository _locationRepository = LocationRepository();

  AddressPickerBloc() : super(AddressPickerState());

  @override
  Stream<AddressPickerState> mapEventToState(AddressPickerEvent event) async* {
    if (event is InitialEvent) {
      yield* _mapInitialEventToState(event, state);
    } else if (event is LoadDistricts) {
      yield* _mapLoadDistrictsToState(event, state);
    } else if (event is LoadWards) {
      yield* _mapLoadWardsToState(event, state);
    }
  }

  Stream<AddressPickerState> _mapInitialEventToState(
      InitialEvent event,
      AddressPickerState state,
      ) async* {
    try {
      List<LocationModel> cities = await _locationRepository.fetchCities();
      List<LocationModel> districts = [];
      List<LocationModel> wards = [];
      if (event.cityId != null) {
        districts = await _locationRepository.fetchDistricts(event.cityId!);
      }
      if (event.districtId != null) {
        wards = await _locationRepository.fetchWards(event.districtId!);
      }
      yield state.cloneWith(
        cities: cities,
        districts: districts,
        wards: wards,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<AddressPickerState> _mapLoadDistrictsToState(
      LoadDistricts event,
      AddressPickerState state,
      ) async* {
    try {
      var districts = await _locationRepository.fetchDistricts(event.cityId);
      yield state.cloneWith(districts: districts, wards: []);
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<AddressPickerState> _mapLoadWardsToState(
      LoadWards event,
      AddressPickerState state,
      ) async* {
    try {
      var wards = await _locationRepository.fetchWards(event.districtId);
      yield state.cloneWith(wards: wards);
    } catch (e) {
      print(e.toString());
    }
  }
}
