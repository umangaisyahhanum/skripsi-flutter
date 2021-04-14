import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:simplilearn/feature/class/bloc/class_bloc.dart';
import 'package:simplilearn/feature/class/repository/class_repository.dart';
import 'package:simplilearn/feature/enrollemt/bloc/enrollment_bloc.dart';
import 'package:simplilearn/feature/enrollemt/repository/enrollment_repository.dart';
import 'package:simplilearn/feature/home/bloc/home_bloc.dart';
import 'package:simplilearn/feature/home/repository/home_repository.dart';
import 'package:simplilearn/feature/login/bloc/login_bloc.dart';
import 'package:simplilearn/feature/login/repository/login_repository.dart';
import 'package:simplilearn/feature/materi_detail/bloc/materi_detail_bloc.dart';
import 'package:simplilearn/feature/materi_detail/repository/materi_detail_repository.dart';
import 'package:simplilearn/feature/module/bloc/module_bloc.dart';
import 'package:simplilearn/feature/module/repository/module_repository.dart';
import 'package:simplilearn/feature/quiz/bloc/quiz_bloc.dart';
import 'package:simplilearn/feature/quiz/repository/quiz_repository.dart';
import 'package:simplilearn/feature/quiz_detail/bloc/quiz_detail_bloc.dart';
import 'package:simplilearn/feature/quiz_detail/repository/quiz_detail_repository.dart';
import 'package:simplilearn/feature/register/bloc/register_bloc.dart';
import 'package:simplilearn/feature/register/repository/register_repository.dart';
import 'package:simplilearn/feature/task/bloc/task_bloc.dart';
import 'package:simplilearn/feature/task/repository/task_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //login

  sl.registerFactory(
    () => LoginBloc(loginRepository: sl()),
  );

  sl.registerLazySingleton(() => LoginRepository(client: sl()));

  //register

  sl.registerFactory(
    () => RegisterBloc(registerRepository: sl()),
  );

  sl.registerLazySingleton(() => RegisterRepository(client: sl()));

  //home

  sl.registerFactory(
    () => HomeBloc(homeRepository: sl()),
  );

  sl.registerLazySingleton(() => HomeRepository(client: sl()));

  //enrollment

  sl.registerFactory(
    () => EnrollmentBloc(enrollmentRepository: sl()),
  );

  sl.registerLazySingleton(() => EnrollmentRepository(client: sl()));

  //class

  sl.registerFactory(
    () => ClassBloc(classRepository: sl()),
  );

  sl.registerLazySingleton(() => ClassRepository(client: sl()));

  //module

  sl.registerFactory(
    () => ModuleBloc(moduleRepository: sl()),
  );

  sl.registerLazySingleton(() => ModuleRepository(client: sl()));

  //materi

  sl.registerFactory(
    () => MateriDetailBloc(materiDetailRepository: sl()),
  );

  sl.registerLazySingleton(() => MateriDetailRepository(client: sl()));

  //task

  sl.registerFactory(
    () => TaskBloc(taskRepository: sl()),
  );

  sl.registerLazySingleton(() => TaskRepository(client: sl()));

  //quiz

  sl.registerFactory(
    () => QuizBloc(quizRepository: sl()),
  );

  sl.registerLazySingleton(() => QuizRepository(client: sl()));

  //quiz

  sl.registerFactory(
    () => QuizDetailBloc(quizDetailRepository: sl()),
  );

  sl.registerLazySingleton(() => QuizDetailRepository(client: sl()));

  //client
  sl.registerLazySingleton(() => http.Client());
}
