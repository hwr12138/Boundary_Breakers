# Smart Grocery Map and Inventory
## Motivation and Project Description
- In large stores, people often lack a convenient way to find all their goods. Without guidance around the place, shoppers always have to traverse the entire store just to find a small item. Most stores like Walmart or IKEA don't have a detailed map labeling every item or section. With this information missing, it could waste a lot of people's time when they search for multiple items at once. 
- Our platform will help generate an optimal map based on a shopper's e-cart or grocery list that maps out the shortest path to get all their goods.
- Team boundarybreakers will contribute its skills to create a mobile application that addresses the issue mentioned above.
## Installation
Technologies we use include: 
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Python](https://www.python.org/downloads/)

1. Clone this repository to your local machine.

2. Frontend Setup:
    - [Have Flutter and setup your device](https://flutter.dev/docs/get-started/install)
    - go into the code/smart_grocery_map directory and get the dependencies
    ```sh
    $ cd code/smart_grocery_map
    $ flutter pub get
    ```
    - use the recommended simulation device(Name: Pixel_2_API_30, Target: google_apis_playstore [Google Play] (API level 30), hw.lcd.width: 1080, hw.lcd.height: 1920)
    
3. Backend Setup:
    - Have [Python](https://www.python.org/downloads/) installed
    - Install Django, Pillow and django-cors-headers
    ```sh
    $ python -m pip install Django
    $ python -m pip install Pillow
    $ python -m pip install django-cors-headers
    ```

4. Running the app:
    - go into the Django project directory and start the server
    ```sh
    $ cd code/backend/SmartGroceryApp
    $ python manage.py runserver
    ```
    - go into the Flutter project directory and run the app on emulator
    ```sh
    $ cd code/smart_grocery_map
    $ flutter run -d chrome --web-port=3001 lib/main.dart
    $ flutter run -d emulator-5554 lib/main.dart
    ```
