import UIKit

class VLoopsFooter:UICollectionReusableView
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
