# LazyKit

LazyKit is a framework that allow you to write fast and easy views.<br />
Constructing a view can be long, boring and repetitive, especialy after the n view built.<br />
> **You can now use basic CSS files to style your elements.**

## Features

- Maps UIView / UILabel / UIButton / UIImageView / UITextField / UITextView / UITableView / UICollectionView
- Base classes for UIViewController / UIView / UITableViewCell / UICollectionViewCell
- CSS parser / mapper (You'll be even more lazy with that)
- Swap CSS themes at runtime

## Features coming up

- Support for borders/radius in css
- Supoort for text decorations in css

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

> CocoaPods 0.39.0+ is required to build LazyKit 1.1.3+.

To integrate LazyKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

> Finally working!!!

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'LazyKit', '~> 1.1.3'
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

### Create an advanced view configurations without CSS

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

## Using CSS
### CSS example

The styling is declared using a CSS-like syntax that also supports variables:

```css
@global_bold_font_name: RobotoSlab-Bold;
@global_regular_font_name: RobotoSlab-Regular;
@titleColor: #ff0000;
@tintColor: #3e8fdb;
@bodyColor: #333333;

body {
    color: @bodyColor;
    font-family: @global_bold_font_name;
    placeholder-font-family: @global_bold_font_name;
}

#title {
    color: @titleColor;
    font-size: 14px;
    text-align:left;
    text-maxline: 2;
}

.subtitle {
    font-size: 12px;
    text-align:left;
    text-indent: 5px;
    text-decoration: underline;
    text-decoration-color: rgba(0,0,0,1);
}

#photo {
    background-image-content: scaleToFill;
}

.photo {
    background-image: myimage;
}
```

Here the list of available attributes:

```css
******************************************************************
GENERAL KEYS:
  'background' 
  'background-color' 
  'tint-color' 
  'bartint-color' 
     Usage: #RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))
  'background-image' 
     Usage: image name, without ""
  'background-image-content' 
     Usage: scaleToFit | scaleToFill | center | top | left | bottom | right

TEXT KEYS:
  'color' 
     Usage: #RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))
  'font-family' 
     Usage: font name, without ""
  'font-size' 
     Usage: size in px
  'text-align' 
     Usage: left | center | right | justify
  'text-maxline' 
     Usage: number of lines max (integer)
  'line-height' 
     Usage: height in px
  'paragraph-spacing' 
     Usage: spacing in px
  'text-indent' 
     Usage: header in px. Used to indent first line of any new paragraph.
  'word-wrap' 
     Usage: word-wrapping | char-wrapping | clipping | truncating-head | truncating-tail | truncating-middle
  'text-stroke-color' 
     Usage: #RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))
  'text-stroke-width' 
     Usage: width in px
  'text-decoration' 
     Usage: none|underline|line-through
  'text-decoration-color' 
     Usage: #RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))

For placeholder styling
  'placeholder-' 
     Usage: You can add 'placeholder-' to any of the above text keys

DECORATIONS KEYS:
  'border' 
     Patterns: 
       - width color
  'border-color' 
     Usage: #RBG | #ARGB | #RRGGBB | #AARRGGBB | rgb(red(0-255),green(0-255),blue(0-255)) | rgba(red(0-255),green(0-255),blue(0-255),alpha(0.0-1.0))
  'border-width' 
     Patterns: 
       - width
  'border-radius' 
     Usage: radius in px
     
******************************************************************
```

For more flexibility It is possible to nest id and classes together such as:<br />
Very similar to what you do in html, but limited to those.

```css
#title.commonText {} //will apply this style to any element that as styleClass = "commonText" and styleId = "title"
#title.commonText.link {} //will apply this style to any element that as styleClass = "commonText link" and styleId = "title"
.commonText.link {} //will apply this style to any element that as styleClass = "commonText link"
UILabel.commonText.link {} //will apply this style to all UILabel that as styleClass = "commonText link"
UITextField {} //will apply this style to all UITextField
```

### Initialise the CSS Style manager

If you prefer seperating css files, you can add it to the array.<br />
You will notice that it is urls, so you can use http. :)

```swift
//Load style from bundle
let defaultUrls = [
    NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("default.css", ofType: nil)!)
]
LazyStyleSheetManager.shared.setDefaultStylesFromFileAtUrls(defaultUrls)
```

### Theme swapping

Can load a different set of css files for a given collection name

```swift
let defaultUrls = [
    NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("default.css", ofType: nil)!)
]
LazyStyleSheetManager.shared.setDefaultStylesFromFileAtUrls(defaultUrls)

let alternativeUrls = [
	NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alt.css", ofType: nil)!)
]
LazyStyleSheetManager.shared.setStylesFromFileAtUrls(alternativeUrls, collectionName: kAlternativeCollectionName)
```

Whenever you need you can swap by changing currentCollecionName to your other styles.
This will trigger a notification under kUpdateStylesNotificationKey. It is automatic so no need to addObserver to it, unless for other purposes.

```swift
LazyStyleSheetManager.shared.currentCollectionName = kAlternativeCollectionName
```

### CSS Style manager helper

To print out css attributes and options.

```swift
LazyStyleSheetManager.shared.help()
```

### Create an advanced view configurations with CSS

Pretty much the same way as above, but simplier.

```swift
import LazyKit

struct MyConfigurations: LazyViewConfigurations {
    
    static func elementsOptions() -> [ElementOptions]? {
        return [
            LabelOptions(identifier: "title",
                text: "hello",
                styleId: "title"),
            
            LabelOptions(identifier: "subtitle",
                text: "hey",
                styleId: "subtitle"),
            
            ButtonOptions(identifier: "button",
                texts: [.Normal: "button", .Highlighted: "highlighted"],
                styleId: "button"),
            
            ViewOptions(identifier: "line",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor())),
            
            ImageOptions(identifier: "photo",
                styleId: "photo",
                styleClass: "photo"),
            
            TextFieldOptions(identifier: "textfield",
                placeholderText: "placeholder",
                styleId: "textfield",
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .NumbersAndPunctuation, keyboardAppearance: .Dark, returnKeyType: .Done)),
            
            TextViewOptions(identifier: "textview",
                styleId: "textview",
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .EmailAddress, keyboardAppearance: .Dark, returnKeyType: .Done)
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

### Access an element

Various way of doing it

```swift
viewManager.updateElement("title", elementOptions: LabelOptions(textOptions: TextBaseOptions(text: "Bonjour")))

viewManager.updateElement("title", type: UILabel.self) { (element) -> Void in
	
	element.text = "Bonjour"
}

if let title: UILabel = viewManager.element("title") {
	
	title.text = "Bonjour"
}

if let title = viewManager.label("title") {
	
	title.text = "Bonjour"
}

viewManager.label("title")!.text = "Bonjour"
```

### Update an element with new options

You can update the element with any of the base options.<br />
Note that the new option will replace only the non nil attributes.

```swift
viewManager.updateElement("title", elementOptions: LabelOptions(textOptions: TextBaseOptions(text: "Bonjour")))
```

### Update an element with states, such as UIButton

```swift
viewManager.updateElement("button", elementOptions: ButtonOptions(textOptionsForType: [.Normal: TextBaseOptions(text: "Done"), .Highlighted: TextBaseOptions(text: "Highlighted")]))
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

Kevin Malkic

## License

LazyKit is released under the MIT license. See LICENSE for details.