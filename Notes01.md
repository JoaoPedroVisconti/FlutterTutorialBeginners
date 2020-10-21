# Dart Language

Dart is a OOP as python or others, to create classes and function

This code create the main function (the function that it is call when run the code), and a class User (The blue print, the thing that describes the user object)

- The class User has two attributes and one method. This attributes until now are fix
- In the main function, the first 'User' dictate what variable type we are creating 'userOne' and we invoke the User() as like it was a function storing it in a variable 'userOne' (creating the object userOne)

```dart
void main() {
  User userOne = User();
  print(userOne.username)
}

class User {
  String username = 'mario';
  int age = 25;

  void login () {
    print('User logged in')
  }
}
```

We can overwrite the behavior of the class by creating a constructor, and this constructor has to has the same name as the class it self 'User()'
- Inside the constructor we take the two parameters username and age, so when we create the user object we pass those arguments and create the User inside the constructor.
  - We need to define this parameters (they don't have to has the same name as the variable declared before)
  - This parameters are passed to the constructor from the creation of the object in the main function.
  - Now we can pass inside the constructor the values of the arguments that it takes to the variables of the class User


```dart
void main() {
  User userOne = User('luigi', 25);
  print(userOne.username);
  print(userOne.age);

  userOne.login()
}

class User {

  String username;
  int age;

  User(String username, int age) {
    this.username = username;
    this.age = age;
  }

  void login() {
    print('User logged in')
  }

}
```

Now we can create a SuperUser class that are going to inherit the behavior of the class User and add another method that for some reason we don't want that the User class has. (So it extends from the User class)
- The first thing it is create the extra function 'publish'
- We have to create the constructor for the SuperUser class
  - But not like the User, we don't set the values that we pass to the SuperUser as arguments inside this constructor, we inherit from the User which has those values. So we need to call 'super' which call the constructor from the User class and pass those values in.


```dart
void main() {
  User userOne = User('luigi', 25);
  print(userOne.username);
  print(userOne.age);
  userOne.login()

  SuperUser userTwo = SuperUser('mario', 30)
  print(userTwo.username);
  print(userTwo.age);
  userTwo.login()
  userTwo.publish()

}

class User {

  String username;
  int age;

  User(String username, int age) {
    this.username = username;
    this.age = age;
  }

  void login() {
    print('User logged in')
  }
}

class SuperUser extends User {

  SuperUser(String username, int age) : super(username, age);

  void publish() {
    print('Publish Update')
  }
}
```

# Creating the Flutter app

First of all install the Flutter extension for VSCode. Have a simple tutorial into how setting up everything in the VSCodein the main page of FLutter 'https://flutter.dev/docs/get-started/editor?tab=vscode'.

We have to install the Android Studio to be able to create the emulator. I created an Nexus 6 emulator from it, and in the vscode we can start it from the small bar bellow, or if it is not showing there, type in the command line.

```cmd
flutter emulator

<!-- See all the devices that we have install -->

flutter emulators --launch <emulator id>
```

Now everything are inside the vscode so we don't need to run with terminal anymore.