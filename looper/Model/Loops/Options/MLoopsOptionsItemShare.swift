import UIKit

class MLoopsOptionsItemShare:MLoopsOptionsItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetLoopsShare")
        
        super.init(image:image)
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
    
    override func selected(controller:CLoops, model:MLoopsItem)
    {
        controller.share(model:model)
    }
}
