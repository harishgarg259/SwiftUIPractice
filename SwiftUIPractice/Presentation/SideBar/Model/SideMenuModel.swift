import SwiftUI

struct Animal: Identifiable {
    var id = UUID()
    var name : String
    var isSelected : Bool = false
}

struct AnimalGroup: Identifiable {
    var id = UUID()
    var groupName : String
    var animals : [Animal]
    var expandMe : Bool
}


