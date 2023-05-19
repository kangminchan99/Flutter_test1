import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieService {
  static get url => DotEnv().env['URL'];
}
