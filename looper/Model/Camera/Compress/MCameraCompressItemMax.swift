import UIKit

class MCameraCompressItemMax:MCameraCompressItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraCompressItemMax_title", comment:"")
        super.init(title:title)
    }
    
    override init(title:String)
    {
        fatalError()
    }
}
