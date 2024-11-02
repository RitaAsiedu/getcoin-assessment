from flask import Flask, jsonify
import requests
import logging

app = Flask(__name__)

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# CoinGecko API URL
API_URL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum"
params = {
    "vs_currency": "usd",
    "ids": "bitcoin,ethereum"
}


def fetch_crypto_data(crypto_name):
    try:
        # Fetching data from the CoinGecko API
        response = requests.get(API_URL, params=params)
        response.raise_for_status()
        data = response.json()
        # Retrieve the requested cryptocurrency data
        crypto_data = next((item for item in data if item['id'] == crypto_name), None)
        if not crypto_data:
            raise ValueError(f"Data for {crypto_name} not available")
        logging.info(f"Fetched {crypto_name} data: {crypto_data}")
        return crypto_data
    except requests.RequestException as e:
        logging.error(f"Error fetching data: {e}")
        return None
    except ValueError as e:
        logging.error(f"Error processing data: {e}")
        return None
    # for coin in data:
    #     print(f"{coin['name']} (USD): {coin['current_price']}")
    # else:
    #     print("Error:", response.status_code)

@app.route('/bitcoin', methods=['GET'])
def bitcoin():
    data = fetch_crypto_data("bitcoin")
    if data:
        return jsonify(data), 200
    return jsonify({"error": "Could not retrieve Bitcoin data"}), 500

@app.route('/ethereum', methods=['GET'])
def ethereum():
    data = fetch_crypto_data("ethereum")
    if data:
        return jsonify(data), 200
    return jsonify({"error": "Could not retrieve Ethereum data"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
