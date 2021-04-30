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

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json';
    var resp =
        await http.put(Uri.parse(url), body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = [];

    if (decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    //print(productos[0].id);

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(Uri.parse(url));

    print((resp.body));

    return 1;
  }
}
