class PropertyListData {
  static var propertyLists;

  PropertyListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.cost = 180000,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int cost;

  static List<PropertyListData> propertyList = <PropertyListData>[
    PropertyListData(
      imagePath: 'assets/hotel_1.png',
      titleTxt: 'Grand Royal house',
      subTxt: 'cairo, eygpt',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      cost: 18000,
    ),
    PropertyListData(
      imagePath: 'assets/hotel_2.png',
      titleTxt: 'Queen house',
      subTxt: 'cairo, eygpt',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      cost: 200000,
    ),
    PropertyListData(
      imagePath: 'assets/hotel_3.png',
      titleTxt: 'Grand Royal house',
      subTxt: 'cairo, eygpt',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      cost: 60000,
    ),
    PropertyListData(
      imagePath: 'assets/hotel_4.png',
      titleTxt: 'Queen house',
      subTxt: 'cairo, eygpt',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      cost: 100070,
    ),
    PropertyListData(
      imagePath: 'assets/hotel_5.png',
      titleTxt: 'Grand Royal house',
      subTxt: 'cairo, eygpt',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      cost: 250000,
    ),
  ];

}
