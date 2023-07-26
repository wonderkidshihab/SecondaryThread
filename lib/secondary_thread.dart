import 'dart:isolate';

class SecondaryThread {
  static final ReceivePort receivePort = ReceivePort();
  static late SendPort sendPort;

  static Future<void> startIsolate() async {
    sendPort = receivePort.sendPort;
    await Isolate.spawn<SendPort>((port) {
      sendPort = port;
      sendPort.send(receivePort.sendPort);
      receivePort.asBroadcastStream().listen((event) {
        if (event is int) {
          sendPort.send(event + 1);
        }
      });
    }, sendPort);
  }

  static Future<void> send(int value) async {
    sendPort.send(value);
  }

  static void listenForData() {
    receivePort.listen((event) {
      if (event is int) {
        print("Received $event");
      }
    });
  }
}
