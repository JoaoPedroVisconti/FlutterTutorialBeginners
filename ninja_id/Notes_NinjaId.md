# Ninja ID Project:

Lets create our first simple app in Flutter, call the new project ninja_id

- First delete the folder tests. We are not going to need this now
- Delete all the code inside the main file bellow the main function
- The main function are going to return a MaterialApp() widget that contains a property 'home' that takes our new NinjaCard() widget
  - The NinjaCard() widget is a class that extends the StatelessWidget()
    - Can use the snippet 'stless'+TAB

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NinjaCard(),
  ));
}

class NinjaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

- The NinjaCard widget going to return a Scaffold() widget as before and we are going to add a app bar to it.
  - Give the background color to the Scaffold also.
  - Property of Scaffold() is 'appBar' and it takes AppBar() widget, and this takes another property call title, that it is also a widget of Text()
  - Now we change some of the properties that the AppBar() has
    - Change the color
    - Center the text with the property 'centerTitle'
    - Remove the shadow that has from the app bar with the property 'elevation' set to 0

```dart
void main() {
  runApp(MaterialApp(
    home: NinjaCard(),
  ));
}

class NinjaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Ninja ID Card'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
    );
  }
}
```

Now we need to add the body property of the Scaffold widget. This are going to be a Column() widget wrapped in Padding() to give some space between the margins of the phone

```dart
body: Padding(
  padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
  child: Column(
    children: [],
  ),
)
```

Inside the Column() widget we are going to have a Text() widget styled with the style property and taking the TextStyle() widget.

- Lest create another text with the same properties but with different size font and weight

- To add some space between the two Text() widgets we can use another widget call SizedBox() that takes as parameters the values for the height and/or width, and create a empty space with this values.

- After the texts we are going to have a Row() widget to add some content in a row matter
  - We can use the SizedBox to give some space in the horizontal direction also between the Icon and the Text

```dart
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'NAME',
      style: TextStyle(
        color: Colors.grey,
        letterSpacing: 2,
      ),
    ),
    SizedBox(height: 10),
    Text(
      'Visconti',
      style: TextStyle(
        color: Colors.amberAccent[200],
        letterSpacing: 2,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 30),
    Text(
      'CURRENT NINJA LEVEL',
      style: TextStyle(
        color: Colors.grey,
        letterSpacing: 2,
      ),
    ),
    SizedBox(height: 10),
    Text(
      '8',
      style: TextStyle(
        color: Colors.amberAccent[200],
        letterSpacing: 2,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 30),
    Row(
      children: [
        Icon(
          Icons.email,
          color: Colors.grey[400],
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'visconti@email.com',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            color: Colors.grey[400],
          ),
        )
      ],
    ),
  ],
),
```

- Now lets put some image as an Avatar at the top of the app
  - Create the assets folder to store the image. Don't forget to add the assets folder inside the pubspec.yaml file.

  - For this we are going to use a widget call CircleAvatar()
    - This has a couple of properties also
    - Lets place it in the middle wrapping inside the Center() widget

```dart
Center(
  child: CircleAvatar(
    backgroundImage: AssetImage('assets/BatAvatar.jpg'),
    radius: 40,
  ),
),
```

- Now lets place some type of divider between the avatar image and the texts
  - Lets use a Divider() widget. It takes two properties the height and the color

All Code:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NinjaCard(),
  ));
}

class NinjaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Ninja ID Card'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/BatAvatar.jpg'),
                  radius: 40,
                ),
              ),
              Divider(
                height: 60,
                color: Colors.grey[800],
              ),
              Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Visconti',
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'CURRENT NINJA LEVEL',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '8',
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'visconti@email.com',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
```