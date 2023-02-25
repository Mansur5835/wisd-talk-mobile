import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import '../../../components/app_cubit.dart';

part 'forum_state.dart';

class ForumCubit extends AppCubit<ForumState> {
  ForumCubit() : super(ForumState());
  String? id;

  @override
  void init() {
    id = args.get["id"];

    emit(state.copyWith(state..name = args.get["name"]));
    loadData();
  }

  loadData() async {
    emit(state.copyWith(state..isLoading = true));

    var response = await client.forums(categoryId: id);

    emit(state.copyWith(state
      ..isLoading = false
      ..forums = response.data?.info));
  }

  @override
  void dispose() {
    emit(ForumState());
  }
}
