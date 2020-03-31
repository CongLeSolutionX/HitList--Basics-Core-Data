#  Core  Data basics

This project is a simple demo of how to use Core Data.
- **Core Data** provides *on-disk persistence*, which means your data will be accessible even after terminating your app or shutting down your device. This is difference from the *in-memory persistence*, which will only save your data as long as your app is in memory, either in the foreground or in the background. 
- Xcode provides **Data Model editor** to create **managed object model** 
- A **managed object model** consists of: **entities**, **attributes**, and **relationships**

- An **entity** is a class definition in Core Data. The classic example is an `Employee` or a `Company`. In a relational database, an entity coresponds to a table. 
- An **attribute** is a piece of info attached to a particular entity. For example, an `Employee` entity could have attributes for the employee's `name`, `position`, and `salary`. In a database, an attribute corresponds to a particular field in a table. 
- A **relationship** is a link between multiple entities. In Core Data, relationships between 2 entities are called **to-one relationships**, while those between one and many entities are called **to-many relationships**. For example, a `Manager` can have a **to-many relationship** with a set of employees, whereas an individual `Employee` will usually have a **to-one relationship** with his manager. 
- Note: **entities** sounds like **classes**.Likewise, **attributes** and **relationships** sound like **properties**. We can think a **Core Data entity** is a class definition and the **managed object** is an instance of that class 

- `NSManagedObject` is a run-time representation of a Core Data entity. We can read, and write to its attributes using **Key-Value Coding** 
- The only way Core Data provides to read the value is **key-value coding**, aka **KVC**
- **KVC** is a mechanism in Foundation for accessing an object's properties indirectly using strings. **KVC** is available to all classes inheriting from `NSObject`, included `NSManagedObject`. We cant access properties using **KVC** on a Swift object that doesnt descend from `NSObject`.
- we need an **NSMAnagedObjectContext** to *save( )* or *fetch(_: )* data to and from Core Data 
