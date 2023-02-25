class PaginationMaker {
  int currentPage = 0;
  int _pageSize = 0;

  PaginationMaker();

  bool _loadDataWithPagination() {
    return currentPage >= _pageSize;
  }

  int get page {
    return ++currentPage;
  }

  bool get isLast {
    return _loadDataWithPagination();
  }

  set pageSize(int pageSize) {
    _pageSize = pageSize;
  }

  set page(int page) {
    currentPage = page;
  }
}


            // "total_count": 3,
            // "page_size": 10,
            // "current_page": 1,
            // "page_count": 1
