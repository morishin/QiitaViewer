import UIKit
import Mew

class LoadingCellViewController: UIViewController, Instantiatable, Injectable {
    typealias Input = Void
    typealias Environment = EnvironmentProvider

    var environment: EnvironmentProvider

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    required init(with input: Void, environment: EnvironmentProvider) {
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Injectable

    func input(_ input: Void) {
        activityIndicator.startAnimating()
    }
}
