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

We can create the routes in our MaterialApp() widget directly, by adding a property call *routes* and this its going to be a Map.

  - So this Map expects a key and a value, the key in this case are going to be the actual routes it self
    
    - Lest start with the basic route that is '/' that is the first widget we want to show when we first open the app
    
    - The value for this different routes are going to be functions, and this functions take in the *context* object as it argument
    - This *context* object basically keep track in where in the widget tree we are.
    
    - This function returns a widget that we want to load up when we go to this route.
      - So there are going to be three different keys with three values: Loading, Home and ChooseLocation
        - Do not forget to import all of the files

```dart
import 'package:flutter/material.dart';

import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
```

Until now the route for the initial page ('/': (context)=>Loading()) are in conflict with the *home* property.
- So instead of use the *home* property we are going to use from now the *initialRoute* property and in it we can say which of the routes are going to be the initial route when we first load up the app. We are override the default that we set in *routes*.
  - Later on the initial route are going to be the Loading()

```dart
void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
```

Now that we have our different routes setup we need a way to the user to navigate between this routes.

- We are going to create a button on the Home() screen that push us to the ChooseLocation() route.

- Instead of have a Text() as a child of the SafeArea() widget, lets put a column(), because we are going to need a column of widgets (list of widgets)

  - The first (the only until now) that we are going to create is a FlatButton.icon() that takes some properties with it.
    - The *onPressed* takes a function that inside we are going to navigate to the route.
    - The *icon* are going to be a Icon() widget that receive the object Icons.edit_location
    - The *label* property is a Text() 

```dart
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit_location),
              label: Text('Edit Location'),
            )
          ],
        ),
      ),
    );
  }
}
```

- Lets take care of the function inside the *onPressed* property.
  - We can push to another route by using the **Navigator** object, accessing it method call *pushNamed*, this takes two arguments, the first on is the **context** object and the second one is the name route

```dart
FlatButton.icon(
  onPressed: () {
    Navigator.pushNamed(context, '/location');
  },
  icon: Icon(Icons.edit_location),
  label: Text('Edit Location'),
)
```

Now we need a way to come back to the Home() screen. So inside of the choose_location file
  - Inside of the Scaffold() widget, we are going to add the *backgroundColor* property
  - We are going to add to the Scaffold() the *appBar* property that takes the AppBar() widget, because in Flutter the app bar set a little arrow as default when we came from another route.
    - It is going to have a *backgroundColor*, a *title* that is a Text() widget.
    - Lets use *centerTitle* property setting it to true
    - And remove the shadow by setting the *elevation* property to 0


```dart
class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Text('Choose Location Screen'),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
```

## Understanding Routes:

It is like a stack of screens that show, first we have our initial route when the app opens. The when we use the method to push a new route, what we did is push out a new screen on top of the old screen and the old screen steel seats underneath.
The backup button on the app bar pop out the route off of the stack so we left with the old route which we then see again.

# Widget Lifecycle:

So now lets talk about widget lifecycle and a couple of different lifecycle methods that we can tap into.

Until now we see two types of widget a Stateless() and a Stateful()

- Stateless:
  1. State does not change over time
  2. The build() function only runs once. Once it is build it doesn't then rebuild itself when things change.

  - If we want some change in the StatelessWidget() we need to destroy that widget and create a new instance of it with different data.

- Stateful:
  1. Can have state that change over time
  2. To change we call the setState() method that trigger the build function. So it rebuild that widget so we can see the change on the screen.

  - StatefulWidget() also have a couple of different lifecycle methods that we use.


- Lifecycle methods:

1. initState(): 
  - The first method to be called once our state object has been created. Now this method is only call once when the widget is created
  - Probably a good place to subscribe to streams or any kind os objects that's going to change our widget data in the future

2. Build(): 
  - It build the widget tree, it runs allot in the StatefulWidget() because its trigger every time we use the setState()

3. Dispose():
  - It is trigger when the widget or the state object is completely remove.

Lets create some example of the lifecycle method inside the choose_location file.

- We are going to tap 'init' and use the autocomplete to create the function

```dart
@override
void initState() {
  // TODO: implement initState
  super.initState();
}
```

- It create an override function that override the initial state that has inside the StatefulWidget()
- The 'super.initState()' it telling to run the function initState() that came from the StatefulWidget() (that we are overriding in the beginning) first.

- So lets display in the console some message when we initState and when we Build the widget

```dart
class _ChooseLocationState extends State<ChooseLocation> {
  @override
  void initState() {
    super.initState();

    print('InitState run');
  }

  @override
  Widget build(BuildContext context) {
    print('build run');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Text('Choose Location Screen'),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
```

- So every time that we push to the ChooseLocation page, it runs the initState() and build() function

- So lets create a button to update a counter just to see that every time that the state changes it rebuild the widget tree. Calling the build() function

```dart
class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;

  @override
  void initState() {
    super.initState();

    print('InitState run');
  }

  @override
  Widget build(BuildContext context) {
    print('build run');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: RaisedButton(
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        child: Text('$counter'),
      ),
    );
  }
}
```

- So every time that we click the button and update the state (add one to the counter variable) we rebuild the widget tree.

- So this is how the lifecycle works

# Asynchronous Code:

Asynchronous code represent a action that start now and finishes some time in the future. An example of this could be interacting with an API endpoint or a database to get some data. So we start the request but it doesn't finish straight away because it may take a second or two to complete that request, so it finish some time after the initial request is made once we get that data back.

In the meantime our code should not stop until that request is complete and the data comes back. So asynchronous code should be non-blocking so while the request has been made the rest of our code could carry on

So to handle asynchronous code in Flutter we are going to use a combination of *asynchronous functions*, the *await* keyword and something call *futures* (type of data very similar to promises in JavaScript).

So let do a example of Asynchronous code: (inside the choose_location file):

- Lets create a function that is not going to return anything (so it is going to be a *void* function) call getData().

- This function are going to be responsible to an asynchronous code like getting some data.
  
  - From now we are not going to use a third part API or database to get data in the minute, but we are going to simulate a request using some kind of delay
    
    - For this we are going to use the **Future** object and access a method call *delayed* in it.  

      - This takes two arguments:
      1. first is going to be a duration, and for that we use a **Duration** object passing inside the property *seconds* that specify how many seconds we want to delay. 
      2. The second argument is going to be a function that fires onces that seconds ar off. Then print something
 
- So we are going to call this function inside the initState(), so when this state object is create then is going to run the initState() which is going to call this getData() method that are going to do the delay

```dart
class _ChooseLocationState extends State<ChooseLocation> {
  void getData() {
    // Simulate request for a username

    Future.delayed(Duration(seconds: 3), () {
      print('Yoshi');
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Text('Choose Location Screen'),
    );
  }
}
```

- This shows us that the code continuing running, we are not waiting to the getData() function to carry on to run the rest of our code.

- Now lets imaging that we need the first request to finish in order to run a second request for example, maybe we want to use the username that comes back from the first request to do the second one.

- We need to use a combination of a asynchronous function, placing *async* after the parenthesis and before the curly braces, telling that this is a asynchronous function, and also use the await key word before the first request.

  - So it is going to wait this request done, until run the next line inside the function getData().

```dart
void getData() async {
  // Simulate request for a username
  await Future.delayed(Duration(seconds: 3), () {
    print('Yoshi');
  });

  // Simulate request for a bio using the username
  Future.delayed(Duration(seconds: 3), () {
    print('Vegan, Musician and Egg Collector');
  });
}
```

- The good thing about this *await* key word is that we can actually assign a value to it.
  
  - So lets say for example that when we made the request to it is going to return a value of type String

  - Now what we can do is to store that value into a String type variable, call 'username'. 
    - So we are saying, do the request and wait for the response, we you get the data assign to the variable

```dart
void getData() async {
  // Simulate request for a username
  String username = await Future.delayed(Duration(seconds: 3), () {
    return 'Yoshi';
  });

  // Simulate request for a bio using the username
  String bio = await Future.delayed(Duration(seconds: 1), () {
    return 'Vegan, Musitcian and Egg Collector';
  });

  print('$username - $bio');
}
```

- So now we are waiting to each request to finish in order to move on


# Flutter Packages (http):

Flutter packages are bundles of code and logic that other developers already written that implement some kind of special functionality in our own apps.

In this part we are going to use the HTTP package, that allow us to handle HTTP request to a third part API.

In the page of Flutter packages we can see how to install this packages by placing the line of code in the pubspec.yaml file. In this case:

'https://pub.dev/packages/http/install'

```yaml
dependencies:
  http: ^0.12.2
```

- Now lets cut the precious code to create the asynchronous function at the choose_location file and place it in the loading file.
  - Get rid of the code inside the function because we no longer are going to simulate a request, but made a actual request with the HTTP package

```dart
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getData() async {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
```

- For the API we are going to use the 'https://jsonplaceholder.typicode.com/' that give us some data examples in json format

- But first we need to import the HTTP package that we install

```dart
import 'package:http/http.dart';
```

- To use the endpoint from the website above, we just need to use 'get()'
  - We now are going to store this data in a variable, but we want the request to finish before we store the value, so we are going to use the 'await'

  - We are going to store the value of the request in a **Response** object. This object is given to us by the HTTP module, this content the information about the variable that we are creating with the data from the request.
    - One of the information is the *body* of the request, so lets printed out.

```dart
void getData() async {
  Response response =
      await get('https://jsonplaceholder.typicode.com/todos/1');
  print(response.body);
}
```

- In order to load the Loading() widget we need to change the *initialRoute* property in the home file.

- When we make a hot restart we see the data that come back from our API in the console.

```json
{
  "userId": 1,
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
}
```

- This load up like a map, but cannot be used like a map. If we try to get for example the userId by doing:

```dart
print(response.body.userId)
```

- It is going to return a error. Because the return is not a object, is a string representation of an object (JSON string). And we need to convert in some kind of format that we can use.
  - For this we can use a function call json decode
    - We need to 'import 'dart:convert' to use this function

  - This function return a Map, so we can store in a Map type variable this data

```dart 
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getData() async {
    Response response =
        await get('https://jsonplaceholder.typicode.com/todos/1');
    Map data = jsonDecode(response.body);

    print(data);
    print(data['title']);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
```


# World Time API:

Now that we know hao to use this request lets get data from the World Time API. 'http://worldtimeapi.org/'

The end point that we are going to use to get the time for Lisbon/Portugal is 'http://worldtimeapi.org/api/timezone/Europe/Lisbon'

So we can delete the code for getting the data from the previous API, and change also the name of the function **getData()** to **getTime()**

```dart
class _LoadingState extends State<Loading> {
  void getTime() async {}

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
```

- First we are going to make the request
  - Saving the response in a variable type Response.
  - Await for the request to complete to save in the variable
  - And pass to the get() function the end point

```dart
void getTime() async {
  Response response =
      await get('http://worldtimeapi.org/api/timezone/Europe/Lisbon');
}
```

- Now lets transform this data in some format that we can use

```dart
void getTime() async {
  Response response =
      await get('http://worldtimeapi.org/api/timezone/Europe/Lisbon');

  Map data = jsonDecode(response.body);

  print(data);
}
```

- The next thing that we want to do is get the properties from this data. 
  - Lets store this properties in a variable, this are string properties so we need a String variable.

```dart
void getTime() async {
  // Make the request
  Response response =
      await get('http://worldtimeapi.org/api/timezone/Europe/Lisbon');

  Map data = jsonDecode(response.body);
  // print(data);

  // Get properties from data
  String datetime = data['datetime'];
  String offset = data['utc_offset'];
  print(datetime);
  print(offset);
}
```