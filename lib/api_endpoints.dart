class API {
  String baseURL = 'https://api.kuberaatechnologies.com/be/api/';

  ///AUTH///
  String signup = 'auth/signup';
  String login = 'auth/login';
  String otpSend = 'auth/phoneauth';

  String otpVerify = 'auth/verifyphoneauth';
  String profile = 'auth/getprofile';
  String gsignup = 'google-signup';
  String glogin = 'google-login';
  String getintrest = 'auth/fetch-interests';
  String getauthers = 'user/authors/view';
  String gethomeauthers = 'user/authors/details';
  String gethomecat = 'user/authors/details';
  String getauthcategory = 'user/categories/view';
  String getauthorofweek = 'user/v1.5/authors/author-of-week';

  ///HOME///
  String getBooks = 'user/books';
  String getNotifications = 'user/v1.5/notifications/get-details?userId=';
  String authorBooks = 'user/authors/details';
  String addtoCart = 'user/v1.5/books/cart/add-to-cart';
  String addtoFav = 'user/v1.5/books/add-to-favourites';
  String addtoRef = 'user/v1.5/referrals/add-to-tree';
  String saveBook = 'user/v1.5/libraries/pdf-page-save';
  String address = 'user/v1.5/user-profiles/edit';
  String getCart = 'user/v1.5/books/cart/view?cartType=';
  String getOrders = 'user/v1.5/libraries/orders?userId=';
  String getFav = 'user/v1.5/books/favourites';
  String updateLevel = 'user/v1.5/referrals/tree-details/unlockLevel';
  String getUserData = 'user/v1.5/user-profiles/view?userId=default';
  String mychats = 'user/v1.5/tickets/fetch-tickets?id=default';
  String paymentinit = "user/v1.5/payments/cart/checkout?cartType=";
  String getFavList = "user/v1.5/books/favourites";
  String libraryBooks = "user/v1.5/libraries/view";
  String popularBooks = "user/v1.5/books/popular-books/view";
  String getTree = "user/v1.5/referrals/tree-details?kubId=";
  String libraryCatBooks = "user/v1.5/libraries/view?viewType=category";
  String popularcatBooks =
      "user/v1.5/books/popular-books/view?sort=popular&viewType=category";
  String addmessage = "user/v1.5/tickets/create-ticket";
  String addBankAcc = "user/v1.5/wallet/add-account";
  String updateBankAcc = "user/v1.5/wallet/edit-account";
  String getTransactions = "user/v1.5/transactions/details?transactionType=";
  String walletReq = "user/v1.5/payments/withdraw-request";
  String addCash = "user/v1.5/wallet/add-money";
  String refundReq = "user/v1.5/products/orders/cancellations/refund-request";
  String addfeed = "user/v1.5/feedbacks/create-feedback";
}
