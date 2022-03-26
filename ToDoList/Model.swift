//
//  Model.swift
//  ToDoList
//
//  Created by Dunya on 3/16/22.
//

import Foundation
import UserNotifications
import UIKit

var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoItems")
        UserDefaults.standard.synchronize()
    }

    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoItems") as? [[String:Any]] {
            return array
        } else {
            return []
        }
    }
}

func moveItem(from: Int, to: Int){
    let item = ToDoItems[from]
    ToDoItems.remove(at: from)
    ToDoItems.insert(item, at: to)
}

func addItem(nameItem: String, isCompleted: Bool = false){
    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    setBadge()
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
    setBadge()
}

func changeState(at item: Int) -> Bool{
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return ToDoItems[item]["isCompleted"] as! Bool
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge], completionHandler: { (isEnabled, error) in
        if isEnabled {
            print("Notifications enabled")
        } else {
            print("Notifications canceled") 
        }
    })
}

func setBadge() {
    var total: Int = 0
    for item in ToDoItems{
        if (item["isCompleted"] as? Bool) == false{
            total += 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = total
}
