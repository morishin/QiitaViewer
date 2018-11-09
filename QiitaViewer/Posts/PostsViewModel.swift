import Foundation
import Mew
import Hydra

class PostsViewModel {
    struct Model {
        let posts: [PostEntity]
        let nextPage: Int
        let isLoading: Bool
    }

    private weak var view: PostsViewController?
    private let environment: EnvironmentProvider
    private var currentState: Model {
        didSet {
            view?.input(currentState)
        }
    }

    init(view: PostsViewController, input: PostsViewController.Input, environment: EnvironmentProvider) {
        self.view = view
        self.environment = environment
        self.currentState = input
    }

    func refresh() {
        if currentState.isLoading { return }
        currentState = Model(posts: currentState.posts, nextPage: 1, isLoading: true)
        environment.apply(request: GetPostsRequest(page: 1)).then { [weak self] response in
            self?.currentState = Model(posts: response, nextPage: 2, isLoading: false)
        }.catch { [weak self] error in
            print(error)
            guard let strongSelf = self else { return }
            strongSelf.currentState = Model(posts: strongSelf.currentState.posts, nextPage: 1, isLoading: false)
        }
    }

    func loadMore() {
        if currentState.isLoading { return }
        currentState = Model(posts: currentState.posts, nextPage: currentState.nextPage, isLoading: true)
        environment.apply(request: GetPostsRequest(page: currentState.nextPage)).then { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.currentState = Model(posts: strongSelf.currentState.posts + response, nextPage: strongSelf.currentState.nextPage + 1, isLoading: false)
        }.catch { [weak self] error in
            print(error)
            guard let strongSelf = self else { return }
            strongSelf.currentState = Model(posts: strongSelf.currentState.posts, nextPage: strongSelf.currentState.nextPage, isLoading: false)
        }
    }
}
