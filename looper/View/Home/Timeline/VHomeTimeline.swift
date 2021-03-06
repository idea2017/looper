import UIKit

class VHomeTimeline:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private weak var model:MHomeImageSequenceGenerated?
    private let kInterline:CGFloat = 2
    private let kBorderAlpha:CGFloat = 0.3
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.5
    
    init(controller:CHome)
    {
        super.init(frame:CGRect.zero)
        isHidden = true
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        alpha = kAlphaNotActive
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterline
        flow.minimumInteritemSpacing = kInterline
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.sectionInset = UIEdgeInsets(
            top:0,
            left:kInterline,
            bottom:0,
            right:kInterline)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeTimelineCell.self,
            forCellWithReuseIdentifier:
            VHomeTimelineCell.reusableIdentifier)
        self.collectionView = collectionView
        
        let borderColor:UIColor = UIColor(
            white:1,
            alpha:kBorderAlpha)
        
        let borderTop:UIView = UIView()
        borderTop.isUserInteractionEnabled = false
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.backgroundColor = borderColor
        borderTop.clipsToBounds = true
        
        let borderBottom:UIView = UIView()
        borderBottom.isUserInteractionEnabled = false
        borderBottom.translatesAutoresizingMaskIntoConstraints = false
        borderBottom.backgroundColor = borderColor
        borderBottom.clipsToBounds = true
        
        addSubview(collectionView)
        addSubview(borderTop)
        addSubview(borderBottom)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        let layoutBorderTopTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:borderTop,
            toView:self)
        let layoutBorderTopHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:borderTop,
            constant:1)
        let layoutBorderTopLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:borderTop,
            toView:self)
        let layoutBorderTopRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:borderTop,
            toView:self)
        
        let layoutBorderBottomBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:borderBottom,
            toView:self)
        let layoutBorderBottomHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:borderBottom,
            constant:1)
        let layoutBorderBottomLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:borderBottom,
            toView:self)
        let layoutBorderBottomRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:borderBottom,
            toView:self)
        
        addConstraints([
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight,
            layoutBorderTopTop,
            layoutBorderTopHeight,
            layoutBorderTopLeft,
            layoutBorderTopRight,
            layoutBorderBottomHeight,
            layoutBorderBottomBottom,
            layoutBorderBottomLeft,
            layoutBorderBottomRight])
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedImagesUpdated(sender:)),
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notifications
    
    func notifiedImagesUpdated(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            if let rendered:MHomeImageSequenceGenerated = self?.controller.modelImage.renderedSequence
            {
                if !rendered.items.isEmpty
                {
                    let index:IndexPath = IndexPath(item:0, section:0)
                    self?.activate()
                    self?.synthSelect(index:index)
                }
            }
        }
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeImageSequenceItem
    {
        let item:MHomeImageSequenceItem = model!.items[index.item]
        
        return item
    }
    
    private func synthSelect(index:IndexPath)
    {
        let item:MHomeImageSequenceItem = modelAtIndex(index:index)
        controller.viewHome.viewDisplay.displayFrame(image:item.image)
        
        collectionView.selectItem(
            at:index,
            animated:false,
            scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
    }
    
    private func activate()
    {
        alpha = kAlphaActive
        model = controller.modelImage.renderedSequence
        collectionView.reloadData()
    }
    
    //MARK: public
    
    func refresh()
    {
        alpha = kAlphaNotActive
        model = nil
        collectionView.reloadData()
    }
    
    func clearSelection()
    {
        collectionView.selectItem(
            at:nil,
            animated:false,
            scrollPosition:UICollectionViewScrollPosition())
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(
            width:height,
            height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int
        
        if model == nil
        {
            count = 0
        }
        else
        {
            count = 1
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model!.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeImageSequenceItem = modelAtIndex(index:indexPath)
        let cell:VHomeTimelineCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeTimelineCell.reusableIdentifier,
            for:indexPath) as! VHomeTimelineCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        controller.viewHome.viewPlayer.viewBoard.buttonMain.forceStop()
        let item:MHomeImageSequenceItem = modelAtIndex(index:indexPath)
        controller.viewHome.viewDisplay.displayFrame(image:item.image)
        
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
}
