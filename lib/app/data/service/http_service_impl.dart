
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'http_service.dart';

class HttpServiceImpl implements HttpService {

  Dio? _dio;

  @override
  Future<Response> getRequest(String url ,{String? referer, Map<String, String>? query}) async {
    Response response;
    try{
      if(referer!= null){
        _dio?.options.headers['Referer'] = referer;
      }
      if(query != null){
        response = await _dio!.get(url, queryParameters: query);
      } else {
        response = await _dio!.get(url);

      }
    } on DioException catch(e){
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptor(){
    _dio?.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    _dio?.interceptors.add(InterceptorsWrapper(
        onError: (error, errorInterceptorHandler ){
          errorInterceptorHandler.next(error);
        },
        onRequest: (request, requestInterceptorHandler){
          requestInterceptorHandler.next(request);

        },
        onResponse: (response, responseInterceptorHandler) {
          responseInterceptorHandler.next(response);

        }
    ));
    // customization

  }

  @override
  void init()  {

    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ));

    initializeInterceptor();


  }



}