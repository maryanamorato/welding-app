//
//  TableViewCell.swift
//  welding-app
//
//  Created by COTEMIG on 23/09/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let rouseidentifier = String(describing: TableViewCell.self)
    
    @IBOutlet weak var equipmentimage: UIImageView!
    @IBOutlet weak var equipmentname: UILabel!
    @IBOutlet weak var equipmentinfo: UILabel!
}



