

import Foundation
import CoreData

class SelectedItem: NSManagedObject {
    @NSManaged var itemID: Int16
    @NSManaged var amount: Int16
}