import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final subscriptions = CompositeSubscription();
  final hideKeyboardSubject = PublishSubject<bool>();

  void dispose() {
    subscriptions.clear();
    hideKeyboardSubject.close();
  }
}
