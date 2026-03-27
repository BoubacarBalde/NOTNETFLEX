import 'package:dio/dio.dart';
import 'package:notnetflex/services/api.dart';

class ApiService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async{
    //On contruit l'url
    String _url = api.baseURL + path;

    //on construit les paramètres de la requete
    //Ces paramètre seront presents dans chaque requestes
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'langage': 'fr-FR',
    };

    //Si paramètre n'est pas nul on ajoute son contenu a query
    if(params != null){
      query.addAll(params);
    }

    //on fait l'appel
    final response = await dio.get(_url, queryParameters: query);

    //on check si la raquet c'est bien passé
    if(response.statusCode == 200){
      return response;
    }else{
      throw response;
    }
  }

}