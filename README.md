# ParseCatApiUsingDecodable
Parsing Cat API using Decodable protocol in Swift 4

1. ApiClient was created which returned the Json array
2. Created the Cat Model - the initializer takes a json dictionary to create each cat object.
3. Created data store - called ApiClient which returned an Array of dictionaries.
4. In order to create a Cat object, I enumerated through the json Array and used the initializer from the Cat model to create.
5. Created a tableview with custom tableviewcell.
6. Downloaded the catImage cell asynchonously to avoid freezing up the UI that can happen when while the images download on the main thread.

