# DSC 510-T303
# Week 5
# 5.1 Programming Assignment
# Author Rahul Rajeev
# 9/29/2022

# defining functions
# perform calculation function
def performCalculation(op):
    result = 0
    # user inputs for two numbers and making sure that the inputs are
    # actual integers
    while True:
        try:
            num1 = float(input("Please enter first number: "))
            num2 = float(input("Please enter second number: "))
            break
        except ValueError:
            print("Please enter numerical values!")
    # going through the different possible operation options
    if op == '+':
        result = num1 + num2
    elif op == "-":
        result = num1 - num2
    elif op == "*":
        result = num1 * num2
    # making sure to include special case where the user
    # tries to divide by 0
    elif op == "/" and num2 == 0.0:
        print("It's not possible to divide a number by 0!")
    elif op == "/" and num2 != 0.0:
        result = num1 / num2

    print("The [" + op + "] of your two numbers is " +
          str(float(result)) + ".")
    # calling main function again in case the user
    # would like to go again
    main()


# defining calculate average
def calculateAverage():
    # initializing number list
    num_list = []
    print("This function calculates the average of any length "
          "of numbers you would like to input")
    while True:
        try:
            n = int(input("Please input the number of integers "
                          "you would like to calculate the average: "))
            break
        except ValueError:
            print("Please enter a numerical value!")
    # creating a stored variable m such that I can show
    # the number the user is currently on
    m = n
    # looping through the number of values the user wants to input,
    # taking away one each time
    while n != 0:
        # making sure value inputted is a numerical value
        while True:
            try:
                num = float(input("Please enter your "
                                  "[" + str(m - (n - 1)) + "] number: "))
                break
            except ValueError:
                print("Please enter a numerical value!")
        # appending the numbers entered into the list
        num_list.append(num)
        # iterating from n to 0
        n = n - 1
    # calculating the average of a list of numbers
    average = sum(num_list) / len(num_list)
    print("The average of your " + str(n) + "numbers is " +
          str(float(average)) + ".")
    # calling main function again to see if the user would
    # like to continue making calculations
    main()


# defining main function
def main():
    # lists of correct responses to check through
    user_op_responses = ['+', '-', '*', '/']
    user_choice_responses = ['A', 'B', 'C']
    print('\nPlease select the type of calculation '
          'you would like to do: '
          '\n1) Arithmetic: A\n2) Average: B\n3) Exit: C')
    user_choice = input('\nPlease select the type of calculation '
                        'you would like to do: \n1) Arithmetic: A'
                        '\n2) Average: B\n3) Exit: C'
                        '\nEnter here: ').upper().strip()
    while user_choice not in user_choice_responses:
        user_choice = input('Please enter an appropriate answer. '
                            '\n Please enter A, B, or C.')
    if user_choice == 'A':
        user_op = input('\nFor addition, enter +. '
                        '\nFor subtraction enter -. '
                        '\nFor multiplication enter *. '
                        '\nFor division enter /. '
                        '\nChoose one to continue: ')
        while user_op not in user_op_responses:
            user_op = input("Please enter a valid arithmetic symbol. "
                            "\n+, -, *, or /. "
                            "\nChoose one to continue: ")
        performCalculation(user_op)
    if user_choice == 'B':
        calculateAverage()
    if user_choice == 'C':
        print("Thanks for using this calculator!")


if __name__ == "__main__":
    main()

# Change#: 1
# Change(s) Made: Added while True loops to ensure the
# user is inputting the right values
# Date of Change: 9/30/22
# Author: Rahul Rajeev
# Change Approved by: Michael Eller
# Date Moved to Production: 9/30/2022
