import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';

import '../../../../components/app_cubit.dart';
part 'my_forum_state.dart';

class MyForumCubit extends AppCubit<MyForumState> {
  MyForumCubit() : super(MyForumState());

  @override
  void init() {
    loadData();
  }

  loadData() async {
    emit(state.copyWith(state..isLoading = true));

    var response = await client.myForum();

    emit(state.copyWith(state
      ..forums = response.data?.info
      ..isLoading = false));
  }

  @override
  void dispose() {
    emit(MyForumState());
  }
}
