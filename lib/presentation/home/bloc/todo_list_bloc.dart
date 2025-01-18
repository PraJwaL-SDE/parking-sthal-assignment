import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListInitial()) {
    on<TodoListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
