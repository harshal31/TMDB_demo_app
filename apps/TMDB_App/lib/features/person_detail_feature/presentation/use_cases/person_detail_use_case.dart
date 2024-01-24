import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail_model.dart';
import 'package:tmdb_app/features/person_detail_feature/data/person_detail_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class PersonDetailUseCase {
  final PersonDetailApiService _personDetailApiService;

  const PersonDetailUseCase(this._personDetailApiService);

  Future<Either<ErrorResponse, PersonDetailModel>> fetchPersonDetails(
    String typeId, {
    String language = ApiKey.defaultLanguage,
  }) async {
    PersonDetailModel personDetailModel = PersonDetailModel(mapping: {});
    final response = await apiCall(
      () => _personDetailApiService.fetchPersonDetail(
        typeId,
        language,
        ApiKey.personDetailAppendToMediaResponse,
      ),
    );

    return response.fold((l) => left(l), (r) {
      personDetailModel = personDetailModel.copyWith(
        crews: r?.credits?.crew,
        casts: r?.credits?.cast,
        personDetail: r,
        tmdbShare: r?.mediaExternalIds,
      );
      personDetailModel = personDetailModel.copyWith(mapping: personDetailModel.getMapping());

      return right(personDetailModel);
    });
  }
}

class PersonDetailState with EquatableMixin {
  final PersonDetailModel personDetailModel;
  final PersonDetailStatus personDetailStatus;

  PersonDetailState(this.personDetailModel, this.personDetailStatus);

  factory PersonDetailState.initial() {
    return PersonDetailState(
      PersonDetailModel(mapping: {}),
      PersonDetailNone(),
    );
  }

  PersonDetailState copyWith({
    PersonDetailModel? personDetailModel,
    PersonDetailStatus? personDetailStatus,
  }) {
    return PersonDetailState(
      personDetailModel ?? this.personDetailModel,
      personDetailStatus ?? this.personDetailStatus,
    );
  }

  @override
  List<Object?> get props => [
        personDetailModel,
        personDetailStatus,
      ];
}

sealed class PersonDetailStatus with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class PersonDetailNone extends PersonDetailStatus {}

class PersonDetailLoading extends PersonDetailStatus {}

class PersonDetailFailed extends PersonDetailStatus {
  final String errorMessage;

  PersonDetailFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PersonDetailSuccess extends PersonDetailStatus {}
