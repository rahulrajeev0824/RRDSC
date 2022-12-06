# DSC 510-T303
# Week 11
# 11.1 Programming Assignment
# Author Rahul Rajeev
# 11/7/2022

# importing locale to get the currency attribute
import locale

# creating the cash register class
class CashRegister:
    def __init__(self):
        self.item_count = 0
        self.total_price = 0

    def addItem(self, price):
        self.total_price = self.total_price + price
        self.item_count += 1

    def getTotal(self):
        locale.setlocale(locale.LC_ALL, 'en_US.utf-8')
        return locale.currency(self.total_price, symbol=True)

    def getCount(self):
        return self.item_count

# defining main with the while loop for user input

def main():
    print("Welcome to Rahul's Grocery Store! Please follow the "
          "directions below to get your cart total!\n")
    register = CashRegister()
    while True:
        ask_price = input('Please enter the price of the item '
                          'to be included or type "quit" to '
                          'calculate the total: ').strip().strip('$').lower()
        if ask_price != 'quit':
            try:
                flt_price = float(ask_price)
                register.addItem(flt_price)
            except ValueError:
                print(f'\nThe last price you entered was not a valid input. '
                      f'Please try again.\n')
        else:
            break
    if ask_price == 'quit':
        print(f'\nThere are {register.getCount()} items in your '
              f'cart that have a total of {register.getTotal()}.\n'
              f'Thanks for shopping!')


# calling main
if __name__ == '__main__':
    main()


# Change#:1
# Change(s) Made: created a try/except block for value error
# Date of Change: 11/8/2022
# Author: Rahul Rajeev
# Change Approved by: Professor Michael Eller
# Date Moved to Production: 11/8/2022
