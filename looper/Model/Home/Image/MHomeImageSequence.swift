import UIKit

class MHomeImageSequence
{
    var items:[MHomeImageSequenceItem]
    
    init(items:[MHomeImageSequenceItem])
    {
        self.items = items
    }
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func add(image:UIImage)
    {
        let item:MHomeImageSequenceItem = MHomeImageSequenceItem(
            image:image)
        items.append(item)
    }
}
