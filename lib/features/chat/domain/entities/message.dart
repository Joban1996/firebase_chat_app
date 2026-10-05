class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timeStamp;

  Message({
    required this.id,
      required this.text,required this.senderId,required this.timeStamp});

}