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

- The output that we get is:

```json
  2020-10-28T09:37:31.991564+00:00
  +00:00
```

- Now we need some how to convert this in to a date time string (date time object). In Dart we can use the DateTime class to create this object, and we instantiate this making the variable equal to the DateTime().
  - But what we want to do is actually use a method call 'parse', and pass in the 'datetime' string.

  - So what we are doing is to taking the datetime string and passing in to the 'parse' method on the DateTime() class.

```dart
class _LoadingState extends State<Loading> {
void getTime() async {
  // Make the request
  Response response =
      await get('http://worldtimeapi.org/api/timezone/Europe/Lisbon');

  Map data = jsonDecode(response.body);
  // print(data);

  // Get properties from data
  String datetime = data['datetime'];
  String offset = data['utc_offset'];
  // print(datetime);
  // print(offset);

  // Create a dateTime object
  DateTime now = DateTime.parse(datetime);
  print(now); // The output is:
              // 2020-10-28 09:44:26.944418Z
}
```

- Now we can use a method in this DateTime() object, the instance of it *now*, to add a specify time or duration in this object call *add*.
  - We need to pass in the Duration() object, that we saw before, to pass in the 'hours' that is the offset string that we get from our server.

  - But we need to remove the first part of this string that content a '+' in it (+00:00). But we can do this using a string method call *substring* and go to position 1 until position 3 and get back from it just (00).

```dart
String offset = data['utc_offset'].substring(1,3);
```

- Now we can turn this string into a number and use to add on the current date.
  - To convert that string into a integer we use the method *parse* on the *int* class

  - The *add* method is not destructible, so we need to set the variable *now* to be the new value added the 'offset'

```dart
class _LoadingState extends State<Loading> {
void getTime() async {
  // Make the request
  Response response =
      await get('http://worldtimeapi.org/api/timezone/Europe/Lisbon');

  Map data = jsonDecode(response.body);
  // print(data);

  // Get properties from data
  String datetime = data['datetime'];
  String offset = data['utc_offset'].substring(1, 3);
  // print(datetime);
  // print(offset);

  // Create a dateTime object
  DateTime now = DateTime.parse(datetime);
  now = now.add(Duration(hours: int.parse(offset)));
  print(now);
}
```


# WorldTime Custom Class:

Now we have a lot of logic inside the loading file, to be more organized and reusable, we going to separate this logic in its own file in custom class

- First lets create a new folder call services inside the lib folder. And inside create a new file call 'world_time.dart'
  - This will be our WorldTime class.

- First lets import the packages that we use

- After that we create the class **WorldTime** 

```dart
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {}
```

- Inside we first need to declare a fill different properties
  
  1. location property: That are going to be the exact location that we show in the UI. We just initialize, don't pass any values, the values are going to be passed in in a constructor.

  2. time property: this is the actual time in that location.

  3. flag property: we want to show a little image of a flag next to the location. So this property is going to be a url to an asset flag icon

  4. url property: we need a url for the API, the part of the url that change when the user select the location.

```dart
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // URL to an flag icon
  String url; // URL for the API endpoint
}
```

- Now lets bring over the function that we create previously inside the 'loading' file.

- We need to make some changes in the function.
  - We need to change the url that we make the call to the API, and instead of type the location, pass the *url* string variable that we create.
  
  - Now we need to convert to a string that DateTime object that we have saved. And pass into the *time* property that we create before. To convert we are going to use the *toString* method.
    - We are storing this inside the class itself, in that property

  - But we need to set the other properties also. This properties are going to be passed in to the class once we instantiate it. So we need to create the constructor

    - We are going to use Named Parameters for the constructor

```dart
class WorldTime {
  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // URL to an flag icon
  String url; // URL for the API endpoint

  WorldTime({this.location, this.flag, this.url});

  void getTime() async {
    // Make the request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');

    Map data = jsonDecode(response.body);
    // print(data);

    // Get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    // print(datetime);
    // print(offset);

    // Create a dateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    // Set the time property
    time = now.toString();
  }
}
```

- This class are going to be instantiated as for example:
  - Then we can use the function getTime()

```dart
WorldTime instance = WorldTime(location: 'London', flag: 'british.png', url: 'Europe/London');

instance.getTime();
```

- Now we need to import this new class inside the file loading

```dart
import 'package:world_time/services/world_time.dart';
```

- Now lets create a new function call 'setupWorldTime()' that are going to create a new instance of that WorldTime() class.

```dart
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() {
  WorldTime instance =
      WorldTime(location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');

  instance.getTime();
  }

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

- Now we need to change the initState function to call this new function.

```dart
class _LoadingState extends State<Loading> {

  void setupWorldTime() {
  WorldTime instance =
      WorldTime(location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');

  instance.getTime();
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
``` 

- Now we have access to the time property (this property are inside the WorldTime class). But because the setTime() function is a asynchronous function, we cannot use this property strait away.

- If we do something like 

```dart
print(instance.time);
```

- It is going to try to print the time even before we finish the request from our API.
  
  - So it will be nice to put a 'await' key word in front of the part that we are calling the getTime() method.
  
  - But to use a 'await' key word in front of a custom asynchronous function like getTime() we need to put the *Future* type in front of the function, and surround the 'void' key word with <>.
    
    - This are telling dart that the function are going to temporarily return whats is know as a Future.

    - Future is a bit like a promise in JavaScript

    - It means is a placeholder value until the function is complete

    - Is telling that in some point we are going to return 'void' but only when this function is complete.

```dart
Future<void> getTime() async {
  // Make the request
  Response response = await get('http://worldtimeapi.org/api/timezone/$url');

  Map data = jsonDecode(response.body);
  // print(data);

  // Get properties from data
  String datetime = data['datetime'];
  String offset = data['utc_offset'].substring(1, 3);
  // print(datetime);
  // print(offset);

  // Create a dateTime object
  DateTime now = DateTime.parse(datetime);
  now = now.add(Duration(hours: int.parse(offset)));

  // Set the time property
  time = now.toString();
}
```

- Now inside the loading file we need to transform the setupWorldTime() function in to a 'async' function and use the *await* key word.

```dart
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');

    await instance.getTime();
    print(instance.time);
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
```

- Now what we can do is to output this time in the UI

- Lets create a new String inside the State object and set it a value of 'loading'

- Now instead of output the Text() widget, we are going to output a Padding() widget with the variable that we create.

```dart
class _LoadingState extends State<Loading> {
  String time = 'loading';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');

    await instance.getTime();
    print(instance.time);
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Text(time),
      ),
    );
  }
}
```

- So when this widget tree is created is going to show loading, but after the setupWorldTime() function ends, once we get the data back, we are going to use setState() to update that *time* property.

```dart
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');

    await instance.getTime();
    setState(() {
      time = instance.time;
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Text(time),
      ),
    );
  }
}
```


# Error Handling:

So far our code is running correctly, but if in some point we get an error when we try to collect the data.

To combat this we are going to use a Try and Catch block.

```dart
try {
  // Do something
}
catch (err) {
  // Do something else
}
```

- So lets put all our code of the getTime() function inside the **try**, because this is what we are trying to do.
  - And if we catch any error we are going to print it on **catch** 

```dart
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // URL to an flag icon
  String url; // URL for the API endpoint

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      // print(data);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // Create a dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      time = now.toString();
    } catch (err) {
      print('Caught Error: $err');
    }
  }
}
```

- But now we are getting a red screen in our app, to avoid this lets set the *time* variable to something inside the catch, so that its going to display in the screen.

```dart
catch (err) {
  print('Caught Error: $err');
  time = 'Could not get the Data';
}
```

# Passing Route Data:

Now when we get back the time from the API is going to be a good time to redirect to the **Home** page.

First of all lets get rid of the print() statements and output to the loading page only a text saying 'Loading'. And we can get rid of the time property inside this page also. (remember to delete also the setState())  


- Before when we want to push to another route we stack it on top of the page that we are with the Navigator object and using a method call 'pushNamed'. But now we don't want to keep the loading route underneath.

- Instead we are going to use a method call 'pushReplacementNamed'

```dart
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');
    await instance.getTime();

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Text('Loading'),
      ),
    );
  }
}
```

- Now inside the Home screen we want to put the data, but unfortunately inside this screen (in the home file) we don't have access to that data. But have a way to send the data from this widget to that new route, or new widget, and that is using a third parameter inside the 'pushReplacementNamed()' method.
  
  - This third parameters is a named parameter with key word 'arguments' and it is going to be a Map.

```dart
Navigator.pushReplacementNamed(context, '/home', arguments: {});
```

- Inside this Map, is going to be a set of Key Value pairs into the widget or the screen we route to, which is the Home screen.

  - We want to send a fill different properties, the location, flag and time. Because we want to show this on the home screen.

  - When we create a new instance, this has all the properties that we need, so we create a Map with the key and this values from the instance.

```dart
void setupWorldTime() async {
  WorldTime instance = WorldTime(
      location: 'Lisbon', flag: 'portugal.png', url: 'Europe/Lisbon');
  await instance.getTime();

  Navigator.pushReplacementNamed(context, '/home', arguments: {
    'location': instance.location,
    'flag': instance.flag,
    'time': instance.time,
  });
}
```

- Now we are passing this properties to the next route.

- The first thing we need to do is to declare some variable inside the state object to store this data in. 
  
  - Lets made this a Map, because we are passing a map through the route. We call it 'data' and set to an empty Map.

  - Now inside the **build** method is that where we receive the arguments that we pass from the loading file.

  - The way we receive this arguments is by using the **ModalRoute** object then *.of(context)* and we pass in the context (because of this has to be inside the **build()** method). And then we do *.settings* and *.arguments*

    - This is going to be the arguments that we receive from the loading file, so it is going to be a Map of data

    - So now we can update the Map 'data' that we create before.


```dart
class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/location');
              },
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

- Now inside this widget we can access anyone of this properties.


# Formatting and Showing Data:

The time that we get is still in a weird format, to format to a better way we are going to use a package call **intl**
'https://pub.dev/packages/intl'

Have to install it editing the pubspec.yaml file.

We are going to format the date inside the world_time file, where we are making the request.

- We need first to import that package

- Now what we need to do is use a Function that is provide to us by that package call **DateFormat** then use a method call *.jm()* then another method call *.format(now)* where we pass our data that we grab from the API 'now'. (This are going to take place where we where formatting the data to a String)

```dart
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // URL to an flag icon
  String url; // URL for the API endpoint

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      // print(data);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // Create a dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      time = DateFormat.jm().format(now);
    } catch (err) {
      print('Caught Error: $err');
      time = 'Could not get the Data';
    }
  }
}
```

## Displaying the Data in Home Screen:

Now we have this data inside the Home screen let use it inside the template.

- The **FlatButton** widget is inside a widget **Column** so lets add new widgets to it.

- First lets create some space between by using **SizedBox** widget

- Now we add a **Row** because we are going to have two things next to each other. The little icon of the flag and the location.

  - We are not going to do the Icon from now, just the **text** widget. And style it a little bit.

```dart
return Scaffold(
  backgroundColor: Colors.grey[200],
  body: SafeArea(
    child: Column(
      children: <Widget>[
        FlatButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/location');
          },
          icon: Icon(Icons.edit_location),
          label: Text('Edit Location'),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data['location'],
              style: TextStyle(
                fontSize: 28,
                letterSpacing: 2,
              ),
            )
          ],
        )
      ],
    ),
  ),
);
``` 

- Now lets wrap the **Column** inside the **SafeArea** in a **Padding** widget

- Inside the **Column** we are going to make another space and add a **Text** widget that are going to show the *time* property that it is inside the *data*.

```dart
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    // print(data);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                icon: Icon(Icons.edit_location),
                label: Text('Edit Location'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

# Loaders / Spinners:

Now let style a little bit the Loading screen. We are going to use a package call 'flutter_spinkit'
'https://pub.dev/packages/flutter_spinkit'

Install and import inside the loading file.

- Inside the loading file, the **Scaffold** body are going to receive a **Center** widget. 

  - This are going to center our next widget that is the **SpinKitFadingCircle()**

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ));
}
```


# Ternary Operators: 

We are going to use the Ternary Operator to show a image in the background of day and night depending on the time.

- First of all lets create another property inside the world_time file that is going to be a Boolean to decide if it is day or night.

```dart
String location; // Location name for the UI
String time; // Time in that location
String flag; // URL to an flag icon
String url; // URL for the API endpoint
bool isDaytime; // True or false if is day time or not
```

- We need a condition to decide if it is day or night, to set the property to *true* or *false*. To do that we can use the Ternary Operator

  - Before convert the time to a String, we verify if the hour is in between 6h and 20h (day time).

  - And set the value of the property **isDaytime** to true if the statement is true and to false otherwise.

```dart
Future<void> getTime() async {
  try {
    // Make the request
    Response response =
        await get('http://worldtimeapi.org/api/timezone/$url');

    Map data = jsonDecode(response.body);
    // print(data);

    // Get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    // print(datetime);
    // print(offset);

    // Create a dateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    // Set the time property
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
  } catch (err) {
    print('Caught Error: $err');
    time = 'Could not get the Data';
  }
}
```

- Now in the loading file we have to pass this new property to the home file, as it was done to the others.

```dart
Navigator.pushReplacementNamed(context, '/home', arguments: {
  'location': instance.location,
  'flag': instance.flag,
  'time': instance.time,
  'isDaytime': instance.isDaytime,
});
```

- Download the two pictures, create a assets folder, put them inside and add the assets folder to the pubspec.yaml file.

- Now in the home file we need again to check if the property the we receive is true or false. So lets create another property that are going to receive different String with pass to the images depending on the value of the boolean *isDaytime*.

```dart
class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    // print(data);

    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';

    // ----------------------------------
```

- Now lets use a combination of **Container** and **BoxDecoration** widgets.

- Wrap everything below the **SafeArea** with an **Container** and inside it wi going to have a decoration property, and inside this we are going to have a **BoxDecoration**

  - For a image property inside the **BoxDecoration** we use a **DecorationImage**, that allow us to apply a background image to the screen.
    
    - This widget get two properties.
      1. image: that takes the AssetImage('')
      2. fit: that takes BoxFit.cover (cover the entire screen)

```dart
return Scaffold(
  backgroundColor: Colors.grey[200],
  body: SafeArea(
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
        

      // --------------


);
```

- Now we where left with a grey little stripe o top of the image, so to cover that up we need to give a background color to the **Scaffold**

- We are going to need another property of type *Color* and assign a color to it depending if is day or night.

```dart
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,

    // ----------------------

```

- Lets change the colors of the icon and the text to show a little bit more in this background

```dart
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // URL to an flag icon
  String url; // URL for the API endpoint
  bool isDaytime; // True or false if is day time or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      // print(data);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // Create a dateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (err) {
      print('Caught Error: $err');
      time = 'Could not get the Data';
    }
  }
}
```

# List View Builder:

Now we are going to make the layout for the Location screen.