import UIKit
import Nuke

@IBDesignable class UserIconImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    var imageURL: URL? {
        didSet {
            if let imageURL = imageURL {
                Nuke.loadImage(with: imageURL, into: self)
            }
        }
    }
}
