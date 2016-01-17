# LazyKit

LazyKit is a framework that allow you to write fast and easy views.
Constructing a view can be long, boring and repetitive, especialy after the n view built.

## Features

- Maps UIView / UILabel / UIButton / UIImageView / UITextField / UITextView / UITableView
- Base classes for UIViewController / UIView / UITableViewCell / UICollectionViewCell

## Features coming up
- Map for UICollectionView
- CSS parser / mapper (You'll be even more lazy after that)

## Requirements

- iOS 8.0+
- Xcode 7.2+

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8.**

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build LazyKit 1.0.0+.

To integrate LazyKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

> **COMING UP (Not working yet!)**

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'LazyKit', '~> 1.0'
```

Then, run the following command:

```bash
$ pod install
```

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add LazyKit as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/kmalkic/LazyKit.git
```

- Open the new `LazyKit` folder, and drag the `LazyKit.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `LazyKit.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `LazyKit.xcodeproj` folders each with two different versions of the `LazyKit.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `LazyKit.framework`. 
    
- And that's it!

> The `LazyKit.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

---

## Usage

### Create a simple view configurations

Can be a struct or a class.
Let just add a label.
```swift
import LazyKit

struct MyConfigurations: LazyViewConfigurations {
    
    static func elementsOptions() -> [ElementOptions]? {
        return [
            LabelOptions(identifier: "title",
                classType: CustomLabel.self,
                viewBaseOptions: ViewBaseOptions(backgroundColor: .blueColor()),
                textOptions: TextBaseOptions(text: "hello", font: .systemFontOfSize(20), textAlignment: .Center)),
        ]
    }
    //Will need some knowledges in visual format constraints
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        return [
            VisualFormatConstraintOptions(string: "H:|-[title]-|"),
            VisualFormatConstraintOptions(string: "V:|-top-[title(==titleHeight)]")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["top" : 30, "titleHeight" : 44]
    }
     //Can use this function to return the conventional way of using constraints
    static func layoutConstraints() -> [ConstraintOptions]? {
        return nil
    }
}
```

### Using UIViewControllers
That is all you need.
```swift
import LazyKit

class MyViewController: LazyBaseViewController <MyConfigurations> {
    
}
```

### Using UIView
That is all you need.
Don't mix LazyBaseViewController and having a view of type LazyBaseView in same time. First make no sense and second you'll end up with duplicate views.
```swift
import LazyKit

class MyViewController: UIViewController {
    
    override func loadView() {
        
        view = MyView()
    }
}

class MyView: LazyBaseView <MyConfigurations> {
    
}
```

### Create a advanced view configurations

```swift
import LazyKit

struct MyConfigurations: LazyViewConfigurations {
    
    static func elementsOptions() -> [ElementOptions]? {
        
        return [
            LabelOptions(identifier: "title",
                classType: CustomLabel.self,
                viewBaseOptions: ViewBaseOptions(backgroundColor: .blueColor()),
                textOptions: TextBaseOptions(text: "hello", font: .systemFontOfSize(20), textAlignment: .Center)
            ),
            
            LabelOptions(identifier: "subtitle",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .greenColor()),
                textOptions: TextBaseOptions(text: "hey", textAlignment: .Center)
            ),
            
            ButtonOptions(identifier: "button",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .redColor()),
                textOptionsForType: [.Normal: TextBaseOptions(text: "button"), .Highlighted: TextBaseOptions(text: "highlighted")]
            ),
            
            ViewOptions(identifier: "line",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor())
            ),
            
            ImageOptions(identifier: "photo",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor()),
                imageBaseOptions: ImageBaseOptions(imageNamed: "image", contentMode: .ScaleAspectFill)
            ),
            
            TextFieldOptions(identifier: "textfield",
                viewBaseOptions: ViewBaseOptions(backgroundColor: UIColor.orangeColor()),
                textOptions: TextBaseOptions(font: .systemFontOfSize(16), textAlignment: .Center),
                placeholderOptions: TextBaseOptions(text: "placeholder", font: .systemFontOfSize(16), textColor: .redColor(), textAlignment: .Center),
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .NumbersAndPunctuation, keyboardAppearance: .Dark, returnKeyType: .Done, enablesReturnKeyAutomatically: true, secureTextEntry: false)
            ),
            
            TextViewOptions(identifier: "textview",
                viewBaseOptions: ViewBaseOptions(backgroundColor: UIColor.cyanColor()),
                textOptions: TextBaseOptions(text: "TextView", font: .systemFontOfSize(14), textAlignment: .Left),
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .EmailAddress, keyboardAppearance: .Dark, returnKeyType: .Done, enablesReturnKeyAutomatically: true, secureTextEntry: false)
            )
        ]
    }
    
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        
        return [
            VisualFormatConstraintOptions(string: "H:|-[photo(==photoW)]-[title]-|"),
            VisualFormatConstraintOptions(string: "H:[subtitle(==title)]"),
            VisualFormatConstraintOptions(string: "H:[textfield(==title)]"),
            VisualFormatConstraintOptions(string: "H:|-40-[line]-40-|"),
            VisualFormatConstraintOptions(string: "H:|-[textview]-|"),
            VisualFormatConstraintOptions(string: "H:|-buttonLeft-[button]-buttonRight-|"),
            VisualFormatConstraintOptions(string: "V:|-top-[title]-[subtitle]-[textfield]", options: .AlignAllLeft),
            VisualFormatConstraintOptions(string: "V:|-top-[photo(==photoH)]"),
            VisualFormatConstraintOptions(string: "V:[line(==1)]-[textview(==200)]-200-[button(==buttonH)]-8-|")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["top" : 30, "buttonH" : 44, "buttonLeft" : 100, "buttonRight" : 100, "photoW" : 100, "photoH" : 60]
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return [
            ConstraintOptions(identifier: "titleHeight", itemIdentifier: "title", attribute: .Height, relatedBy: .Equal, toItemIdentifier: nil, attribute: .Height, multiplier: 1, constant: 40)
        ]
    }
}
```
**Here the result with no extra work to do :), but ugly colors.**

![Advanced view configurations](https://raw.github.com/kmalkic/LazyKit/master/Readme_Assets/AdvanceViewConf.png)



### Access an element
```swift
//viewManager.element(...) return an optional 
if let title: UILabel = viewManager.element("title") {
    ...
}
//or you can call 
if let title = viewManager.label("title") {
    ...
}
```

### Update an element
You can update the element with any of the base options.
```swift
viewManager.updateElement("title", baseOptions: TextBaseOptions(text: "something", textColor: .greenColor()))
```

### Update an element with states, such as UIButton
```swift
viewManager.updateElementForStates("button", baseOptions: [.Normal: TextBaseOptions(text: "Done"), .Highlighted: TextBaseOptions(text: "Highlighted")])
```

### Update a contraints constant
For this particular change, it is recommended to not use Visual format constraints because it does create an array of NSLayoutConstraints.
Best is to create a constraint using this function:
```swift
static func layoutConstraints() -> [ConstraintOptions]? {
    return [
            ConstraintOptions(identifier: "titleHeight", itemIdentifier: "title", attribute: .Height, relatedBy: .Equal, toItemIdentifier: nil, attribute: .Height, multiplier: 1, constant: 40)
        ]
```
Now you will be able to target the specific constraint you want to change.
```swift
//This will make your title height to change from 40 to 120. Usefull if you want to expand/collapse an element.
viewManager.changeConstantOfLayoutConstaint("titleHeight", constant: 120)
```


## FAQ
## Credits
## License

LazyKit is released under the MIT license. See LICENSE for details.