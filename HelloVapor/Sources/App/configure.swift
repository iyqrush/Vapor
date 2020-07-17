//import FluentSQLite
import FluentPostgreSQL
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())
    try services.register(LeafProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
//    let sqlite = try SQLiteDatabase(storage: .file(path: "/Users/Shared/Relocated Items/Security/Work/Private/Swift/Server/Vapor/test.db"))

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    let databaseConfig = PostgreSQLDatabaseConfig(hostname: "localhost", username: "vapor",
                                                  database: "vapor", password: "password")
    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
    migrations.add(model: Acronym.self, database: .psql)
//    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: Room.self, database: .psql)
    migrations.add(model: User.self, database: .psql)
//    migrations.add(migration: AddRoomName.self, database: .psql)
//    migrations.add(migration: AddRooms.self, database: .psql)
    services.register(migrations)
    
    // 1
    var commandConfig = CommandConfig.default()
    // 2
    commandConfig.useFluentCommands()
    // 3
    services.register(commandConfig)
    
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

}
