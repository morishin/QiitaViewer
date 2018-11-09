import UIKit
import Mew

class MainViewController: UIViewController, Instantiatable {
    typealias Input = Void
    typealias Environment = EnvironmentProvider

    var environment: Environment

    @IBOutlet private weak var containerView: ContainerView!

    private var postsViewContainer: ContainerView.Container<PostsViewController, MainViewController>?

    required init(with input: Input, environment: Environment) {
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        postsViewContainer = self.containerView.makeContainer(for: PostsViewController.self, parentViewController: self, with: PostsViewController.Input(posts: []))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
