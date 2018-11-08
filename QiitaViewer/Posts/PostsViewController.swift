import UIKit
import Mew

class PostsViewController: UIViewController, Instantiatable, Injectable, UITableViewDelegate, UITableViewDataSource {
    typealias Input = PostsViewModel.Model
    typealias Environment = EnvironmentProvider

    var environment: Environment
    private var viewModel: PostsViewModel!
    private var posts: [PostEntity] {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!

    required init(with input: Input, environment: Environment) {
        self.environment = environment
        self.posts = input.posts
        super.init(nibName: nil, bundle: nil)
        self.viewModel = PostsViewModel(view: self, input: input, environment: environment)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCell<PostCellViewController>.register(to: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refresh()
    }

    func input(_ input: Input) {
        posts = input.posts
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        return TableViewCell<PostCellViewController>.dequeued(
            from: tableView,
            for: indexPath,
            input: PostCellViewController.Input(
                title: post.title,
                userName: post.user.name,
                userIconImageURL: post.user.profileImageURL
            ),
            parentViewController: self)
    }
}
