import Foundation

class URLSessionMock : URLSession {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    private let baseUrlString = "https://v6.exchangerate-api.com"
    private let apiEndpoint = "/v6/183032f027c6376ec447ee31/latest/"
    private var currencyEndpoint: String = ""
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
    {
        var error: Error?
        
        if url.path == apiEndpoint + currencyEndpoint {
            error = ApiError.WrongHttpMethod
        } else {
            error = ApiError.MissingAuthToken
        }
        
        return URLSessionDataTaskMock {
            completionHandler(nil, nil, error)
        }
    }
    
    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping CompletionHandler) -> URLSessionDataTask
    {
        let (data,error) = handleRequest(request: request)
        
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
    
    private func handleRequest(request: URLRequest) -> (data: Data?, error: Error?) {
        var error: Error? = nil
        
        let body = request.httpBody
        let params = try? JSONSerialization.jsonObject(with: body!, options: []) as? [String: Any]

        if let url = request.url {
            
            if let currency = params!["currency"] as? String {
                currencyEndpoint = currency
                
                if url.path !=  (apiEndpoint + currencyEndpoint) {
                    return (nil, ApiError.MissingURL)
                }
            }
         }
        
         if let url = request.url {
             switch url.path {
             case apiEndpoint + currencyEndpoint:
                 return EventsEndpointHandler().handleEvents(request: request)
             default:
                 error = ApiError.BadRequest
             }
         } else {
             error = ApiError.MissingURL
         }
         
         return (nil, error)
    }
}
