import Foundation

class DogPatchClient {
    let baseURL: URL
    let session: URLSession
    let responseQueue: DispatchQueue?
    
    init(baseURL: URL, session: URLSession, responseQueue: DispatchQueue?) {
        self.baseURL = baseURL
        self.session = session
        self.responseQueue = responseQueue
    }
    
    func getDogs(completion: @escaping ([Dog]?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: "dogs", relativeTo: baseURL)!
        let task = session.dataTask(with: url) { [weak self]
            data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  error == nil,
                  let data = data else {
                self.dispatchResult(error: error, completion: completion)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let dogs = try decoder.decode([Dog].self, from: data)
                self.dispatchResult(models: dogs, completion: completion)
            } catch {
                self.dispatchResult(error: error, completion: completion)
            }
        }
        task.resume()
        return task
    }
    
    private func dispatchResult<Type>(
        models: Type? = nil,
        error: Error? = nil,
        completion: @escaping (Type?, Error?) -> Void) {
        
        guard let responseQueue = responseQueue else {
            completion(models, error)
            return
        }
        responseQueue.async {
            completion(models, error)
        }
    }
}
