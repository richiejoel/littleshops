import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:littleshops/configs/application.dart';
import 'package:littleshops/constants/util_constants.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/repository/business_repository/business_repository.dart';
import 'package:littleshops/data/repository/storage_repository/storage_repository.dart';
import 'package:littleshops/data/repository/user_repository/user_repository.dart';
import 'package:littleshops/presentation/common_blocs/business/bloc.dart';
import 'package:uuid/uuid.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {

  BusinessRepository _businessRepository = BusinessRepository();
  AuthRepository _authRepository = AuthRepository();
  StorageRepository _storageRepository = StorageRepository();
  UserRepository _userRepository = UserRepository();
  BusinessBloc(): super(BusinessLoading());

  @override
  Stream<BusinessState> mapEventToState(BusinessEvent event) async* {
    if(event is LoadBusiness){
      yield* _mapLoadBusinessToState(event);
    } else if( event is AddBusiness){
      yield* _mapAddBusinessToState(event);
    }
  }

  Stream<BusinessState> _mapLoadBusinessToState(LoadBusiness event) async* {
    try {
      var loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      List<BusinessModel> allBusiness = await _businessRepository.fetchAllBusiness();
      List<BusinessModel> businessByChief = await _businessRepository
          .fetchBusinessByChief(loggedFirebaseUser.uid);

      yield BusinessLoaded(
          allBusiness: allBusiness,
          businessByChief: businessByChief
      );

    } catch(e){
      yield BusinessLoadFailure(e.toString());
    }
  }

  Stream<BusinessState> _mapAddBusinessToState(AddBusiness event) async* {
    try {
      BusinessModel addBusiness = event.newBusinessModel;
      Application app = Application();
      Position position = await app.determinePosition();
      String chiefID = _authRepository.loggedFirebaseUser.uid;
      String imageUrl = await _storageRepository.uploadImageFile(
        "business/${Uuid().v1()}",
        event.image,
      );
      var newBusiness = event.newBusinessModel
          .cloneWith(
            chiefId: chiefID,
            name: addBusiness.name,
            description: addBusiness.description,
            imageUrl: imageUrl,
            longitude: position.longitude,
            latitude: position.latitude,
          );
      await _businessRepository.addBusinessByChief(newBusiness);
      await _userRepository.updateOneDataUser(chiefID, UTIL_CONST.ROLE, UTIL_CONST.CHIEF);

    } catch (e){
      print(e.toString());
    }
  }

}