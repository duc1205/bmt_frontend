import 'package:main_app/modules/user/domain/models/user.dart';

class UserProfileChangedEvent {
  final User user;

  const UserProfileChangedEvent(this.user);
}
