# installing dependencies
import quandl
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.svm import SVR
from sklearn.model_selection import train_test_split
from flask import Flask, jsonify, request
import json
import matplotlib.pyplot as plt
from flask_ngrok import run_with_ngrok
import sys
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import storage

app = Flask(__name__)


@app.route('/')
def HOME():
    return "<h1>Welcome to the server!</h1>"

@app.route('/PREDICT', methods = ['GET', 'POST'])
def PREDICTION():
    global companyName, forecast_out
    
    if request.method == 'POST':
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        companyName = request_data['name']
        forecast_out = request_data['days']

        
        return ""
    
    elif request.method == 'GET':
        quandl.ApiConfig.api_key = 'TgfxMrbFxzN-fodbu6ub'
        # ATTOCK = ACPL
        # BESWAY = BWCL
        # CHERAT = CHCC 
        # DEWAN = DCL
        # DADABHOY = DBCI
        # D.G KHAN = DGKC
        # FAUJI = FCCL
        # FECTO = FECTC
        # DANDOT = DNCC
        # FLYING = FLYNG
        # GHARIBWAL = GWLC
        # JAVEDAN CORPORATION = JVDC
        # KOHAT = KOHC
        # LUCKY = LUCK
        # MAPLE LEAF = MLCF
        # PIONEER CEMENT = PIOC
        # POWER CEMENT = POWER
        # SAFE MIX CONCRETE = SMCPL
        # THATTA CEMENT = THCCL
        
        df = quandl.get(companyName)
        df = df[['Last Day Close']]
        
          # CLOSING PRICE PLOTTING
        
       # df['Last Day Close'].plot()
        plt.figure(figsize=(10,10))
        plt.plot(df.index, df['Last Day Close'], color='green')
        plt.xlabel("Date")
        plt.ylabel("Stock Price")
        plt.title("STOCK PRICES OF " + companyName)
        plt.savefig('graph1.png')
        plt.show()
        
        # RESET DATAFRAME
        df = df[['Last Day Close']]
        
        # MOVING AVERAGES
        # SMA = SIMPLE MOVING AVERAGE
        # A simple moving average is the arithmetic mean over a number of specific time periods (the window)


        df["SMA1"] = df['Last Day Close'].rolling(window=50).mean()
        df["SMA2"] = df['Last Day Close'].rolling(window=200).mean()

        plt.figure(figsize=(10,10))
        plt.plot(df['SMA1'], 'g--', label="Simple Moving Average 1")
        plt.plot(df['SMA2'], 'r--', label="Simple Moving Average 2")
        plt.plot(df['Last Day Close'], label="Closing Price")
        plt.legend()
        plt.savefig('graph2.png')
        plt.show()
        
        # RESET DATAFRAME
        df = df[['Last Day Close']]

        # BOLLINGER BANDS REPRESENTATION

        df['middle_band'] = df['Last Day Close'].rolling(window=20).mean()
        df['upper_band'] = df['Last Day Close'].rolling(window=20).mean() + df['Last Day Close'].rolling(window=20).std()*2
        df['lower_band'] = df['Last Day Close'].rolling(window=20).mean() - df['Last Day Close'].rolling(window=20).std()*2

        plt.figure(figsize=(10,10))
        plt.plot(df['upper_band'], 'g--', label="Upper")
        plt.plot(df['middle_band'], 'r--', label="Middle")
        plt.plot(df['lower_band'], 'y--', label="Lower")
        plt.plot(df['Last Day Close'], label="Closing Price")
        plt.legend()
        plt.savefig('graph3.png')
        plt.show()

        # RESET DATA FRAME TO CLOSING PRICE COLUMN
        df = df[['Last Day Close']]
        
        # PREDICTION SECTION
        currStockPrice = df['Last Day Close'].iloc[-1]
        # forecast_out = 30
        df['Prediction'] = df[['Last Day Close']].shift(-forecast_out)
        X = np.array(df.drop(['Prediction'], 1))
        X = X[:-forecast_out]
        y = np.array(df['Prediction'])
        y = y[:-forecast_out]
        x_train, x_test, y_train, y_test = train_test_split(X, y, test_size = 0.2)
        svr_rbf = SVR(kernel = 'rbf', C = 1e3, gamma = 0.1)
        svr_rbf.fit(x_train, y_train)
        svm_confidence = svr_rbf.score(x_test, y_test)
        #print('SVR CONFIDENCE: ', svm_confidence)
        lr = LinearRegression()
        lr.fit(x_train, y_train)
        lr_confidence = lr.score(x_test, y_test)
        #print('LR CONFIDENCE: ', lr_confidence)
        x_forecast = np.array(df.drop(['Prediction'], 1))[-forecast_out:]
        lr_prediction = lr.predict(x_forecast)
        lr_prediction = np.round(lr_prediction, 2)
        #print(lr_prediction)
        svm_prediction = svr_rbf.predict(x_forecast)
        #print(svm_prediction)
        listText = lr_prediction.tolist()
        listText = listText[::-1]
        json_str = json.dumps(listText) # stock price list
        
        #currPriceText = currStockPrice.tolist()
        json_str2 = json.dumps(currStockPrice) # current stock price
        
        
      
        return jsonify({'predict' : json_str, 'currPrice' : json_str2})

if __name__ == "__main__":
   app.run(port='5000')