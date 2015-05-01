//
//  ToDoItem.swift
//  Hedef.im
//
//  Created by Emre YILMAZ on 1.05.2015.
//  Copyright (c) 2015 AybarsCengaver. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var text: String
    var completed: Bool
    init(text: String) {
        self.text = text
        self.completed = false
    }
}
