
/**
 # Access Control
 - Access control is used to restrict the access of your code in another source files or modules.
 - This feature enables us to hide the implementation detail of our code and specify a preferred interface through which that code can be accessed and used.
 */

// Module - A single unit of code distribution. Each build target is treated as a module.

// Package - A package is a group of modules that we develop as a unit.

/**
 # Access Levels
 - Open access: least restrictive. enable entities to be used within any source file from their defining module, or within a source file in another module that imports the defining module. This access level applies only to the classes and class members. It allow code outside the module to subclass or override the entities.

 - Public access: enabled entites to be used with in the source file from their defining module, or within a source file from another module  that imports the defining module. We can't subclass and override the entities.

 - Package access: enabled entities to be used with any source file from their defining package but not in any source file outside of that package.

 - Internal access: enabled entities to be used with in any source file in their defining module but not in any source file outside of their defining module.

 - File-private access: restricts the use of an entity to its own defining source file.

 - Private: most restrictive. restricts the use of an entity to the enclosing declaration, and to the extension of that declaration that are in the same file.
 */


