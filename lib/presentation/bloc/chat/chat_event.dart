part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class LoadMessagesRequested extends ChatEvent {
  final String uid;

  LoadMessagesRequested({required this.uid});
}

final class SendMessageRequested extends ChatEvent {
  final String uid;
  final String text;

  SendMessageRequested({required this.uid, required this.text});
}

final class EraseMessagesRequested extends ChatEvent {
  final String uid;

  EraseMessagesRequested({required this.uid});
}

final class RemoveMessageRequested extends ChatEvent {
  final String uid;
  final String messageId;

  RemoveMessageRequested({required this.uid, required this.messageId});
}
