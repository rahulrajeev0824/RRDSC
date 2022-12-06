# DSC 510-T303
# Week 6
# 6.1 Programming Assignment
# Author Rahul Rajeev
# 10/5/2022

# defining main method
def main():
    # initializing the temperature list and temperature input variable
    temp_list = []
    temp_input = 0
    print("This program will accept temperature inputs "
          "and return the minimum, maximum,"
          "and number of temperatures inputted.")
    # starting the while loop using Q as the sentinel value
    while temp_input != 'Q':
        temp_input = input("Please enter a integer value for "
                           "temperature, positive or negative, "
                           "or enter 'Q' to stop: ").strip().upper()
        # checking whether the temp input is Q, a float, or neither
        while True:
            if temp_input == 'Q':
                break
            try:
                temp_input = float(temp_input)
                break
            except ValueError:
                temp_input = input("You didn't enter a temperature.\n"
                                   "Please enter a temperature "
                                   "or Q to stop: ").strip().upper()
        # breaking the loop so that Q isn't included
        # in the list of temperatures
        if temp_input == 'Q':
            break
        # appending each input to the
        # empty temperature list from earlier
        temp_list.append(temp_input)
    # considering the edge case
    # where the user exited the loop immediately
    # or inputted values that didn't work and then quit
    if len(temp_list) == 0:
        print("You didn't input any temperatures to "
              "further calculate minimum, maximum, and length.")
        print("Thanks for trying the program!")
    else:
        print("\nThe lowest temperature entered was "
              + str((min(temp_list))) + ".")
        print("The highest temperature entered was "
              + str(max(temp_list)) + ".")
        print("The number of temperature values entered is "
              + str(len(temp_list)) + ".")
        print("Thanks for trying the program!")


if __name__ == "__main__":
    main()

# Change#:1
# Change(s) Made: Added try/except statements to verify
# whether temperature input is the sentinel value
# Date of Change: 10/6/2022
# Author: Rahul Rajeev
# Change Approved by: Professor Michael Eller
# Date Moved to Production: 10/6/2022
