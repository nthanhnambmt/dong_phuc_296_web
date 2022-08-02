import '../../util/strings.dart';

class CategoryModel {
  const CategoryModel({required this.catId, required this.catName});

  final int catId;
  final String catName;
}

CategoryModel categoryAll = CategoryModel(
  catId: 1,
  catName: web296CategoryNameAll,
);

CategoryModel categoryClothing = CategoryModel(
  catId: 2,
  catName: web296CategoryNameClothing,
);

CategoryModel categoryUniform = CategoryModel(
  catId: 3,
  catName: web296CategoryNameUniform,
);

CategoryModel categorySport = CategoryModel(
  catId: 4,
  catName: web296CategoryNameSport,
);

CategoryModel categoryBaby = CategoryModel(
  catId: 5,
  catName: web296CategoryNameBaby,
);

CategoryModel categoryDress = CategoryModel(
  catId: 6,
  catName: web296CategoryNameDress,
);

CategoryModel categoryNightdress = CategoryModel(
  catId: 7,
  catName: web296CategoryNameNightdress,
);

CategoryModel categoryPrint = CategoryModel(
  catId: 8,
  catName: web296CategoryNamePrint,
);

CategoryModel categoryAccessories = CategoryModel(
  catId: 9,
  catName: web296CategoryNameAccessories,
);

CategoryModel categoryHome = CategoryModel(
  catId: 10,
  catName: web296CategoryNameHome,
);

CategoryModel categoryCanvas = CategoryModel(
  catId: 11,
  catName: web296CategoryNameCanvas,
);

List<CategoryModel> categories = [
  categoryAll,
  categoryUniform,
  categorySport,
  categoryBaby,
  categoryDress,
  categoryNightdress,
  categoryAccessories,
  categoryCanvas,
  categoryPrint,
  // categoryClothing,
  // categoryHome,
];
