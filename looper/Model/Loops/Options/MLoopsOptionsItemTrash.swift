import UIKit

class MLoopsOptionsItemTrash:MLoopsOptionsItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetLoopsTrash")
        
        super.init(image:image)
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
    
    override func selected(controller:CLoops, model:MLoopsItem)
    {
        controller.delete(model:model)
    }
}
