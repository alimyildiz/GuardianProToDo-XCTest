//
//  ContentManager.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

class ContentManager: NSObject {
    
    public static let instance: ContentManager = ContentManager()

    let userDefaults = UserDefaults.standard

    func setObjectInUserDefaults(object:Any?,forKey:String) {

        do{
            UserDefaults.standard.set(object, forKey: forKey)
            UserDefaults.standard.synchronize()
        }catch let error {
            print("Failed to convert UIColor to Data : \(error.localizedDescription)")
        }
    }
    
    func getObjectFromUserDefaults(key: String) -> Any {
        do{
            if let data = UserDefaults.standard.object(forKey: key) as? Any {
              return data
            }
        }catch (let error){
            print("Failed to convert UIColor to Data : \(error.localizedDescription)")
        }
        
        return (Any).self
    }
}
