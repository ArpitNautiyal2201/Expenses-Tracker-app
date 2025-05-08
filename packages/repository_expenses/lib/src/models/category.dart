import 'package:repository_expenses/src/entities/entity.dart';

class Category {
  String categoryID;
  String name;
  int expensesTotal;
  String icon;
  int color;

  Category({
    required this.categoryID,
    required this.name,
    required this.expensesTotal,
    required this.icon,
    required this.color,
  });

  static final empty =
      Category(categoryID: '', name: '', expensesTotal: 0,
       icon: '', color: 0);

  CategoryEntity toEntity() {
    return CategoryEntity(
        categoryID: categoryID,
        name: name,
        expensesTotal: expensesTotal,
        icon: icon,
        color: color,
        );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
        categoryID: entity.categoryID,
        name: entity.name,
        expensesTotal: entity.expensesTotal,
        icon: entity.icon,
        color: entity.color,
        );
  }
}
