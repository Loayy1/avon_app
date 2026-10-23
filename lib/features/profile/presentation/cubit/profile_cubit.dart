import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../views/widgets/customes_widget.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepository repository;

  ProfileCubit({ProfileRepository? profileRepository})
      : repository = profileRepository ??
            ProfileRepositoryImpl(remoteDataSource: ProfileRemoteDataSourceImpl()),
        super(ProfileInitialStates());

  UserProfileModel? userProfile;

  final list = [
    ProfileModel(title: "Edit Info", img: "assets/icons/edit_info.svg"),
    ProfileModel(title: "Order History", img: "assets/icons/order_history.svg"),
    ProfileModel(title: "Wallet", img: "assets/icons/wallet.svg"),
    ProfileModel(title: "Settings", img: "assets/icons/settings.svg"),
    ProfileModel(title: "Voucher ", img: "assets/icons/voucher .svg"),
  ];

  Future<void> getData() async {
    emit(ProfileLoadingStates());
    try {
      final profile = await repository.getProfile();
      userProfile = profile;
      emit(ProfileSuccessStates(profile: profile));
    } catch (_) {
      emit(ProfileSuccessStates(profile: null));
    }
  }

  Future<bool> logout() async {
    final success = await repository.logout();
    if (success) {
      emit(ProfileLogoutSuccessStates());
    }
    return success;
  }
}
