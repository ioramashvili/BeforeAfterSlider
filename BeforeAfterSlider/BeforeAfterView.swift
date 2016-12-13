import UIKit

@IBDesignable
class BeforeAfterView: UIView {
    
    var leading: NSLayoutConstraint!
    var originRect: CGRect!
    
    @IBInspectable
    var image1: UIImage = UIImage() {
        didSet {
            imageView1.image = image1
        }
    }
    
    @IBInspectable
    var image2: UIImage = UIImage() {
        didSet {
            imageView2.image = image2
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
    
    fileprivate lazy var navigationView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    fileprivate lazy var navigationButtonView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitialization()
    }
    
    var isOriginRectInitialized = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isOriginRectInitialized {
            isOriginRectInitialized = true
            layoutSubviews()
            leading.constant = frame.width / 2
            layoutIfNeeded()
            originRect = image1Wrapper.frame
        }
    }
}

extension BeforeAfterView {
    fileprivate func sharedInitialization() {

        image1Wrapper.addSubview(imageView1)
        addSubview(imageView2)
        addSubview(image1Wrapper)
        
        navigationView.addSubview(navigationButtonView)
        addSubview(navigationView)
        
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
            navigationView.topAnchor.constraint(equalTo: image1Wrapper.topAnchor, constant: 0),
            navigationView.bottomAnchor.constraint(equalTo: image1Wrapper.bottomAnchor, constant: 0),
            navigationView.leadingAnchor.constraint(equalTo: image1Wrapper.leadingAnchor, constant: -20),
            navigationView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            navigationButtonView.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor, constant: 0),
            navigationButtonView.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 0),
            navigationButtonView.widthAnchor.constraint(equalTo: navigationView.widthAnchor, multiplier: 1),
            navigationButtonView.heightAnchor.constraint(equalTo: navigationView.widthAnchor, multiplier: 1)
        ])
        
        navigationButtonView.layer.cornerRadius = 20
        imageView1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        let tap = UIPanGestureRecognizer(target: self, action: #selector(gesture(sender:)))
        navigationView.isUserInteractionEnabled = true
        navigationView.addGestureRecognizer(tap)
    }
    
    
    func gesture(sender: UIPanGestureRecognizer) {
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
        default:
            print("default")
        }
    }
}





