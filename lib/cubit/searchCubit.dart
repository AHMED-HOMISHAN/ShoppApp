// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/models/searchModel.dart';
import 'package:shopapp/network/API/API.dart';
import 'package:shopapp/network/API/endPoints.dart';
import 'package:shopapp/states/searchStates.dart';

class SearchCubit extends Cubit<AppSearchStates> {
  SearchCubit() : super(AppSearchIntialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchDataModel? searchModel;

  void searchData(String text) {
    emit(AppSearchLoadingState());

    DioHelper.postData(
            url: SEARCH, token: token, data: {'text': text}, lang: 'en')
        .then((value) {
      searchModel = SearchDataModel.fromJson(value.data);
      emit(AppSearchSuccessState());
    }).catchError((error) {
      emit(AppSearchErrorState(error.toString()));
    });
  }
}
