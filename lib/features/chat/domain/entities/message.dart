class Message {
  final String id;
  final String senderId;
  final String chatId;
  final String text;
  final DateTime timeStamp;

  Message({
    required this.id,required this.chatId,
      required this.text,required this.senderId,required this.timeStamp});

}