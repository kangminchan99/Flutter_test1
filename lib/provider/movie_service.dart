import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test1/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static String? url = dotenv.env['URL'];
  static Future<List<MovieModel>> getInfo() async {
    try {
      // 서버와 통신이 될 때까지 기다려야 하므로 await키워드를 붙여준다.
      final response = await http.get(Uri.parse(url!));
      // statusCode가 200일 경우 json data를 parsing
      if (response.statusCode == 200) {
        // User타입 List에 user라는 변수를 만들고, userFromJson의 response.body를 불러와
        // parsing을 끝낸다.
        print(response.statusCode);
        MovieModel movie = movieModelFromJson(response.body);
        List<MovieModel> movieList = [movie];
        return movieList;
      } else {
        // Fluttertoast를 사용하여 에러 메시지를 보여준다.
        Fluttertoast.showToast(msg: "Error occurred. try again");
        return <MovieModel>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error occurred. try again");
      return <MovieModel>[];
    }
  }
}
