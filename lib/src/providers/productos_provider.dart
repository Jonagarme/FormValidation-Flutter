import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:form_validation/src/models/producto_model.dart';

class ProductosProvider {
  final String _url = 'https://flutter-varios-6a948.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';
    var resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}
