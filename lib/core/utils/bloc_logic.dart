import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class BlocLogic<T extends StateStreamableSource> {
  T call() {
    return BlocProvider.of<T>(navigatorKey.currentContext!);
  }
}
