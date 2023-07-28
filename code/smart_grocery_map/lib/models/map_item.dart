class MapItem {
  late String productName;
  late int aisle;
  late int position;

  MapItem({
    required this.productName,
    required this.aisle,
    required this.position,
  });

  static List<MapItem> getDummyList() {
    return [
      MapItem(productName: 'Test 1', aisle: 2, position: 3),
      MapItem(productName: 'Test 2', aisle: 5, position: 1),
      MapItem(productName: 'Test 3', aisle: 7, position: 4),
      MapItem(productName: 'Test 4', aisle: 8, position: 2),
      MapItem(productName: 'Test 5', aisle: 5, position: 3),
    ];
  }
}
