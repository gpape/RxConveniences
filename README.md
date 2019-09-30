# RxConveniences

A collection of small conveniences for [RxSwift](https://github.com/ReactiveX/RxSwift),
intended to promote [clarity at the point of use](https://swift.org/documentation/api-design-guidelines/).

See the example project for some demos.

### Additional bindings

Adds more reactive bindings for common properties, e.g., `UIView.tintColor`.

### Collective bindings

Extends [CollectiveSwift](https://github.com/gpape/CollectiveSwift) to provide reactive
bindings for *collections* of common objects.  Paired with outlet collections from storyboards,
you can do a lot with a little code.  For example:

```swift
.bind(to: labels.all.rx.textColor, tintableViews.all.rx.tintColor, ...)
```

### Operators and utilities

I often make small observable mappings that feel like clutter.  For example:

```swift
booleanSource.map { !$0 }

Observable.combineLatest(left, right).map { $0.0 || $0.1 }

typedSource.map { _ in () }.bind(to: voidObserver)
```

But we can make these clearer:

```swift
(!booleanSource)

(left || right)

typedSource.trigger(voidObserver)
```

In the case of controls that have unambiguously typed outputs, like buttons (`Void`),
switches (`Bool`), and sliders (`Float`), we can bind and map them directly.  For example,
`slider.bind(to:)` is arguably just as clear as `slider.rx.value.bind(to:)`.

You may prefer, for example, `slider.rx.bind(to:)`, and this is also available.
If you have a strong preference for one over the other, tell me about it!

### One-liner button press effect

A nice thing to add to buttons:

```swift
button.addPressEffect().disposed(by: ...)
```

...and more!

## License

MIT
