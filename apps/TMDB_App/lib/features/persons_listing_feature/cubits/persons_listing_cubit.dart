import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/persons_listing_feature/cubits/persons_listing_use_case.dart';

class PersonListingCubit extends Cubit<PersonListingState> {
  final PersonListingUseCase personListingUseCase;
  final int _pageSize = 20;

  PersonListingCubit(this.personListingUseCase) : super(PersonListingState.initial());

  void fetchPopularPersons(int page) async {
    if (state.personListingState is PersonListingPaginationLoaded &&
        (state.personListingState as PersonListingPaginationLoaded).hasReachedMax) {
      return;
    }

    if (page == 1) {
      emit(state.copyWith(personListingState: PersonListingPaginationLoading()));
    }

    final persons = await personListingUseCase.fetchPopularPersons(page);
    persons.fold(
      (l) {
        emit(
          state.copyWith(
            personListingState: PersonListingPaginationError(l.errorMessage),
          ),
        );
      },
      (r) {
        final isLastPage = (r.persons?.length ?? 0) < _pageSize;

        emit(
          state.copyWith(
            totalResults: r.totalResults ?? 0,
            personListingState: PersonListingPaginationLoaded(
              items: r.persons ?? [],
              hasReachedMax: isLastPage,
              model: r,
            ),
          ),
        );
      },
    );
  }
}
