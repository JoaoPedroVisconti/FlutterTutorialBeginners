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

