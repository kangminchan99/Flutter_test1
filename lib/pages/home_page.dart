import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test1/model/movie_model.dart';
import 'package:test1/provider/movie_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> _movie = <MovieModel>[];
  final TextEditingController _textEditingController = TextEditingController();
  String? movieTitle;

  @override
  void initState() {
    super.initState();
    MovieService.getInfo().then((value) {
      setState(() {
        _movie = value;
      });
    });
  }

  Future<void> getMovieInfo() async {
    if (movieTitle == null || movieTitle!.isEmpty) {
      Fluttertoast.showToast(msg: "영화 제목을 입력하세요.");
      return;
    } else {}
  }

  void update() => setState(() {});
  // 사용자는 앱에서 영화 제목을 검색할 수 있어야 합니다.
// 사용자가 영화 제목을 입력하면, OpenAPI를 통해 영화 정보를 가져와야 합니다.
// 가져온 영화 정보는 앱에서 보여줘야 합니다. 영화 포스터, 제목, 개봉 연도, 평점 등의 정보가 포함되어야 합니다.
// 앱 개발에 필요한 정보:

// OpenAPI URL: https://api.themoviedb.org/3/search/movie
// API Key: 등록된 API 키를 사용해야 합니다. 키를 발급받지 않았다면, https://www.themoviedb.org/ 에서 가입 후 API 키를 발급받으세요.
// 요청 방식: GET
// 쿼리 파라미터: api_key (발급받은 API 키), query (검색할 영화 제목)
// 앱 개발에 사용할 수 있는 도구:

// Flutter 프레임워크
// HTTP 패키지(예: http 패키지) 또는 HTTP 클라이언트를 제공하는 패키지
// 위의 요구사항을 충족하면서 영화 정보를 가져오는 앱을 개발해주세요. 필요한 경우 추가적인 함수나 클래스를 작성하셔도 됩니다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _textEditingController,
          onChanged: (value) {
            movieTitle = value;
          },
          onFieldSubmitted: _sumitted,
          decoration: const InputDecoration(hintText: '영화 검색'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              update();
              _sumitted(_textEditingController.text);
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _movie.length,
        itemBuilder: (context, index) {
          // User타입의 user라는 변수를 생성해준 다음 _user[index]를 넘겨준다.
          MovieModel movie = _movie[index];
          if (_textEditingController.text == movie.title) {
            return Column(
              children: [
                ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                ),
                Text('평점: ${movie.voteAverage}')
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _sumitted(String text) {}
}
