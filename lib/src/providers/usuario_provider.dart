import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String firebaseToken = 'AIzaSyCFkqdPT3_zLktMcAXko1qJzeUkSPK6_Bg';

  Future nuevoUsuario(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseToken');

    final resp = await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //TODO: salvar el token en el storage
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }
}
