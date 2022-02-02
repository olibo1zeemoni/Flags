//
//  Country.swift
//  Flags
//
//  Created by Olibo moni on 01/02/2022.
//

import Foundation
import UIKit

struct Country: Equatable{
    var name: String
    var flag: UIImage{
        return UIImage(named: name)!
    }
    
    static func ==(lhs: Country, rhs: Country)-> Bool{
        return lhs.name == rhs.name
    }
    
    
}
