# MVVM "View Injection" Template

When it comes to implementing the architecture of a mobile iOS application there are many patterns one could follow. There is MVC, MVVM, VIPER, Clean Swift and countless more patterns to help keep your applications data layer robust and testable. But what about your apps view layer architecture?

This was a question that I never thought much of in my earlier days of developing apps. Like most, I used some base UI classes to help reduce duplicate code when it came to theming a views colours, font, etc. While something like this and MVC are good enough solution to small apps, as it grows they quicly become a pain point in your apps architecture. It's commonly understood that you should never write duplicate code; however, when it comes to the UI I often see exactly that.

I begin trying to come up with a way to abstract views so they could be used with any component. Define layout view classes with generics to reduce boiler plate layout code and ensure consistency. And lastly a definition class where the components to be used in the previously mentioned layout view are "injected".

> TLDR result; View "Injection" with Generics

[Read the full Medium article](https://medium.com/p/22f82c073165)

## Installation

Clone this repo and to your XCodes project template directory. You can then create a new XCode project using this as a template.

## Modifications

1. Run `pod install` to fetch dependencies
2. Make your modifications by opening the TemplateProject.xcworkspace, keeping any new files in the `MVVM Project Template.xctemplate` folder
3. Run `swift XCodeTemplateGenerator.swift MVVM\ Project\ Template.xctemplate` to update the `TemplateInfo.plist`

## Why use this architecture? 

I have written a complete article on Medium that discusses the problems this view layer architecture is trying to solve. You can read it [here](https://medium.com/p/22f82c073165).

### Brief Overview

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
