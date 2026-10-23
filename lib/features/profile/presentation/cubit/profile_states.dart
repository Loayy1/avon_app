import '../../data/models/user_profile_model.dart';

abstract class ProfileStates {}

class ProfileInitialStates extends ProfileStates {}

class ProfileLoadingStates extends ProfileStates {}

class ProfileSuccessStates extends ProfileStates {
  final UserProfileModel? profile;

  ProfileSuccessStates({this.profile});
}

class ProfileFailedStates extends ProfileStates {}

class ProfileLogoutSuccessStates extends ProfileStates {}
