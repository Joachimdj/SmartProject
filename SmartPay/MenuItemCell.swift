 


import UIKit

 class MenuItemCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var amount: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
 
    
 }
