import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  var flp = FlutterLocalNotificationsPlugin();

  Future<void> kurulum() async {
    var androidAyari = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosAyari = const DarwinInitializationSettings();
    var kurulumAyari = InitializationSettings(android: androidAyari);
    await flp.initialize(kurulumAyari,onDidReceiveNotificationResponse: bildirimSecilme);
  }
  Future<void> bildirimSecilme(NotificationResponse notificationResponse) async{
    var playload = notificationResponse.payload;
    if(playload != null){
      print("Bildirim Seçildi");
    }
  }

  Future<void> bildirimGoster() async {
    var androidBildirimDetay = const AndroidNotificationDetails(
      "id", //bildirileri guruplamak için
      "name", //adı
      channelDescription: "channelDescription", //açıklaması
      priority: Priority.high,
      importance: Importance.max);
    var iosBildirimDetay = const DarwinNotificationDetails();
    var bildirimDetay = NotificationDetails(android: androidBildirimDetay,iOS: iosBildirimDetay);
    await flp.show(0, "Başlık", "İçerik", bildirimDetay,payload: "Payload içerik");
  }

  @override
  void initState() {
    super.initState();
    kurulum();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirim"),),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              bildirimGoster();
            }, child: const Text("Bildirim Oluştur"))
          ],
        ),
      ),
    );
  }
}
