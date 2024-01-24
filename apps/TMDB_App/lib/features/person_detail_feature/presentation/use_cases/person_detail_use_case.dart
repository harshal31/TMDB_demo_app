import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/movie_detail_feature/data/model/media_external_id.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_credit.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail.dart';
import 'package:tmdb_app/features/person_detail_feature/data/model/person_detail_model.dart';
import 'package:tmdb_app/features/person_detail_feature/data/person_detail_api_service.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';
import 'package:tmdb_app/utils/either_extensions.dart';

class PersonDetailUseCase {
  final PersonDetailApiService _personDetailApiService;

  const PersonDetailUseCase(this._personDetailApiService);

  Future<Either<ErrorResponse, PersonDetailModel>> fetchPersonDetails(
    String typeId, {
    String language = ApiKey.defaultLanguage,
  }) async {
    PersonDetailModel personDetailModel = PersonDetailModel(mapping: {});
    final response = await Future.wait(
      [
        apiCall(
          () => _personDetailApiService.fetchPersonCredits(typeId, ApiKey.combineCredits, language),
        ),
        apiCall(
          () => _personDetailApiService.fetchPersonDetail(typeId, language),
        ),
        apiCall(
          () => _personDetailApiService.fetchMediaExternalIds(ApiKey.person, typeId, language),
        ),
      ],
    );

    personDetailModel = personDetailModel.copyWith(
      crews: (response[0] as Either<ErrorResponse, PersonCredit?>).getRightOrNull?.crew,
      casts: (response[0] as Either<ErrorResponse, PersonCredit?>).getRightOrNull?.cast,
      personDetail: (response[1] as Either<ErrorResponse, PersonDetail?>).getRightOrNull,
      tmdbShare: (response[2] as Either<ErrorResponse, MediaExternalId?>).getRightOrNull,
    );
    personDetailModel = personDetailModel.copyWith(mapping: personDetailModel.getMapping());

    if (personDetailModel.isPersonDetailFetchFailed()) {
      return left(ErrorResponse(errorCode: -1, errorMessage: "Not able to fetch movie credits"));
    }

    return right(personDetailModel);
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
