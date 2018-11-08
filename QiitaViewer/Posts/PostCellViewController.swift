import UIKit
import Mew

class PostCellViewController: UIViewController, Instantiatable, Injectable {
    typealias Environment = EnvironmentProvider
    typealias Input = Model
    struct Model {
        var title: String
        var userName: String
        var userIconImageURL: URL?
    }

    let environment: Environment
    var model: Model {
        didSet {
            update()
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userIconImageView: UserIconImageView!

    required init(with input: Input, environment: Environment) {
        self.environment = environment
        self.model = input
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }

    func input(_ input: Input) {
        model = input
    }

    private func update() {
        titleLabel.text = model.title
        userNameLabel.text = model.userName
        userIconImageView.imageURL = model.userIconImageURL
    }
}
