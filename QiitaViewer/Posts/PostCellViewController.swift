import UIKit
import Mew

class PostCellViewController: UIViewController, Instantiatable, Injectable {
    typealias Environment = EnvironmentProvider
    typealias Input = Model
    struct Model {
        var title: String
        var userName: String
        var userIconImageURL: URL?
        var createdDateAgo: String
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
    @IBOutlet private weak var createdDateLabel: UILabel!

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

    private func update() {
        titleLabel.text = model.title
        userNameLabel.text = "by @\(model.userName)"
        userIconImageView.imageURL = model.userIconImageURL
        createdDateLabel.text = model.createdDateAgo
    }

    // MARK: - Injectable

    func input(_ input: Input) {
        model = input
    }
}
