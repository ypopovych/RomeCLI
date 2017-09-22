import Foundation
import RomeKit

struct AssetCommand {
    
    func list() {
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Assets.all(queue: queue, completionHandler: { (assets, error) in
            
            if let assets = assets {
                for asset in assets {
                    self.printAsset(asset: asset)
                }
            }
            
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func getById(id: String) {
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Assets.getAssetById(id: id, queue: queue, completionHandler: { (asset, errors) in
            if let asset = asset {
                self.printAsset(asset: asset)
            } else {
                print("Asset not found")
            }
            
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func getLatestByRevison(name: String, revision: String) {
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Assets.getLatestAssetByRevision(name: name, revision: revision, queue: queue, completionHandler: { (asset, errors) in
            if let asset = asset {
                self.printAsset(asset: asset)
            }
            
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func addAsset(name: String, revision: String, path: String) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("File not found")
            return
        }
        
        RomeKit.Assets.create(name: name, revision: revision, data: data, queue: queue, progress: { (totalBytesWritten, totalBytesExpectedToWrite) in
            
            let currentPercent = Int(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100)
            print(currentPercent, "%")
            
            }, completionHandler: { (asset, error) in
                
                if let asset = asset {
                    self.printAsset(asset: asset)
                }
                
                dispatchGroup.leave()
                
        })
            
        dispatchGroup.wait()
    }
    
    func delete(id: String) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Assets.delete(id: id, queue: queue, completionHandler: { (deleted, errors) in
            if (deleted != nil) {
                print("Asset deleted")
            } else {
                print("Error deleting asset")
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func update(id: String, active: Bool) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "", attributes: .concurrent)
        
        dispatchGroup.enter()
        
        RomeKit.Assets.updateStatus(id: id, active: active, queue: queue, completionHandler: { (updated, errors) in
            if (updated != nil) {
                print("Asset updated")
            } else {
                print("Error updating asset")
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.wait()
    }
    
    func printAsset(asset: Asset) {
        print("Id: " + asset.id!)
        print("Name: " + asset.name!)
        print("Revision: " + asset.revision!)
        print("File Extension: " + asset.file_extension!)
        print("Active: " + asset.active!.description)
        print("Created At: " + asset.created_at!.description)
        print("Updated At: " + asset.updated_at!.description)
        print("")
    }
    
}
