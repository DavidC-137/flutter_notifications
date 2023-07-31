import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:notifications/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Fondo(),
          Contenido(),
        ],
      ),
    );
  }
}

// Fondo de la pantalla
class Fondo extends StatelessWidget {
  const Fondo({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(200, 41, 30, 215),
            Color.fromARGB(200, 190, 64, 244),
            Color.fromARGB(200, 212, 42, 140)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
    );
  }
}

// Contenedor del formulario
class Contenido extends StatefulWidget {
  const Contenido({Key? key});

  @override
  State<Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key});

  @override
  State<FormWidget> createState() => _FormState();
}

class _FormState extends State<FormWidget> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value) {
      print("Device token");
      print(value);
    });
  }

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _mensajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: _tituloController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Titulo',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _mensajeController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Mensaje',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              {
                notificationServices.getDeviceToken().then((value) async {
                  var movil =
                      "fO6btx2QQb2l_cJlsGDGub:APA91bFca5lqJWYfpB8m81rBH-eh3oCSE5jfsn0q6uH1vG3OwVmyrKEn9otZNqmvG658k2rNVBgFdC8p6jV8_FhTpeR_G13agcF2sjHlvwzqFqtebUTS2v-vm3cryTDloc3cpkKiPSsb";
                  var wear =
                      "fZIflsA9RoGnr-N0WnTHhK:APA91bE5Z1_5vFaTGyr9FHjecSeRDseAvzbqs6hiTRDnRmmzl3uDKDRATxvm8Pwl4F0aezzUy6N0b5nWzSq8Yr28jMyWCzUFwNhnNEOkYjIs8eMEWxfWpuLddWyilOaBaV_alRBqlCAT";
                  var data = {
                    "to": wear,
                    "priority": "high",
                    "notification": {
                      "title": _tituloController.text, // Título ingresado en el formulario
                      "body": _mensajeController.text // Cuerpo ingresado en el formulario
                    },
                    "data": {
                      "type": "msj", 
                      "id": "123456"}
                  };
                  await http.post(
                      Uri.parse("https://fcm.googleapis.com/fcm/send"),
                      body: jsonEncode(data),
                      headers: {
                        "Content-Type": "application/json; charset=UTF-8",
                        "Authorization":
                            "key=AAAANzUbIwE:APA91bFQqZ_iUte6q9mm7JCOC9LLlA-I3aZpFyAzan50RV4yCklJL413UmBequz_AbR-dAIWz7nZbU3EgrsIcjlrSX4tkGC58c7sb9SvHLKxDL0rPTUkOTPAHTVZn0yAIVyIbjZrj1cK"
                      });
                });
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}










// Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ElevatedButton(
//                   onPressed: () {{
//                       notificationServices.getDeviceToken().then((value) async {
//                         var movil =
//                             "d07NXwReS-u35EyH3XPX8Z:APA91bGLAREyB7G3y_5bQEXPQSE6uQzet0wiTo8RePHDjnAHpd7uZcIypepo1MHjVP50LFRjP1DeeoPmkyUXrcnfaIiRY_bVfal4vR3DBEUCMI-7mQNTvkX8-sxxnZEHwGCxOk51huBs";
//                         var wear =
//                             "clHFYxkuT4iuAPGgPAjmwt:APA91bEkjyd0v534dK-UAKFXHb9cxBmO3jpJjIS_8YsQsHH_sOwHbbQh1XeqbVZ3evMFEc7tbKvoVYxqkHUdxKWHeuvGw83-a-fgu3Ya2IW4Qi72nFBMjWmqL3I2LsunrjR1PNEKGDxo";
//                         var data = {
//                           "to":wear,
//                           "priority": "high",
//                           "notification": {
//                             "title": "Hola", // Título ingresado en el formulario
//                             "body": "Soy una notificacion", // Cuerpo ingresado en el formulario
//                           },
//                           "data": {
//                             "type": "msj",
//                             "id": "123456"
//                           }
//                         };
//                         await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
//                             body: jsonEncode(data),
//                             headers: {
//                               "Content-Type": "application/json; charset=UTF-8",
//                               "Authorization":
//                                   "key=AAAAOwvxDRM:APA91bGRPH8kIuZ54e-iMLzdTvrZRYldTUzPWl0YYkJLrz7M8J6Uiv2uMQ5fuTVaJzQ7HmRj8T6XAJr6aa1v0_lVDIicOysZPUSctOPwscG2tCvjxuVUXMyFqjaPhThN0U2cQQHefEsQ"
//                             });
//                       });
//                     }
//                   },
//                   child: const Text('Enviar'),
//                 ),
//         ],
//       ),
//     ),