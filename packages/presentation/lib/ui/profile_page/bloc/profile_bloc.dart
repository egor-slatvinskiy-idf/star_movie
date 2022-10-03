import 'package:presentation/base/bloc.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/profile_page/bloc/profile_tile.dart';

abstract class ProfileBloc extends Bloc<BaseArguments, ProfileTile> {
  factory ProfileBloc() => ProfileBlocImpl();
}

class ProfileBlocImpl extends BlocImpl<BaseArguments, ProfileTile>
    implements ProfileBloc {
  ProfileBlocImpl();

  @override
  void initState() {
    super.initState();
  }
}
