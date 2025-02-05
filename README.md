# BitTrend
iOS app to stay aligned with possible bear/bull market and have infos about the different cryptos

## HOW TO BUILD
The app makes use of ```Config.xcconfig``` configuration file with a demo Api Key for the CoinGecko development API.
Edit the **COIN_GECKO_API_KEY** configuration key value to use a different Api Key. 
The app supports either real and mocked network requests:  
• to use real network requests choose the ```BitTrend``` Xcode schema
• to use mocked network requests choose the ```BitTrend MOCK``` Xcode schema
**Note**: iOS 18 required  

## ARCHITECTURE
SwiftUI application with Model-View architecture (cfr. https://medium.com/better-programming/swiftui-architecture-a-complete-guide-to-mv-pattern-approach-5f411eaaaf9e) 

### View
```BitTrendApp```: is the @main data type to start the app. It creates the observable aggregated object used by other views and store it into the Environment
```CoinListView```: is the main view of the app, presenting the list of the top 10 crypto coins loaded from CoinGecko
```CoinDetailView```: is the detail view presented by tapping on a list element  
The ```Components``` subfolder contains reausable views 

### Model
```CoinStore```: aggregate object used by the two SwiftUI views. It's created in the @main App file and kept in the system Environment.
```Coin```: data structure to mimic coins
```CoinDetail```: data structure to mimic coin details
```ChartEntry```: data structure to mimic chart entry

#### Network
This folder contains a micro-framework for executing network requests. ```NetworkRequest``` define a protocol for a request and ```JSONNetworkRequest``` is its JSON protocol extension.  
Each request is a struct which conforms to ```JSONNetworkRequest```.  
To execute a request you need to create a ```NetworkRequestLoader``` with a ```URLSession``` instance (```NetworkSessionFactory``` provides factory methods to create it) and call its ```loadResponse()``` async method.  
To support mocked requests you need to create a ```MockURLProtocol``` subclass and specify intended outcomes (i.e. success, failure...), then you have to call ```NetworkSessionFactory``` proper method with that type in order to create the correct session.
Each mocked outcome needs a separate JSON file, whose name must conform to the following template: ```#RequestTypeName#_#outcome#.json```.  
DTO data type to match requests responses are located in the ```DTO``` folder

#### Repository
```CoinRepository```: protocol to query CoinGecko for data
```NetworkCoinRepository```: real implementation of ```CoinRepository```
```MockCoinRepository```: mock implementation of ```CoinRepository```
```CoinRepositoryFactory```: factory to create proper ```CoinRepository```

#### Service
```ReachabilityService```: protocol to query for internet connection availability
```NetworkReachabilityService```: real implementation of ```ReachabilityService```
```MockReachabilityService```: mock implementation of ```ReachabilityService```
```ReachabilityServiceFactory```: factory to create proper ```ReachabilityService``` 

#### Utility
```AppData```: data type to query for application configuration and mock enableness
```Localization```: utility enum for the different localized strings used in the app

## TESTS
The app contains the ```BitTrend``` test plan for executing both Unit and UI tests
