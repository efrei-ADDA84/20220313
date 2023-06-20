import os
import requests

def get_weather(lat, long):
    api_key = os.environ.get('API_KEY')      # retrieving the api key from our environment variable
    print(api_key)
    url = f'https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={long}&appid={api_key}'  # link to the openweather api

    api = requests.get(url)     # calling the openweather api
    data = api.json()

    if api.status_code == 200:
        weather = data['weather'][0]['description']     # retrieving weather data
        temperature = data['main']['temp']              # retrieving temperature data
        return f"Weather: {weather}, Temperature: {temperature} K"
    else:
        return 'Failed to retrieve data.'

lat = float(os.environ.get('LAT'))
long = float(os.environ.get('LONG'))       # retrieving variable from environment variable
print(get_weather(lat, long))
