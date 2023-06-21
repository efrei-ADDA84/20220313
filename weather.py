from flask import Flask, request, jsonify

import os
import requests

app = Flask(__name__)      # creating a flask instance

def get_weather(lat, lon):
    api_key = os.environ.get('API_KEY')      # retrieving the api key from our environment variable
    url = f'https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={api_key}'  # link to the openweather api

    api = requests.get(url)     # calling the openweather api
    data = api.json()

    if api.status_code == 200:  # verifying we have access to the API
        weather = data['weather'][0]['description']     # retrieving weather data
        temperature = data['main']['temp']              # retrieving temperature data
        return f"Weather: {weather}, Temperature: {temperature} K"
    else:
        return 'Failed to retrieve data.'
    
@app.route('/', methods=['GET'])
def weather():
    lat = request.args.get('lat')
    lon = request.args.get('lon')
    data = get_weather(lat, lon)
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)


