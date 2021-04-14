import '../model/materi_detail_model.dart';
import 'package:meta/meta.dart';

abstract class MateriDetailState {}

class MateriDetailEmpty extends MateriDetailState {}

class MateriDetailLoading extends MateriDetailState {}

class MateriDetailLoaded extends MateriDetailState {
  final List<MateriDetailModel> materiDetailList;

  MateriDetailLoaded({@required this.materiDetailList});
}

class MateriDetailError extends MateriDetailState {
  final String message;

  MateriDetailError({@required this.message});
}

abstract class AddMateriDetailState {}

class AddMateriDetailEmpty extends AddMateriDetailState {}

class AddMateriDetailLoading extends AddMateriDetailState {}

class AddMateriDetailSuccess extends AddMateriDetailState {
  final String message;

  AddMateriDetailSuccess({@required this.message});
}

class AddMateriDetailError extends AddMateriDetailState {
  final String message;

  AddMateriDetailError({@required this.message});
}

