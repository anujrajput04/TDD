# RESTful Networking 

## TDDing the networking call
Make a `GET` request to fetch a list of objects from the server. We will have to break it down in to several smaller tasks:
1. Calling the right URL
2. Handling error responses
3. Deserializing models on success
4. Handling invalid responses

## Key points
- Avoid making real networking calls in unit tests by mocking `URLSession` and `URLSessionDataTask`
- Do TDD for GET requests easily by breaking them into several smaller tasks:
    - calling the right URL
    - handling HTTP status errors
    - handling valid and invalid responses
- Be careful about mocking `URLSessionDataTask`'s dispatch behaviour to an internal queue. Work around it by creating your own dispatch queue on mocks.
- Dispatch to a response queue to make it easier for consumers to use the networking client.
