# food_app



Project Details. Android apk file will be shared with you to install and run app on android device along with GitHub source code link.

Functionality:

1. First screen
    a. Side menu
    b. Horizontal food item list with manual as well as auto scroll. Tap will open food details.
    c. Category horizontal scroller - scroll and selection work but category filter is not part of this assignment.
    d. Vertical food items list. Tap on foot item will open food details screen.

2. Food Details screen
    a. Food details screen shows big image, title, description text, nutrient view, add in (not working in this assignment), counter to increment/decrement quantity, add to cart button.

3. Once user taps on add to cart button on food details then user will see food list again with cart button at bottom of screen. Tapping on cart button will open cart screen.

4. Cart screen
    a. Delivery time header
    b. Address label with change address button. Change address is not part of this assignment.
    c. Cart item list with button to increment/decrement cart item. If all items are removed then screen shows cart empty message.
    d. Cutlery view with increment/decrement button - Does not maintain state in this assignment.
    e. Delivery section - if cart value is less than $30 then $10 appears as delivery charge and gets added to cart value, if cart value is bigger or equal to 30 then delivery charge appears as $0.
    f. Payment section - no functionality added for this assignment.
    g. Bottom pay button with time and cart amount. Tapping will clear cart and closes the cart screen.

Source code:

1. App loads food list from local json file.
2. Images are added in asset folder.
3. App Works in portrait as well as in landscape mode
4. Cart items are added in phone memory, if user removes app from backround then cart items will get cleared. This app can be extended to save cart items in persistent storage like mobile app database.
5. State is maintained using Flutter Bloc.
6. App contains below folder structure.
    a. Bloc
    b. Data Provider
    c. Model.
    d. Repository
    e. Screens
    f. Widgets
