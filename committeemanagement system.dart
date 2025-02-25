import 'dart:io';
import 'dart:math';

class User {
  String name;
  String email;
  double balance =0;

  User(this.name, this.email) {
    balance = 0;
  }

  void payInstallment(double amount) {
    balance += amount;
    print('$name paid an installment of \$${amount.toStringAsFixed(2)}');
  }
}

class Committee {
  String name;
  double totalAmount;
  double monthlyInstallment;
  int duration;
  List<User> members;

  Committee(this.name, this.totalAmount, this.monthlyInstallment, this.duration)
      : members = [];

  void addMember(User user) {
    members.add(user);
    print('${user.name} joined the committee: $name');
  }

  void collectInstallment() {
    print('\nCollecting Installments...');
    for (User user in members) {
      user.payInstallment(monthlyInstallment);
    }
  }

  void drawWinner() {
    if (members.isEmpty) {
      print('No members to draw a winner!');
      return;
    }
    Random rand = Random();
    int winnerIndex = rand.nextInt(members.length);
    print('\nWinner of this cycle: ${members[winnerIndex].name} 🎉');
  }
}

void displayMenu() {
  print('\n===== Committee Management System =====');
  print('1. Register User');
  print('2. Create Committee');
  print('3. Add Member to Committee');
  print('4. Collect Installments');
  print('5. Draw Winner');
  print('6. Exit');
  print('Enter your choice: ');
}

void main() {
  List<User> users = [];
  List<Committee> committees = [];
  int choice;

  do {
    displayMenu();
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        {
          print('Enter Name: ');
          String name = stdin.readLineSync()!;
          print('Enter Email: ');
          String email = stdin.readLineSync()!;
          users.add(User(name, email));
          print('User Registered Successfully!\n');
          break;
        }
      case 2:
        {
          print('Enter Committee Name: ');
          String name = stdin.readLineSync()!;
          print('Enter Total Amount: ');
          double total = double.parse(stdin.readLineSync()!);
          print('Enter Monthly Installment: ');
          double monthly = double.parse(stdin.readLineSync()!);
          print('Enter Duration (in months): ');
          int duration = int.parse(stdin.readLineSync()!);
          committees.add(Committee(name, total, monthly, duration));
          print('Committee Created Successfully!\n');
          break;
        }
      case 3:
        {
          if (users.isEmpty || committees.isEmpty) {
            print('No users or committees available!\n');
            break;
          }
          print('Select User (by index):');
          for (int i = 0; i < users.length; i++) {
            print('${i + 1}. ${users[i].name}');
          }
          int userIndex = int.parse(stdin.readLineSync()!) - 1;

          print('Select Committee (by index):');
          for (int i = 0; i < committees.length; i++) {
            print('${i + 1}. ${committees[i].name}');
          }
          int commIndex = int.parse(stdin.readLineSync()!) - 1;

          committees[commIndex].addMember(users[userIndex]);
          break;
        }
      case 4:
        {
          if (committees.isEmpty) {
            print('No committees available!\n');
            break;
          }
          print('Select Committee (by index) to collect installment:');
          for (int i = 0; i < committees.length; i++) {
            print('${i + 1}. ${committees[i].name}');
          }
          int commIndex = int.parse(stdin.readLineSync()!) - 1;

          committees[commIndex].collectInstallment();
          break;
        }
      case 5:
        {
          if (committees.isEmpty) {
            print('No committees available!\n');
            break;
          }
          print('Select Committee (by index) to draw a winner:');
          for (int i = 0; i < committees.length; i++) {
            print('${i + 1}. ${committees[i].name}');
          }
          int commIndex = int.parse(stdin.readLineSync()!) - 1;

          committees[commIndex].drawWinner();
          break;
        }
      case 6:
        print('Exiting Program. Thank you!\n');
        break;
      default:
        print('Invalid Choice! Try again.');
    }
  } while (choice != 6);
}
