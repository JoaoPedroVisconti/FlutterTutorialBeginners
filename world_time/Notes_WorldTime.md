# Starting the World Time App:

Lets start our application as always, deleting the test folder and the content in under the main function inside the main.dart file.

This app are going to have three different pages, so lets create a directory to put all this files call pages inside the lib folder.

Inside the pages folder we are going to have three files, home.dart, choose_location.dart and loading.dart

We have to import the material.dart file, as in the main.dar file, inside of all these new files.

1. First lets create a StatefulWidget for the home, and we can change the return of the widget to a Scaffold and for now lets output a text.

```dart
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Page'),
    );
  }
}
```

  - We need to import the home file to the main file in order to use the Home() widget in the home: property of the MaterialApp() widget
  - We are going to import as a package

```dart
import 'package:world_time/pages/home.dart';
```

  - Now lets use a SafeArea() to avoid the text going to under the bar of the phone. Wrap the Text() widget with the SafeArea()

2. Now lets work a little bit at the choose_location.dart file

  - It is also going to be a stateful widget because we are going to have data that we want to change it
  - Also lets return from now a Scaffold() widget with some text

```dart
import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Choose Location Screen'),
    );
  }
}
```

3. Lets do the same thing for the loading file


```dart
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
```

# Maps & Routing:

Now we need a way to navigate between this different screens.

Maps in dart is like a dictionary in python or a object literal in JavaScript. They basically a set of keys and values

- Lets create some examples of map outside the project

```dart

void main () {
  Map student = {'name': 'Visconti', 'age': 31}
}
```

- Now we have this map setup which describe this student that has two properties and values to that properties as well.
- Later we can access one of this values by using square brakes notation

```dart
void main () {
  Map student = {'name': 'Visconti', 'age': 31}

  print(student['name'])
}
```

1. Lets use this in our app:

We can create the routes in our MaterialApp() widget directly, by adding a property call 'routes' and this its going to be a Map.

  - So this Map expects a key and a value, the key in this case are going to be the actual routes it self
    
    - Lest start with the basic route that is '/' that is the first widget we want to show when we first open the app
    
    - The value for this different routes are going to be functions, and this functions take in the context object as there arguments
    - This contact object basically keep track in where in the widget tree we are.
    
    - This function returns a widget that we want to load up when we go to this route.
