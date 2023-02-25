import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:withtalk_mobile/data/models/app_http_response.dart';
import 'package:withtalk_mobile/data/models/cotegory.dart';
import 'package:withtalk_mobile/data/models/forum.dart';
import 'package:withtalk_mobile/data/models/forum_message.dart';
import 'package:withtalk_mobile/data/models/pagination.dart';
import 'package:withtalk_mobile/data/models/product.dart';
import 'package:withtalk_mobile/data/models/product_detail.dart';
import 'package:withtalk_mobile/presentation/bloc_providers/providers.dart';
import '../data/constants/apis.dart';
import '../data/models/review.dart';
import '../data/models/user.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(Apis.cotigories)
  Future<AppHttpResponse<List<CotegoryModel>>> cotigories({
    @Query("category_id") String? categoryId,
  });

  @GET(Apis.products)
  Future<AppHttpResponse<Pagination<ProductModel>>> products({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("sort") String? sort,
    @Query("from") double? from,
    @Query("to") double? to,
    @Query("category_id") String? categoryId,
  });

  @GET(Apis.product)
  Future<AppHttpResponse<List<ProductDetailModel>>> product({
    @Query("product_id") String? productId,
  });

  @POST(Apis.addProduct)
  @MultiPart()
  Future<AppHttpResponse> addProduct({
    @Query("action") String? action,
    @Query("name") String? name,
    @Query("detail_text") String? detailText,
    @Query("price") String? price,
    @Body() FormData? morePhoto,
    @Query("address") String? address,
    @Query("sub_category") String? subCategory,
    @Query("product_id") String? productId,
    @Query("delete_photo") String? deletePhoto,
  });

  @POST(Apis.registration)
  Future<AppHttpResponse> registration({
    @Query("login") String? login,
    @Query("password") String? password,
    @Query("repassword") String? repassword,
    @Query("email") String? email,
    @Query("android") String? android,
    @Query("ios") String? ios,
  });

  @POST(Apis.login)
  Future<AppHttpResponse> login({
    @Query("login") String? login,
    @Query("password") String? password,
    @Query("android") String? android,
    @Query("ios") String? ios,
  });

  @GET(Apis.profile)
  Future<AppHttpResponse<User>> profile();

  @GET(Apis.listFavorite)
  Future<AppHttpResponse<Pagination<ProductModel>>> listFavorite({
    @Query("page") int? page,
    @Query("size") int? size,
  });

  @POST(Apis.favorite)
  Future<AppHttpResponse> favorite({
    @Query("fav") bool? fav,
    @Query("product_id") String? productId,
  });

  @GET(Apis.myProducts)
  Future<AppHttpResponse<Pagination<ProductModel>>> myProducts({
    @Query("page") int? page,
    @Query("size") int? size,
  });

  @GET(Apis.userProducts)
  Future<AppHttpResponse<Pagination<ProductModel>>> userProducts({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("object") String? userId,
  });

  @GET(Apis.subCategory)
  Future<AppHttpResponse<List<CotegoryModel>>> subCategory({
    @Query("category_id") String? categoryId,
  });

  @POST(Apis.editProfile)
  @MultiPart()
  Future<AppHttpResponse> editProfile({
    @Query("action") String? action,
    @Query("name") String? name,
    @Query("last_name") String? lastName,
    @Query("phone") String? phone,
    @Part(name: "personal_photo", contentType: "image/jpeg")
        File? personalPhoto,
    @Query("login") String? login,
    @Query("email") String? email,
    @Query("birthday") String? birthday,
    @Query("password") String? password,
    @Query("repassword") String? repassword,
    @Query("city") String? city,
  });

  @POST(Apis.comment)
  Future<AppHttpResponse> comment({
    @Query("product_id") String? productId,
    @Query("text") String? text,
    @Query("rating") double? rating,
  });

  @GET(Apis.comments)
  Future<AppHttpResponse<Pagination<ReviewModel>>> comments({
    @Query("product_id") String? productId,
    @Query("page") int? page,
    @Query("size") int? size,
  });

  @GET(Apis.search)
  Future<AppHttpResponse<Pagination<ProductModel>>> search({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("query") String? query,
    @Query("sort") String? sort,
    @Query("from") String? from,
    @Query("to") String? to,
  });

  @GET(Apis.cotegoryOfForum)
  Future<AppHttpResponse<List<CotegoryModel>>> cotegoryOfForum({
    @Query("category_id") String? categoryId,
  });

  @GET(Apis.forums)
  Future<AppHttpResponse<Pagination<ForumModel>>> forums({
    @Query("category_id") String? categoryId,
    @Query("page") int? page,
    @Query("size") int? size,
  });

  @GET(Apis.forumMessages)
  Future<AppHttpResponse<Pagination<ForumMessageModel>>> forumMessages({
    @Query("forum_id") String? forumId,
    @Query("page") int? page,
    @Query("size") int? size,
  });

  @POST(Apis.forumMessageAction)
  Future<AppHttpResponse> forumMessageAction({
    @Query("action") String? action,
    @Query("text") String? text,
    @Query("comment_id") String? messageId,
    @Query("forum_id") String? forumId,
    @Query("answer") String? answer,
  });

  @POST(Apis.forumAction)
  Future<AppHttpResponse> forumAction({
    @Query("action") String? action,
    @Query("title") String? title,
    @Query("detail_text") String? detailText,
    @Query("forum_id") String? forumId,
    @Query("sub_category") String? subCategory,
  });

  @POST(Apis.myForum)
  Future<AppHttpResponse<Pagination<ForumModel>>> myForum();

  @POST(Apis.forum)
  Future<AppHttpResponse<List<ForumModel>>> forum({
    @Query("forum_id") String? forumId,
  });
}

/*

 flutter pub run build_runner build --delete-conflicting-outputs  //? <<<--- build value code

*/