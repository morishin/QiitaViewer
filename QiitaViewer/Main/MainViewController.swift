import Mew
import UIKit

class MainViewController: UIViewController, Instantiatable {
    typealias Input = Void
    typealias Environment = EnvironmentProvider

    var environment: Environment

    @IBOutlet private var containerView: ContainerView!

    private var postsViewContainer: ContainerView.Container<PostsViewController, MainViewController>?

    required init(with input: Input, environment: Environment) {
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Qiita"
        navigationController?.navigationBar.barTintColor = UIColor(named: "QiitaGreen")
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .title1) ]
        navigationController?.navigationBar.largeTitleTextAttributes = [ .foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .largeTitle) ]
        postsViewContainer = containerView.makeContainer(for: PostsViewController.self, parentViewController: self, with: PostsViewController.Input(posts: [], nextPage: 1, isLoading: false))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
