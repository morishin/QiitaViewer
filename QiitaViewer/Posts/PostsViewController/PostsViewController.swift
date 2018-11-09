import Mew
import UIKit

class PostsViewController: UIViewController, Instantiatable, Injectable, UITableViewDelegate, UITableViewDataSource {
    typealias Input = PostsViewModel.Model
    typealias Environment = EnvironmentProvider

    var environment: Environment
    private var viewModel: PostsViewModel!
    private var posts: [PostEntity] {
        didSet {
            if posts.elementsEqual(
                oldValue, by: { l, r -> Bool in
                    l.id == r.id
            }) {
                tableView.reloadData()
            }
        }
    }

    private var isLoading: Bool {
        didSet {
            if isLoading != oldValue {
                tableView.reloadData()
            }
        }
    }

    @IBOutlet var tableView: UITableView!

    required init(with input: Input, environment: Environment) {
        self.environment = environment
        posts = input.posts
        isLoading = input.isLoading
        super.init(nibName: nil, bundle: nil)
        viewModel = PostsViewModel(view: self, input: input, environment: environment)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewCell<PostCellViewController>.register(to: tableView)
        TableViewCell<LoadingCellViewController>.register(to: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refresh()
    }

    // MARK: - Injectable

    func input(_ input: Input) {
        posts = input.posts
        isLoading = input.isLoading
    }

    // MARK: - UITableViewDelegate / UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return posts.count
        } else {
            return isLoading ? 1 : 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let post = posts[indexPath.row]
            return TableViewCell<PostCellViewController>.dequeued(
                from: tableView,
                for: indexPath,
                input: PostCellViewController.Input(
                    title: post.title,
                    userName: post.user.id,
                    userIconImageURL: post.user.profileImageURL,
                    createdDateAgo: post.createdDate.timeAgoDisplay(),
                    likesCount: post.likesCount),
                parentViewController: self)
        } else {
            return TableViewCell<LoadingCellViewController>.dequeued(
                from: tableView,
                for: indexPath,
                input: (),
                parentViewController: self)
        }
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.loadMore()
        }
    }
}
