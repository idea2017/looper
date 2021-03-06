import UIKit

class VHomeControl:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    enum Control
    {
        case camera
        case sequences
        case blender
    }
    
    weak var viewCamera:VHomeControlCamera?
    weak var viewBlender:VHomeControlBlender?
    weak var viewSequences:VHomeControlSequences?
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    let kCollectionHeight:CGFloat = 70
    private var model:MHomeControl?
    private let kDeselectTime:TimeInterval = 0.4
    
    init(controller:CHome)
    {
        model = MHomeControl(controller:controller)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeControlCell.self,
            forCellWithReuseIdentifier:
            VHomeControlCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let layoutCollectionHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        addConstraints([
            layoutCollectionHeight,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeControlItem
    {
        let item:MHomeControlItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        model = MHomeControl(controller:controller)
        collectionView.reloadData()
    }
    
    func showControl(control:Control)
    {
        let view:UIView
        
        switch control
        {
            case Control.camera:
                
                let viewCamera:VHomeControlCamera = VHomeControlCamera(controller:controller)
                self.viewCamera = viewCamera
                view = viewCamera
                
                break
                
            case Control.sequences:
                
                let viewSequences:VHomeControlSequences = VHomeControlSequences(controller:controller)
                self.viewSequences = viewSequences
                view = viewSequences
                
                break
                
            case Control.blender:
                
                let viewBlender:VHomeControlBlender = VHomeControlBlender(controller:controller)
                self.viewBlender = viewBlender
                view = viewBlender
                
                break
        }
        
        addSubview(view)
        
        let layoutViewTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:view,
            toView:self)
        let layoutViewBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:view,
            toView:collectionView)
        let layoutViewLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:view,
            toView:self)
        let layoutViewRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:view,
            toView:self)
        
        addConstraints([
            layoutViewTop,
            layoutViewBottom,
            layoutViewLeft,
            layoutViewRight])
        
        layoutIfNeeded()
    }
    
    func showCamera()
    {
        let viewCamera:VHomeControlCamera = VHomeControlCamera(controller:controller)
        self.viewCamera = viewCamera
        addSubview(viewCamera)
        
        let layoutCameraTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewCamera,
            toView:self)
        let layoutCameraBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:viewCamera,
            toView:collectionView)
        let layoutCameraLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewCamera,
            toView:self)
        let layoutCameraRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewCamera,
            toView:self)
        
        addConstraints([
            layoutCameraTop,
            layoutCameraBottom,
            layoutCameraLeft,
            layoutCameraRight])
        
        layoutIfNeeded()
    }
    
    func showBlender()
    {
        let viewBlender:VHomeControlBlender = VHomeControlBlender(controller:controller)
        self.viewBlender = viewBlender
        addSubview(viewBlender)
        
        let layoutBlenderTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewBlender,
            toView:self)
        let layoutBlenderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:viewBlender,
            toView:collectionView)
        let layoutBlenderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBlender,
            toView:self)
        let layoutBlenderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBlender,
            toView:self)
        
        addConstraints([
            layoutBlenderTop,
            layoutBlenderBottom,
            layoutBlenderLeft,
            layoutBlenderRight])
        
        layoutIfNeeded()
    }
    
    func showSequences()
    {
        let viewSequences:VHomeControlSequences = VHomeControlSequences(controller:controller)
        self.viewSequences = viewSequences
        addSubview(viewSequences)
        
        let layoutSequencesTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewSequences,
            toView:self)
        let layoutSequencesBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:viewSequences,
            toView:collectionView)
        let layoutSequencesLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewSequences,
            toView:self)
        let layoutSequencesRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewSequences,
            toView:self)
        
        addConstraints([
            layoutSequencesTop,
            layoutSequencesBottom,
            layoutSequencesLeft,
            layoutSequencesRight])
        
        layoutIfNeeded()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let items:CGFloat = CGFloat(model!.items.count)
        let widthPerCell:CGFloat = width / items
        let size:CGSize = CGSize(width:widthPerCell, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        guard
            
            let model:MHomeControl = self.model
        
        else
        {
            return 0
        }
        
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeControlItem = modelAtIndex(index:indexPath)
        let cell:VHomeControlCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VHomeControlCell.reusableIdentifier,
            for:indexPath) as! VHomeControlCell
        cell.config(
            model:item,
            controller:controller)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeControlItem = modelAtIndex(index:indexPath)
        
        return item.active
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeControlItem = modelAtIndex(index:indexPath)
        
        return item.active
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MHomeControlItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
