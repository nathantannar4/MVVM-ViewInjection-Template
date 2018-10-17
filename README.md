# Nathan's MVVM Project Template

MVVM Template that utilizes RxSwift, Generics and more

## Installation

Clone this repo and to your XCodes project template directory. You can then create a new XCode project using this as a template.

## Modifications

1. Run `pod install` to fetch dependencies
2. Make your modifications by opening the TemplateProject.xcworkspace, keeping any new files in the `MVVM Project Template.xctemplate` folder
3. Run `swift XCodeTemplateGenerator.swift MVVM\ Project\ Template.xctemplate` to update the `TemplateInfo.plist`

## Why use this architecture? 

Through the use of generics and view models, your controllers can be kept very clean and minimal while also leaving your app highly testable. I create all my views via code, so a `UIViewController` can tend to become massive! By keeping all the subview and layout in a separate file/class, we can abstract all of it away from the controller. It can then also make your views highly reusable!

Let's take a look at a more basic controller for an End-User-License Agreement. We specify the `EULAView` as the generic for `IView` and it becomes the view that the controller manages. All that's left is to bind with RxSwift to the various elements. This abstracts the view and leaves the controller to do its job as just being the glue between the view model and the view.

```
final class EULAController: ViewModelController<EULAViewModel, EULAView> {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.appViewModel.appDisplayName
        subtitle = .localize(.eula)
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        rootView.rx.selector.subscribe { [weak self] event in
            switch event {
                case .next(let selector):
            switch selector {
            case .didTapDone:
                self?.dismiss(animated: true, completion: nil)
            }
            case .error, .completed:
                break
            }
        }.disposed(by: disposeBag)

        viewModel.eula.bind(to: rootView.rx.eula).disposed(by: disposeBag)
    }
}
```

So whats `IView` you might ask? It's simply a protocol that can give you access to all the regular view lifecycle methods a `UIViewController` would have.

```
protocol IView: Interface, Class where Self: UIView {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}
```
You can find the full list of interfaces in the `Interfaces.swift` file.

There are plenty of other methods I use in this template to keep the code reusable and simple. I will leave the rest for you to discover if you wish. I have included some files that follow this architecture such as `LoginController`. 
