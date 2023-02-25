abstract class Apis {
  static const String baseUrl = "https://newmebel.uz/mobile";
  static const String baseImageUrl = "https://newmebel.uz/";

  //apis

  static const String registration = "/auth/reg.php";
  static const String login = "/auth/login.php";
  static const String cotigories = "/catalog/catalog.php";
  static const String products = "/catalog/products.php";
  static const String product = "/catalog/product.php";
  static const String addProduct = "/catalog/action.php";
  static const String profile = "/profile/";
  static const String editProfile = "/profile/action.php";
  static const String favorite = "/favs/index.php";
  static const String listFavorite = "/favs/list.php";
  static const String myProducts = "/profile/my-product.php";
  static const String userProducts = "/catalog/user_catalog.php";
  static const String subCategory = "/catalog/category.php";
  static const String comment = "/comment/add.php";
  static const String comments = "/comment/get.php";
  static const String search = "/search/";
  static const String cotegoryOfForum = "/forum/category.php";
  static const String forums = "/forum/forums.php";
  static const String forum = "/forum/forum.php";
  static const String forumMessageAction = "/forum/comment/action.php";
  static const String forumMessages = "/forum/comment/get.php";
  static const String forumAction = "/forum/action.php";
  static const String myForum = "/profile/my_forums.php";
}


//   flutter pub run build_runner build --delete-conflicting-outputs
