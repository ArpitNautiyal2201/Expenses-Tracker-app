class CategoryEntity {
  String categoryID;
  String name;
  int expensesTotal;
  String icon;
  int color;

  CategoryEntity({
    required this.categoryID,
    required this.name,
    required this.expensesTotal,
    required this.icon,
    required this.color,
  });

  Map<String, Object?> toDocument() {
    return {
      'categoryID': categoryID,
      'name': name,
      'expensesTotal': expensesTotal,
      'icon': icon,
      'color': color
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
        categoryID: doc['categoryID'],
        name: doc['name'],
        expensesTotal: doc['expensesTotal'],
        icon: doc['icon'],
        color: doc['color']
    );
  }
}
