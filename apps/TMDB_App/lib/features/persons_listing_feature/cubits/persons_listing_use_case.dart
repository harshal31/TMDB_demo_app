import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/features/persons_listing_feature/data/person_listing_api_service.dart';
import 'package:tmdb_app/features/search_feature/data/model/search_person_model.dart';
import 'package:tmdb_app/network/error_response.dart';
import 'package:tmdb_app/network/safe_api_call.dart';

class PersonListingUseCase {
  final PersonListingApiService _personListingApiService;

  PersonListingUseCase(this._personListingApiService);

  Future<Either<ErrorResponse, SearchPersonModel>> fetchPopularPersons(
    int page, {
    String language = ApiKey.defaultLanguage,
  }) async {
    final response = await apiCall(
      () => _personListingApiService.getPopularPersons(language, page),
    );
    return response.fold(
      (l) => left(l),
      (r) => right(r),
    );
  }
}

class PersonListingState with EquatableMixin {
  final PersonListingPaginationState personListingState;
  final int totalResults;

  PersonListingState({
    required this.personListingState,
    required this.totalResults,
  });

  factory PersonListingState.initial() {
    return PersonListingState(
      personListingState: PersonListingPaginationNone(),
      totalResults: 0,
    );
  }

  PersonListingState copyWith({
    PersonListingPaginationState? personListingState,
    int? totalResults,
  }) {
    return PersonListingState(
      personListingState: personListingState ?? this.personListingState,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  @override
  List<Object?> get props => [
        personListingState,
        totalResults,
      ];
}

sealed class PersonListingPaginationState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class PersonListingPaginationNone extends PersonListingPaginationState {}

class PersonListingPaginationLoading extends PersonListingPaginationState {}

class PersonListingPaginationLoaded extends PersonListingPaginationState {
  final SearchPersonModel model;
  final List<Persons> items;
  final bool hasReachedMax;

  PersonListingPaginationLoaded({
    required this.model,
    required this.items,
    this.hasReachedMax = false,
  });

  bool get shouldDisplayPages => (this.model.totalResults ?? 0) > 20;

  @override
  List<Object?> get props => [model, items, hasReachedMax];
}

class PersonListingPaginationError extends PersonListingPaginationState {
  final String error;

  PersonListingPaginationError(this.error);
}
