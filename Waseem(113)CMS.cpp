#include <iostream>
#include <vector>
#include <string>
#include <ctime>
#include <cstdlib>

using namespace std;

class User {
public:
    string name;
    string email;
    double balance;

    User(string n, string e) {
        name = n;
        email = e;
        balance = 0;
    }

    void payInstallment(double amount) {
        balance += amount;
        cout << name << " paid an installment of $" << amount << endl;
    }
};
class Committee {
public:
    string name;
    double totalAmount;
    double monthlyInstallment;
    int duration;
    vector<User*> members;

    Committee(string n, double total, double monthly, int dur) {
        name = n;
        totalAmount = total;
        monthlyInstallment = monthly;
        duration = dur;
    }

    void addMember(User* user) {
        members.push_back(user);
        cout << user->name << " joined the committee: " << name << endl;
    }

    void collectInstallment() {
        cout << "\nCollecting Installments..." << endl;
        for (User* user : members) {
            user->payInstallment(monthlyInstallment);
        }
    }

    void drawWinner() {
        if (members.empty()) {
            cout << "No members to draw a winner!" << endl;
            return;
        }
        srand(time(0));
        int winnerIndex = rand() % members.size();
        cout << "\nWinner of this cycle: " << members[winnerIndex]->name << " ??" << endl;
    }
};
void displayMenu() {
    cout << "\n===== Committee Management System =====" << endl;
    cout << "1. Register User" << endl;
    cout << "2. Create Committee" << endl;
    cout << "3. Add Member to Committee" << endl;
    cout << "4. Collect Installments" << endl;
    cout << "5. Draw Winner" << endl;
    cout << "6. Exit" << endl;
    cout << "Enter your choice: ";
}
int main() {
    vector<User*> users;
    vector<Committee*> committees;
    int choice;

    do {
        displayMenu();
        cin >> choice;
        cin.ignore();

        switch (choice) {
            case 1: {
                string name, email;
                cout << "Enter Name: ";
                getline(cin, name);
                cout << "Enter Email: ";
                getline(cin, email);
                users.push_back(new User(name, email));
                cout << "User Registered Successfully!\n";
                break;
            }
            case 2: {
                string name;
                double total, monthly;
                int duration;
                cout << "Enter Committee Name: ";
                getline(cin, name);
                cout << "Enter Total Amount: ";
                cin >> total;
                cout << "Enter Monthly Installment: ";
                cin >> monthly;
                cout << "Enter Duration (in months): ";
                cin >> duration;
                committees.push_back(new Committee(name, total, monthly, duration));
                cout << "Committee Created Successfully!\n";
                break;
            }
            case 3: {
                if (users.empty() || committees.empty()) {
                    cout << "No users or committees available!\n";
                    break;
                }
                cout << "Select User (by index):\n";
                for (size_t i = 0; i < users.size(); i++)
                    cout << i + 1 << ". " << users[i]->name << endl;
                int userIndex;
                cin >> userIndex;
                userIndex--;

                cout << "Select Committee (by index):\n";
                for (size_t i = 0; i < committees.size(); i++)
                    cout << i + 1 << ". " << committees[i]->name << endl;
                int commIndex;
                cin >> commIndex;
                commIndex--;

                committees[commIndex]->addMember(users[userIndex]);
                break;
            }
            case 4: {
                if (committees.empty()) {
                    cout << "No committees available!\n";
                    break;
                }
                cout << "Select Committee (by index) to collect installment:\n";
                for (size_t i = 0; i < committees.size(); i++)
                    cout << i + 1 << ". " << committees[i]->name << endl;
                int commIndex;
                cin >> commIndex;
                commIndex--;

                committees[commIndex]->collectInstallment();
                break;
            }
            case 5: {
                if (committees.empty()) {
                    cout << "No committees available!\n";
                    break;
                }
                cout << "Select Committee (by index) to draw a winner:\n";
                for (size_t i = 0; i < committees.size(); i++)
                    cout << i + 1 << ". " << committees[i]->name << endl;
                int commIndex;
                cin >> commIndex;
                commIndex--;

                committees[commIndex]->drawWinner();
                break;
            }
            case 6:
                cout << "Exiting Program. Thank you!\n";
                break;
            default:
                cout << "Invalid Choice! Try again.\n";
        }

    } while (choice != 6);

    for (User* user : users) delete user;
    for (Committee* committee : committees) delete committee;

    return 0;
}
