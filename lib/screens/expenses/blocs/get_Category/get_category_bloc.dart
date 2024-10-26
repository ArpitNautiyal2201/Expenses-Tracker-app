import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository_expenses/repository_expenses.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoiesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  ExpenseRepository expenseRepository;
  GetCategoiesBloc(this.expenseRepository) : super(GetCategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      emit(GetCategoriesLoading());
      try {
        List<Category> categories = await expenseRepository.getCategory();
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesFailure());
      }
    });
  }
}
