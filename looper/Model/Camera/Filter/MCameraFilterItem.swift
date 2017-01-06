import UIKit

class MCameraFilterItem
{
    let title:String
    let image:UIImage
    
    init(title:String, image:UIImage)
    {
        self.title = title
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func processController() -> CController?
    {
        return nil
    }
    
    func waterMark(original:MCameraRecord) -> MCameraRecord
    {
        guard
        
            let noWatermark:Bool = MSession.sharedInstance.settings?.noWatermark
        
        else
        {
            return original
        }
        
        let markedRecord:MCameraRecord
        
        if noWatermark
        {
            markedRecord = original
        }
        else
        {
            markedRecord = MCameraRecord()
            
            if self.device == nil
            {
                self.device = MTLCreateSystemDefaultDevice()
            }
            
            guard
                
                let device:MTLDevice = self.device
                
            else
            {
                return markedRecord
            }
            
            renderedSequence = MHomeImageSequenceGenerated(
                device:device,
                main:mainSequence,
                sequences:blendingSequences,
                length:longestSequence)
        }
        
        return markedRecord
    }
}
