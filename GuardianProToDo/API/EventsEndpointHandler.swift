import Foundation

class EventsEndpointHandler {
    
    public static let instance:EventsEndpointHandler = EventsEndpointHandler()

    private let eventsDbFileName = "events.db"
    
    func handleEvents(request: URLRequest) -> (data: Data?, error: Error?) {
        
        
        
      /*  let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let image = UIImage(data: data)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        */
        
        
        
        
        if let eventsDbPath = Bundle.main.path(forResource: eventsDbFileName, ofType: "json") {
            do {
                let dbData = try Data(contentsOf: URL(fileURLWithPath: eventsDbPath), options: .mappedIfSafe)
                return (dbData, nil)
            } catch {
                print(error)
                return (nil, ApiError.InternalServerError)
            }
        } else {
            print("Missing events.db.json file.")
            return (nil, ApiError.InternalServerError)
        }
    }
}
