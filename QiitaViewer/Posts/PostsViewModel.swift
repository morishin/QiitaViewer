import Foundation
import Mew
import Hydra

class PostsViewModel {
    struct Model {
        var posts: [PostEntity]
    }

    weak var view: PostsViewController?
    let environment: EnvironmentProvider
    var currentState: Model

    init(view: PostsViewController, input: PostsViewController.Input, environment: EnvironmentProvider) {
        self.view = view
        self.environment = environment
        self.currentState = Model(posts: input.posts)
    }

    func refresh() {
        environment.apply(request: GetPostsRequest()).then { [weak self] response in
            guard let strongSelf = self else { return }
            let model = Model(posts: response)
            strongSelf.currentState = model
            strongSelf.view?.input(model)
        }.catch { error in
            print(error)
        }
    }
}
