class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: ' gym',
      isSelected: false,
    ),
     PopularFilterListData(
      titleTxt: ' view of water',
      isSelected: false,
    ),
     PopularFilterListData(
      titleTxt: ' pets allowed',
      isSelected: false,
    ),
     PopularFilterListData(
      titleTxt: 'Balcony',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Parking',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Pool',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Security Features',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'View',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = [
    PopularFilterListData(
      titleTxt: 'All',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Apartment',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Home',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Villa',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Duplex',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Chalets',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> saleRentList = [
    PopularFilterListData(
      titleTxt: 'For Sale',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'For Rent',
      isSelected: false,
    ),
  ];
}