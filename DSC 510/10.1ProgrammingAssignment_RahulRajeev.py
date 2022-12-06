# DSC 510-T303
# Week 10
# 10.1 Programming Assignment
# Author Rahul Rajeev
# 11/2/2022

import requests
import json

# creating a function that makes a get request,
# parses, and displays data
def get_joke(n):
    url = "https://api.chucknorris.io/jokes/random"
    response = requests.request("GET", url)
    parsed = json.loads(response.text)
    print(f"{'':=<60}")
    print(f'This is joke number {n}.')
    print(json.dumps(parsed['value']))
    print("\U0001F923" * 3)
    print(f"{'':=<60}")

# function that creates a unique question after the
# first time asking for a joke
def ask_a_joke(first_time):
    if first_time:
        question = 'Would you like to hear a joke? ' \
                   'Please enter yes or no: '
    else:
        question = 'Would you like to hear another joke? ' \
                   'Please enter yes or no: '
    answer = str(input(question)).lower().strip()
    return answer

# defining main function
def main():
    first_time = True
    n = 1
    print("Welcome to Chuck Norris Joke Extravaganza!\n")
    answer = ask_a_joke(first_time)
    # creating a while loop that exits only if user wants
    while answer not in ('no', 'n'):
        if answer in ('yes', 'y'):
            get_joke(n)
            first_time = False
            n += 1
        else:
            print('You did not enter a valid response. '
                  'Please try again!')
        answer = ask_a_joke(first_time)
    # exit statement
    print("Please come back when you feel like "
          "hearing Chuck Norris Jokes!")


if __name__ == "__main__":
    main()

# Change#:1
# Change(s) Made: added emojis using unicode to the response
# with keys and frequencies
# Date of Change: 11/2/2022
# Author: Rahul Rajeev
# Change Approved by: Professor Michael Eller
# Date Moved to Production: 11/3/2022