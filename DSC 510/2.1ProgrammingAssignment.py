# DSC 510-T303
# Week 2
# 2.1 Programming Assignment
# Author Rahul Rajeev
# 9/9/2022

# storing name and initial welcoming statement.
name = str(input("What is your name? "))
print("Welcome " + name + ", let's calculate the "
                          "installation cost of fiber optic cable!")
# storing company name and the amount of feet.
company = str(input("Please input your company's name: "))
feet = float(input("Now, please input the number of feet of "
                   "fiber optic cable you would like to install: "))
# calculating the installation cost of the fiber optic cable.
total_cost = float(round(feet * 0.87, 2))
# confirming whether user wants receipt or not
answer = None
while answer not in ("yes", "no"):
    answer = input("Would you like a receipt? Please enter yes or no? ")
    if answer == "yes":
        print("Thank you!\n" + name + "\n" + company +
              "\nNumber of feet installed: " + str(feet) +
              "\nThe total cost: $" + str(total_cost))
    elif answer == "no":
        print("Have a great day " + name + " !")
    else:
        print("Please enter yes or no.")

# Change#:1
# Change(s) Made: Added while loop for answer to the receipt question
# Date of Change: 9/9/2022
# Author: Rahul Rajeev
# Change Approved by: Dr. Michael Eller
# Date Moved to Production: 9/9/2022
