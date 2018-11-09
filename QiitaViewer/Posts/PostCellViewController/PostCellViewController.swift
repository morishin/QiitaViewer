import Mew
import UIKit

class PostCellViewController: UIViewController, Instantiatable, Injectable {
    typealias Environment = EnvironmentProvider
    typealias Input = Model
    struct Model {
        var title: String
        var userName: String
        var userIconImageURL: URL?
        var createdDateAgo: String
        var likesCount: Int
    }

    let environment: Environment
    var model: Model {
        didSet {
            update()
        }
    }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userIconImageView: UserIconImageView!
    @IBOutlet private var createdDateLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!

    required init(with input: Input, environment: Environment) {
        self.environment = environment
        model = input
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
        likesCountLabel.text = "\(model.likesCount)"
    }

    // MARK: - Injectable

    func input(_ input: Input) {
        model = input
    }
}
