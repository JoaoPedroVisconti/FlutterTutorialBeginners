# Lists of Data:

Lets start a new project from scratch and call it 'quotes' and again delete all the content in the main.dart file below the main function, and also delete the test folder.

Create a StatefulWidget call 'QuoteList' and instantiate it inside a MaterialApp() widget at the 'runApp' function

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Lets create the Scaffold() widget with a background color and a appBar
  - The body it is going to be a Column() that going to take a list after.
  - Lest initialize the list call 'quotes' with type string as an list with three quotes.

```dart
class _QuoteListState extends State<QuoteList> {
  List<String> quotes = [
    'First quote',
    'Second quote',
    'Third quote',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
```

- So we are going to use from now the map function to mao through our list of data and out put a small widget to each one.
  - So inside the children property of the Column(), we going to take the 'quotes' and use the map function to map over it, quote.map()
  - The mao function cycle through a list of data and for each item it going to perform a function, and then we can return a value for each one of those functions. quotes.map(() {})
  - This returns a iterable, but the children:  property expects a list, so we use .toList()


```dart
class _QuoteListState extends State<QuoteList> {
  List<String> quotes = [
    'First quote',
    'Second quote',
    'Third quote',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: quotes.map((quote) {
          return Text(quote);
        }).toList(),
      ),
    );
  }
}
```

- We have only one argument that we are returned from the function inside the function map(), so we can use a arrow function to simplify the code 

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[200],
    appBar: AppBar(
      title: Text('Awesome Quotes'),
      centerTitle: true,
      backgroundColor: Colors.teal[700],
    ),
    body: Column(
      children: quotes.map((quote) => Text(quote)).toList(),
    ),
  );
}
```

# Custom Classes:

Maybe each one of the quotes that we used before has an author. So we going to associate the author with each one.

For this we going to have a list of quotes objects and each object are going to have the quote text property and the quote author property. For this we need to make our own quote class.

- So inside the lib folder we are going to create a new file call quote.dart
- Class is quite a blueprint for an object type, its describe what functions and properties that data has.
- So we need a text property and a author property

```dart
class Quote {
  String text;
  String author;
}
```

- So now we need the constructor that is what takes the values in when we create the object and instantiate the class.
- So the constructor are going to take in two parameters, the text and the author, and inside we are going to set the properties of the class that we declare outside the constructor to the values that are passed in to it.
  - An example of how we can create a new Quote object it is inside the code. (We are going to remove later)

```dart
class Quote {
  String text;
  String author;

  Quote(String text, String author) {
    this.text = text;
    this.author = author;
  }
}

Quote newQuote = Quote('Some quote from Visconti', 'Visconti');
```
 
- We different ways that we can assign this values to the object
- The first is Named Parameters, if we add curly braces around the declaration of the parameters in the constructor, we are telling the constructor that this are Named Parameters.
  - So when we pass those in we pass the names and the values of this data.

```dart
class Quote {
  String text;
  String author;

  Quote({ String text, String author }) {
    this.text = text;
    this.author = author;
  };
}

Quote newQuote = Quote(text: 'Some quote from Visconti', author: 'Visconti');
```

- Another good thing of using Named Parameters is that we can simplify our code, passing the actual property of our class inside the parameters of the constructor.

```dart
class Quote {
  String text;
  String author;

  Quote({ this.text, this.author });
}

Quote newQuote = Quote(text: 'Some quote from Visconti', author: 'Visconti');
```

- Now we can delete our example inside this file and use this class inside the main.dart file.
- The first thing is to import on the top
- Now instead of creating a list of Strings call quotes, we are going to create a list of Quotes.

```dart
class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: 'Quote number 1', author: 'Author 1'),
    Quote(text: 'Quote number 2', author: 'Author 2'),
    Quote(text: 'Quote number 3', author: 'Author 3'),
  ];

  //----------------

```

- Now each quote refers to the quote object and down in the body when we trying to output the text, we now need to pass a string inside the Text() widget, and then we are going to output the different properties that we get inside the Quote object.
  - When we output a variable inside a string we use the dollar sign as: Text('$someVariable'). But in this case we are outputting a property inside the object, so we need to surround everything in curly braces as in: Text('${someVariable.property}')


```dart
class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: 'Quote number 1', author: 'Author 1'),
    Quote(text: 'Quote number 2', author: 'Author 2'),
    Quote(text: 'Quote number 3', author: 'Author 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: quotes
            .map((quote) => Text('${quote.text} - ${quote.author}'))
            .toList(),
      ),
    );
  }
}
```

# Card:

We now are just showing the text in our page, but now we are going to add some template to it. We are going to use for this a card template.

For this we are going to create a new function that going to return the template. This later on are going to be done in a different and better way. 

This function are going to be inside our state and has a return type that are going to be a widget, so we say the return type first then the function name that are going to be 'quoteTemplate', and then it going to take in an individual quote.

```dart
class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: 'Quote number 1', author: 'Author 1'),
    Quote(text: 'Quote number 2', author: 'Author 2'),
    Quote(text: 'Quote number 3', author: 'Author 3'),
  ];

  Widget quoteTemplate(quote) {

  }

  // -----------
```

- So we are going to call this function for each quote as we map through the list of quotes. We pass the quote in the function and return a widget tree with that quote.
- So we need the return, that going to return a Card() widget
  - Inside this card we are going to have two different widgets, one for the text, and one for the author, on top of each other. So we need a child widget Column().

```dart
Widget quoteTemplate(quote) {
  return Card(
    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: Column(
      children: <Widget>[
        Text(
          quote.text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          quote.author,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
          ),
        ),
      ],
    ),
  );
}
```

- Now what we need is to use this function inside our body, we are going to call the function and pass the 'quote' that was map through the list of Quote objects to this new function.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[200],
    appBar: AppBar(
      title: Text('Awesome Quotes'),
      centerTitle: true,
      backgroundColor: Colors.teal[700],
    ),
    body: Column(
      children: quotes.map((quote) => quoteTemplate(quote)).toList(),
    ),
  );
}
```

- Now lets add some padding to our cards and make them take the whole width of the page

```dart
import 'package:flutter/material.dart';
import 'quote.dart';

void main() {
  runApp(MaterialApp(
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(text: 'Quote number 1', author: 'Author 1'),
    Quote(text: 'Quote number 2', author: 'Author 2'),
    Quote(text: 'Quote number 3', author: 'Author 3'),
  ];

  Widget quoteTemplate(quote) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              quote.text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              quote.author,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: quotes.map((quote) => quoteTemplate(quote)).toList(),
      ),
    );
  }
}
```


# Extracting Widgets:

