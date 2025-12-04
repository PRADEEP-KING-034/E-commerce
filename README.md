# Flutter Store App (MVVM) — Assessment

**API:** Used Fake Store API — https://fakestoreapi.com/products
**Architecture:** MVVM (Repository > ViewModel > View)  
**State management:** Provider (ChangeNotifier)

## Features
- Products List page (grid)
- Product Details page
- Cart page (add/remove, +/-, total price)
- Loading & error states
- Pull-to-refresh on Products page

## Project structure
(see `lib/` folder — models, repository, viewmodels, views, widgets)

## How to run
1. Clone the repo: git clone 
    <https://github.com/PRADEEP-KING-034/E-commerce.git>

2. Dependancies Injuction 
    <cd "location of the repo">
    <flutter pub get>

3. Run: 
    <flutter run>

# Screenshots & Output Video
1. ![Product List Screen](/output/1.jpeg)
2. ![Product Detail Page](/output//2.jpeg)
3. ![Cart Page](/output//3.jpeg)
4. ![Cart Page](/output//3.jpeg)

## Architecture notes
- `repository/product_repository.dart` — all API calls
- `viewmodels/*` — ViewModels implement ChangeNotifier and hold UI state & logic
- `views/*` — UI widgets only read and interact with ViewModels via Provider
- `models/*` — typed model classes (Product, Rating, CartItem)
