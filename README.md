# SuperRent
An iOS application for rental information posting &amp; searching written in Swift.

Made with ❤️.

##### Dependency libraries
+ [Carthage](https://github.com/Carthage/Carthage): a simple, decentralized dependency manager for Cocoa.

+ [Eureka](https://github.com/xmartlabs/Eureka): a library to create dynamic table-view forms from a [DSL] specification in Swift.

To specify the dependency of Eureka into project's `Cartfile`:

```ogdl
github "xmartlabs/Eureka" ~> 1.5
```

Then in terminal issue the following command:

```ogdl
carthage update
```

Eureka framework also needs to be mannually associated with this project in Xcode:
Under General -> Embedded Binaries, drag and drop the .framework file found in (project_path)/Carthage/Build/iOS/Eureka.framework

