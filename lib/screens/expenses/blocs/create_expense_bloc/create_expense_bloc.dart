import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository_expenses/repository_expenses.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  ExpenseRepository expenseRepository;

  CreateExpenseBloc(this.expenseRepository) : super(CreateExpenseInitial()) {
    on<CreateExpense>((event, emit) async {
      emit(CreateExpenseLoading());
      try {
        await expenseRepository.createExpense(event.expense);
        emit(CreateExpenseSuccess());
      } catch (e) {
        emit(CreateExpenseFailure());
      }
    });
  }
}
