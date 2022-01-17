import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HealthAiFirebaseUser {
  HealthAiFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

HealthAiFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HealthAiFirebaseUser> healthAiFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<HealthAiFirebaseUser>(
            (user) => currentUser = HealthAiFirebaseUser(user));
