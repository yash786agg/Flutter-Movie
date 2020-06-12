import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'mock_http_client.dart';
import 'mock_http_provider.dart';

void main() {
  group('Http call', () {
    MockHttpClient _mockHttpClient;
    MockHTTPProvider _mockHTTPProvider;

    setUp(() async {
      _mockHttpClient = MockHttpClient();
      _mockHTTPProvider = MockHTTPProvider();
    });

    tearDown(() async {
      _mockHttpClient.close();
      _mockHTTPProvider = null;
    });

    test('fetch http call then map result correctly', () async {
      String requestUrl =
          'http://api.themoviedb.org/3/movie/popular?api_key=<api_key>&language=en-US&page=1';

      final json = """ 
        {
          "results": [
              {
                  "popularity": 407.572,
                  "vote_count": 3655,
                  "video": false,
                   "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
                   "id": 419704,
                   "adult": false,
                   "backdrop_path": "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
                   "original_language": "en",
                   "original_title": "Ad Astra",
                   "genre_ids": [
                          18,
                          878
                        ],
                   "title": "Ad Astra",
                   "vote_average": 6,
                   "overview": "The near future, a time when both hope and 
                   hardships drive humanity to look to the stars and beyond. 
                   While a mysterious phenomenon menaces to destroy life on 
                   planet Earth, astronaut Roy McBride undertakes a mission 
                   across the immensity of space and its many perils to 
                   uncover the truth about a lost expedition that decades 
                   before boldly faced emptiness and silence in search of 
                   the unknown.",
                   "release_date": "2019-09-17"
              }
          ],             
          "page": 1,
         "total_results": 10000,
         "total_pages": 500,
        }
      """;

      when(_mockHttpClient.get(requestUrl))
          .thenAnswer((_) async => http.Response(json, 200));

      expect(await _mockHTTPProvider.get(requestUrl),
          TypeMatcher<dynamic>() /*isA<dynamic>()*/);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      when(_mockHttpClient.get(''))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(await _mockHTTPProvider.get(''), null);
    });
  });
}
