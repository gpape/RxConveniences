# RxConveniences

A collection of small conveniences for [RxSwift](https://github.com/ReactiveX/RxSwift),
intended to promote [clarity at the point of use](https://swift.org/documentation/api-design-guidelines/).

See the example project for some demos.

### Additional bindings

Adds more reactive bindings for common properties, like `UIView.tintColor`.

### Collective bindings

Adds, by extending [CollectiveSwift](https://github.com/gpape/CollectiveSwift), simple reactive
bindings for *collections* of common objects.  Paired with outlet collections from storyboards,
you can do a lot with a little code.  For example:

```swift
.bind(to: labels.all.rx.textColor, tintableViews.all.rx.tintColor, ...)
```

### Operators and utilities

I often find myself making small observable mappings that feel like clutter.  For example:

```swift
booleanSource.map { !$0 }

typedSource.map { _ in () }.bind(to: voidObserver)
```

But I think we can make these both simpler and clearer:

```swift
(!booleanSource)

typedSource.trigger(voidObserver)
```

In the case of controls that have obviously typed outputs, like switches and sliders,
we can bind them directly.  For example, `slider.bind(to:)` is arguably just as
clear as `slider.rx.value.bind(to:)`.

### One-liner button press effect

A nice thing to add to buttons:

```swift
button.rx.addPressEffect().disposed(by: ...)
```

...and more!

## License

MIT
