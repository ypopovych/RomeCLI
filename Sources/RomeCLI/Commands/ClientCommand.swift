import Foundation
import RomeKit

struct ClientCommand {
    
    func list() {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Clients.all(queue: queue, completionHandler: { (clients, error) in
            
            if let clients = clients {
                for client in clients {
                    print("Id: " + client.id!)
                    print("Name: " + client.name!)
                    print("Key: " + client.api_key!)
                    print("")
                }
            }
            
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func add(name: String) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Clients.create(name: name, queue: queue, completionHandler: { (client, error) in
            if let client = client {
                print("Created client with API Key:", client.api_key!)
            } else {
                print("Error creating client:", error.debugDescription)
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func delete(id: String) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Clients.delete(id: id, queue: queue) { (deleted, error) in
            if (deleted != nil) {
                print("Client deleted")
            } else {
                print("Error deleting client")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.wait()
    }
    
}
