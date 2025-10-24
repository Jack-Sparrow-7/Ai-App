class MessageEntity {
  final String? messageId;
  final String text;
  final String sender;
  final String? emotion;
  final DateTime timeStamp;

  MessageEntity({
    this.messageId,
    required this.text,
    required this.sender,
    this.emotion,
    required this.timeStamp,
  });
}
