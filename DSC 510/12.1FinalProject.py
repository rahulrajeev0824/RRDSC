# DSC 510-T303
# Week 12
# 12.1 Final Project
# Author Rahul Rajeev
# 11/11/2022


# imports
import requests
import json
import time

# api call function for both zip and city
def get_weather(location, url, unit):
    # zip lookup
    if location.isdigit():
        loc_params = {'zip': location, 'units': unit[0],
                      'APPID': 'efedc770bbe316a305a7a304ec3084c1'}
    # city lookup
    else:
        loc_params = {'q': location, 'units': unit[0],
                      'APPID': 'efedc770bbe316a305a7a304ec3084c1'}
    web_response = requests.get(url, params=loc_params)
    try_response(web_response, location)
    if web_response.status_code == 200:
        print('Connected.')
    parsed_response = json.loads(web_response.text)
    weather_formatted(parsed_response, unit[1])

# api call for 5 day forecast
def get_forecast(location, url, unit):
    # zip lookup
    if location.isdigit():
        loc_params2 = {'zip': location, 'units': unit[0],
                       'cnt': 40, 'APPID': 'efedc770bbe316a305a7a304ec3084c1'}
    # city lookup
    else:
        loc_params2 = {'q': location, 'units': unit[0],
                       'cnt': 40, 'APPID': 'efedc770bbe316a305a7a304ec3084c1'}
    web_response2 = requests.get(url, params=loc_params2)
    try_response(web_response2, location)
    if web_response2.status_code == 200:
        print('Connected.')
    parsed_response2 = json.loads(web_response2.text)
    forecast_formatted(parsed_response2, unit[1])

# helper function for unit choice, returns tuple of unit print and unit choice
def unit_choice(choice):
    if choice == 'c':
        user_choice = 'metric'
        unit_print = f'{chr(176)} C'
    elif choice == 'f':
        user_choice = 'imperial'
        unit_print = f'{chr(176)} F'
    else:
        user_choice = 'default'
        unit_print = f'{chr(176)} K'
    return user_choice, unit_print

# Formatted weather function for the basic report
def weather_formatted(parsed, unit):
    city = str(json.dumps(parsed['name'])).replace('"', '')
    country = str(json.dumps(parsed['sys']['country'])).replace('"', '')
    timezone = int(json.dumps(parsed['timezone']))
    epoch = int(json.dumps(parsed['dt']))
    correct_time = timezone + epoch
    current_time = time.strftime("%A, %b %d, %Y %I:%M %p (local time)",
                                 time.gmtime(correct_time))
    temp = float(json.dumps(parsed['main']['temp']))
    high_temp = float(json.dumps(parsed['main']['temp_max']))
    low_temp = float(json.dumps(parsed['main']['temp_min']))
    pressure = float(json.dumps(parsed['main']['pressure']))
    humidity = float(json.dumps(parsed['main']['humidity']))
    conditions = str(json.dumps(parsed['weather'][0]['description'])).replace('"', '').title()
    print(f'\nHere is the weather report for {city}, {country} at {current_time}:\n'
          f"{'':=<85}\n"
          f'The current temperature is {temp}{unit}.\n'
          f'Expect a high of {high_temp}{unit} and a low of {low_temp}{unit}.\n'
          f'The pressure is {pressure} hPa and the humidity is {humidity}%.\n'
          f'The current weather conditions are {conditions}.\n'
          f"{'':=<85}\n")

# forecast format function
def forecast_formatted(parsed, unit):
    print(f"{'5 Day Forecast':35}{'Temperature':20}{'Conditions'}\n"
          f"{'':=<78}")
    # iterating over the list of values for every two intervals, i.e. every 6 hours
    for i in range(0, 39, 2):
        f_epoch = int(json.dumps(parsed['list'][i]['dt']))
        f_timezone = int(json.dumps(parsed['city']['timezone']))
        f_correct_time = f_timezone + f_epoch
        f_future_time = time.strftime("%a, %b %d, %Y %I:%M %p",
                                      time.gmtime(f_correct_time))
        f_temp = float(json.dumps(parsed['list'][i]['main']['temp']))
        f_pressure = float(json.dumps(parsed['list'][i]['main']['pressure']))
        f_humidity = float(json.dumps(parsed['list'][i]['main']['humidity']))
        f_conditions = str(json.dumps(parsed['list'][i]['weather']
                                      [0]['description'])).replace('"', '').title()
        print(f"{f_future_time:35} {f_temp}{unit:20}{f_conditions}")
        print(f"{'':20}| Pressure: {f_pressure:5} hPa | Humidity: {f_humidity}% |\n"
              f"{'':-<78}")

# try response function to raise for all kinds of errors
def try_response(response, location):
    try:
        response.raise_for_status()
    except requests.HTTPError as errorA:
        if response.status_code == 404:
            if location.isdigit():
                print(f"{location} is not a valid zip code.")
            else:
                if location.__contains__(','):
                    print(f"The location entered "
                          f"'{location[0:-2].title() + location[-2:].upper()}' "
                          f"was not found.")
                else:
                    print(f"The location entered '{location.title()}' was not found.")
        else:
            print("Sorry, this zip code doesn't make sense.")
            print(f'{errorA}')
    except requests.ConnectionError as errorB:
        print("Apologies, there was an error connecting to the web service...")
        print(errorB)
    except requests.Timeout as errorC:
        print("Apologies, you have been timed out...")
        print(errorC)
    except requests.RequestException as errorD:
        print('Apologies, something went wrong...')
        print(errorD)

# ask function to see whether user would like to repeat
def ask_weather():
    answer1 = str(input('Would you like to see the weather for another location? '
                        'Please enter Yes or No? ')).lower().strip()
    while answer1 not in ('yes', 'no'):
        answer1 = str(input('Please enter yes or no: '))
    if answer1 == "yes":
        print('')
        main()
    else:
        print("Have a great day!")

# helper function to see whether the user would like to input a state as an additional lookup
def ask_state():
    answer2 = str(input('Does the city you have in mind '
                        'have a state? Please enter yes or no: ')).lower().strip()
    while answer2 not in ('yes', 'no'):
        answer2 = str(input('Please enter yes or no: '))
    if answer2 == "yes":
        location_option = input("Please enter the Zip Code or City, State, "
                                "Country as specified in the example above: ")
    else:
        location_option = input("Please enter the Zip Code or City, "
                                "Country as specified in the example above: ")
    return location_option

# ask forecast
def ask_forecast(location, api, unit):
    answer3 = str(input('Would you like the next 5 day forecast for this location? '
                        'Please enter yes or no: ')).lower().strip()
    while answer3 not in ('yes', 'no'):
        answer3 = str(input('Please enter yes or no: '))
    if answer3 == "yes":
        get_forecast(location, api, unit)
    else:
        ask_weather()

# main function
def main():
    print("Welcome to Rajeev Weather! For a forecast, please enter the 5 digit U.S. "
          "zip code for your location\n"
          "or the city's name, comma, 2-letter state code, and 2-letter country code.\n"
          "Entering the country code is crucial as "
          "it is the difference between London, GB and London, CA!\n")
    api_url = "https://api.openweathermap.org/data/2.5/"
    loc = ask_state()
    temp_unit = input("Please input the preferred unit of temperature "
                      "C, F, or K: ").lower().strip()
    temp_unit_choice = unit_choice(temp_unit)
    try:
        get_weather(loc, api_url + 'weather', temp_unit_choice)
        print('')
        ask_forecast(loc, api_url + 'forecast', temp_unit_choice)
    except LookupError:
        print('')
        ask_weather()


if __name__ == "__main__":
    main()

# Change#: 1
# Change(s) Made: added forecast api lookup and
# option to see the forecast
# Date of Change: 11/17/2022
# Author: Rahul Rajeev
# Change Approved by: Professor Michael Eller
# Date Moved to Production: 11/17/2022
