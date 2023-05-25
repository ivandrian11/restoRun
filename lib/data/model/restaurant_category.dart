class Category {
  bool isClicked;
  final String title;

  Category({
    required this.title,
    this.isClicked = false,
  });
}

List<Category> categories = [
  Category(title: 'Detail', isClicked: true),
  Category(title: 'Menu'),
  Category(title: 'Reviews'),
];

int categoryClicked(Category selectedCategory) {
  Category currentCategory = selectedCategory;
  if (!currentCategory.isClicked) {
    currentCategory.isClicked = true;
    for (var category in categories) {
      if (category != currentCategory) {
        category.isClicked = false;
      }
    }
  }
  return categories.indexOf(currentCategory);
}
