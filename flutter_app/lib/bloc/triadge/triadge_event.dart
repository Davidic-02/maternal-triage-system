part of 'triadge_bloc.dart';

@freezed
abstract class TriadgeEvent with _$TriadgeEvent {
  const factory TriadgeEvent.onClicked() = _Onclicked;
}
