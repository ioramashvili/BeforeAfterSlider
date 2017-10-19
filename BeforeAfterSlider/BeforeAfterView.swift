import UIKit

@IBDesignable
public class BeforeAfterView: UIView {
    
    fileprivate var leading: NSLayoutConstraint!
    fileprivate var originRect: CGRect!
    
    @IBInspectable
    public var image1: UIImage = UIImage() {
        didSet {
            imageView1.image = image1
        }
    }
    
    @IBInspectable
    public var image2: UIImage = UIImage() {
        didSet {
            imageView2.image = image2
        }
    }
    
    @IBInspectable
    public var thumbColor: UIColor = UIColor.white {
        didSet {
            thumb.backgroundColor = thumbColor
        }
    }

    fileprivate lazy var imageView2: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    fileprivate lazy var imageView1: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate lazy var image1Wrapper: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    fileprivate lazy var thumbWrapper: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    fileprivate lazy var thumb: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    lazy fileprivate var setupLeadingAndOriginRect: Void = {
        self.leading.constant = frame.width / 2
        self.layoutIfNeeded()
        self.originRect = self.image1Wrapper.frame
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        _ = setupLeadingAndOriginRect
    }
}

extension BeforeAfterView {
    fileprivate func initialize() {

        image1Wrapper.addSubview(imageView1)
        addSubview(imageView2)
        addSubview(image1Wrapper)
        
        thumbWrapper.addSubview(thumb)
        addSubview(thumbWrapper)
        
        NSLayoutConstraint.activate([
            imageView2.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
        
        leading = image1Wrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            image1Wrapper.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            image1Wrapper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            image1Wrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            leading
        ])
        
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: image1Wrapper.topAnchor, constant: 0),
            imageView1.bottomAnchor.constraint(equalTo: image1Wrapper.bottomAnchor, constant: 0),
            imageView1.trailingAnchor.constraint(equalTo: image1Wrapper.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            thumbWrapper.topAnchor.constraint(equalTo: image1Wrapper.topAnchor, constant: 0),
            thumbWrapper.bottomAnchor.constraint(equalTo: image1Wrapper.bottomAnchor, constant: 0),
            thumbWrapper.leadingAnchor.constraint(equalTo: image1Wrapper.leadingAnchor, constant: -20),
            thumbWrapper.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            thumb.centerXAnchor.constraint(equalTo: thumbWrapper.centerXAnchor, constant: 0),
            thumb.centerYAnchor.constraint(equalTo: thumbWrapper.centerYAnchor, constant: 0),
            thumb.widthAnchor.constraint(equalTo: thumbWrapper.widthAnchor, multiplier: 1),
            thumb.heightAnchor.constraint(equalTo: thumbWrapper.widthAnchor, multiplier: 1)
        ])
        
        leading.constant = frame.width / 2
        
        thumb.layer.cornerRadius = 20
        imageView1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        let tap = UIPanGestureRecognizer(target: self, action: #selector(gesture(sender:)))
        thumbWrapper.isUserInteractionEnabled = true
        thumbWrapper.addGestureRecognizer(tap)
    }
    
    
    @objc func gesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        switch sender.state {
        case .began, .changed:
            var newLeading = originRect.origin.x + translation.x
            newLeading = max(newLeading, 20)
            newLeading = min(frame.width - 20, newLeading)
            leading.constant = newLeading
            layoutIfNeeded()
        case .ended, .cancelled:
            originRect = image1Wrapper.frame
        default: break
        }
    }
}





