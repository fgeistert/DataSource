# DataSource

<img src="https://img.shields.io/badge/Platform-iOS%208%2B-blue.svg" alt="Platform iOS9+">
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/Language-Swift%203-orange.svg" alt="Language: Swift 3" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg" alt="Carthage compatible" /></a>
[![Build Status](https://travis-ci.org/mbuchetics/DataSource.svg?branch=master)](https://travis-ci.org/mbuchetics/DataSource)
[![codecov.io](https://codecov.io/github/mbuchetics/DataSource/coverage.svg?branch=master)](https://codecov.io/github/mbuchetics/DataSource?branch=master)

Framework to simplify the setup of `UITableView` data sources and cells. Separates the model (represented by a generic `DataSource`) from the representation (`TableViewDataSource`) by using type-safe cell configurators (`TableViewCellConfigurator`) to handle the table cell setup in an simple way.

`DataSource` is not limited to table views but could be extended to collection views or other custom representations as well.

<img src="https://github.com/mbuchetics/DataSource/blob/master/Resources/screenshot.png" height="300" alt="all about apps" />

## Requirements

iOS 9.0+, Swift 3

## Usage

An example app is included demonstrating DataSource's functionality. The example demonstrates various uses cases ranging from a simple list of strings to more complex examples with heterogenous section types.

### Getting Started

Create a `DataSource` with a single section and some rows that all share the same row identifier:

```swift
let dataSource2 = DataSource(section:
	Section(title: "Strings", rowIdentifier: "TextCell", rows: ["some text", "another text"])
)
```

Create a `TableViewDataSource` with a single `TableViewCellConfigurator` for the strings:

```swift
let tableDataSource = TableViewDataSource(
    dataSource: dataSource,
    configurator: TableViewCellConfigurator(identifier: "TextCell") { (title: String, cell: UITableViewCell, indexPath: NSIndexPath) in
        cell.textLabel?.text = "\(indexPath.row): \(title)"
    })
```

Assign it to your tableView´s dataSource:

```swift
tableView.dataSource = tableDataSource
```

Note: Make sure to keep a strong reference to `tableDataSource` (e.g. by storing it in a property).

### Multiple Sections and Row Types

Create a `DataSource` with multiple sections and rows:

```swift
let dataSource = DataSource(sections: [
    Section(title: "B", footer: "Names starting with B", rowIdentifier: "PersonCell", rows: [
        Person(firstName: "Matthias", lastName: "Buchetics"),
    ]),
    Section(title: "M", footer: "Names starting with M", rowIdentifier: "PersonCell", rows: [
        Person(firstName: "Hugo", lastName: "Maier"),
        Person(firstName: "Max", lastName: "Mustermann"),
    ]),
    Section(title: "Strings", rowIdentifier: "TextCell", rows: [
        "some text",
        "another text"
    ]),
    Section(rowIdentifier: "Button", rows: [
        Button.Add,
        Button.Remove
    ]),
])
```

Create a `TableViewDataSource` with a `TableViewCellConfigurator` for each row type:

```swift
let tableDataSource = TableViewDataSource(
    dataSource: dataSource,
    configurators: [
        TableViewCellConfigurator(identifier: "PersonCell") { (person: Person, cell: PersonCell, _) in
            cell.firstNameLabel?.text = person.firstName
            cell.lastNameLabel?.text = person.lastName
        },
        TableViewCellConfigurator(identifier: "TextCell") { (title: String, cell: UITableViewCell, _) in
            cell.textLabel?.text = title
        },
        TableViewCellConfigurator(identifier: "ButtonCell") { (button: Button, cell: ButtonCell, _) in
            switch (button) {
            case .Add:
                cell.titleLabel?.text = "Add"
                cell.backgroundColor = UIColor(red: 0, green: 0.7, blue: 0.2, alpha: 0.8)
            case .Remove:
                cell.titleLabel?.text = "Remove"
                cell.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
            }
        },
    ])
```

Assign it to your tableView´s dataSource and again make sure to keep a strong reference to the data source.

### Creating rows using a creator closure

Instead of setting an array of rows you can also instantiate rows using a closure:

```swift
let dataSource = DataSource(sections: [
    Section<String>(title: "test", rowCountClosure: { return 5 }, rowCreatorClosure: { (rowIndex) in
        return Row(identifier: "Text", data: ((rowIndex + 1) % 2 == 0) ? "even" : "odd")
    }),
    Section<Any>(title: "mixed", rowCountClosure: { return 5 }, rowCreatorClosure: { (rowIndex) in
        if rowIndex % 2 == 0 {
            return Row(identifier: "TextCell", data: "test")
        }
        else {
           return Row(identifier: "PersonCell", data: Person(firstName: "Max", lastName: "Mustermann"))
        }
    })
])
```

Create a `TableViewDataSource` with cell configurators as shown above.

### Convenience

Several extensions on `Array` and `Dictionary` exist to make creating data sources even easier.

Create a data source with a single section based on an array:

```swift
let dataSource = ["a", "b", "c", "d"].dataSource(rowIdentifier: "Text")
```

Create a data source based on a dictionary, using it's keys as the section titles:

```swift
let data = [
    "section 1": ["a", "b", "c"],
    "section 2": ["d", "e", "f"],
    "section 3": ["g", "h", "i"],
]

let dataSource = data.dataSource(rowIdentifier: "TextCell", orderedKeys: data.keys.sort())
```

Note: Because dictionaries are unordered, it's required to provide an array of ordered keys as well.

### Realm Support

Check out [RealmDataSource](https://github.com/mbuchetics/RealmDataSource) to create data sources based on [Realm](http://realm.io) queries.

## Installation

### Carthage

Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

```
github "mbuchetics/DataSource", ~> 3.0
```

Then run `carthage update`.

### Manually

Just drag and drop the `.swift` files in the `DataSource` folder into your project.

## License

`DataSource` is available under the MIT license. See the [LICENSE](https://github.com/mbuchetics/DataSource/blob/master/LICENSE.md) file for details.

## Contact

Contact me at [matthias.buchetics.com](http://matthias.buchetics.com) or follow me on [Twitter](https://twitter.com/mbuchetics).

Made with ❤ at [all about apps](https://www.allaboutapps.at).

[<img src="https://github.com/mbuchetics/DataSource/blob/master/Resources/aaa_logo.png" height="60" alt="all about apps" />](https://www.allaboutapps.at)
