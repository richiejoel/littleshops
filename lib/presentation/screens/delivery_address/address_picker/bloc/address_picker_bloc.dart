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

  List<LocationModel> provincias(){
    List<LocationModel> pronvincias = [
      LocationModel(id: "1", name: "Guayas"),
      LocationModel(id: "2", name: "Manabí"),
      LocationModel(id: "3", name: "Esmeraldas"),
      LocationModel(id: "4", name: "El Oro"),
      LocationModel(id: "5", name: "Santa Elena"),
      LocationModel(id: "6", name: "Los Ríos"),
      LocationModel(id: "7", name: "Azuay"),
      LocationModel(id: "8", name: "Bolívar"),
      LocationModel(id: "9", name: "Pichincha"),
      LocationModel(id: "10", name: "Cotopaxi"),
      LocationModel(id: "11", name: "Loja"),

    ];
    return pronvincias;
  }

  List<LocationModel> ciudades(){
    List<LocationModel> ciudades = [
      LocationModel(id: "1", name: "Cuenca"),
      LocationModel(id: "2", name: "Portoviejp"),
      LocationModel(id: "3", name: "Esmeraldas"),
      LocationModel(id: "4", name: "Guayaquil"),
      LocationModel(id: "5", name: "Quito"),
      LocationModel(id: "6", name: "Salinas"),
      LocationModel(id: "7", name: "San Lorenzo"),
      LocationModel(id: "8", name: "Rio Verde"),
      LocationModel(id: "9", name: "Durán"),
      LocationModel(id: "10", name: "Balzar"),
      LocationModel(id: "11", name: "Nobol"),
      LocationModel(id: "12", name: "Jipijapa"),
      LocationModel(id: "13", name: "El Carmen"),
      LocationModel(id: "14", name: "Manta"),
      LocationModel(id: "15", name: "Daule"),
      LocationModel(id: "16", name: "Colimes"),
      LocationModel(id: "17", name: "Milagro"),
      LocationModel(id: "18", name: "El triunfo"),
      LocationModel(id: "19", name: "Naranjal"),
      LocationModel(id: "20", name: "Naranjito"),
      LocationModel(id: "21", name: "Samborondón"),
      LocationModel(id: "22", name: "Santa Lucía"),

    ];
    return ciudades;
  }

  List<LocationModel> parroquias(){
    List<LocationModel> parroquias = [
      LocationModel(id: "1", name: "Tarqui"),
      LocationModel(id: "2", name: "Urdaneta"),
      LocationModel(id: "3", name: "Pascuales"),
      LocationModel(id: "4", name: "Chongon"),
      LocationModel(id: "5", name: "Rocafuerte"),
      LocationModel(id: "6", name: "Playas"),
      LocationModel(id: "7", name: "Puna"),
      LocationModel(id: "8", name: "Posorja"),
      LocationModel(id: "9", name: "Muisne"),
      LocationModel(id: "10", name: "San Gregorio"),
      LocationModel(id: "11", name: "La Tola"),
      LocationModel(id: "12", name: "Atacames"),
      LocationModel(id: "13", name: "San Mateo"),
      LocationModel(id: "14", name: "Cochapamba"),
      LocationModel(id: "15", name: "La Argelia"),
      LocationModel(id: "16", name: "Calacalí"),
      LocationModel(id: "17", name: "Cotocollao"),
      LocationModel(id: "18", name: "Kennedy"),
      LocationModel(id: "19", name: "Tambillo"),
      LocationModel(id: "20", name: "Abdón Calderón"),
      LocationModel(id: "21", name: "Crucita"),
      LocationModel(id: "22", name: "San Placido"),
      LocationModel(id: "23", name: "Calceta"),
      LocationModel(id: "24", name: "San Pablo"),
      LocationModel(id: "25", name: "Simón Bolívar"),
      LocationModel(id: "26", name: "Chirijos"),
      LocationModel(id: "27", name: "Ricchico"),
      LocationModel(id: "28", name: "Pueblo nuevo"),
      LocationModel(id: "29", name: "García Moreno"),
      LocationModel(id: "30", name: "Roca"),
      LocationModel(id: "31", name: "Nueve de Octubre"),
      LocationModel(id: "32", name: "Balzar"),
      LocationModel(id: "33", name: "Laurel"),
      LocationModel(id: "34", name: "Santa Clara"),
      LocationModel(id: "35", name: "Limonal"),

    ];
    return parroquias;
  }

  Stream<AddressPickerState> _mapInitialEventToState(
      InitialEvent event,
      AddressPickerState state,
      ) async* {
    try {
      //List<LocationModel> cities = await _locationRepository.fetchCities();
      List<LocationModel> cities = provincias();
      List<LocationModel> districts = [];
      List<LocationModel> wards = [];
      if (event.cityId != null) {
        //districts = await _locationRepository.fetchDistricts(event.cityId!);
        districts = ciudades();
      }
      if (event.districtId != null) {
        //wards = await _locationRepository.fetchWards(event.districtId!);
        wards = parroquias();
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
      //var districts = await _locationRepository.fetchDistricts(event.cityId);
      var districts = ciudades();
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
      //var wards = await _locationRepository.fetchWards(event.districtId);
      var wards = parroquias();
      yield state.cloneWith(wards: wards);
    } catch (e) {
      print(e.toString());
    }
  }
}
