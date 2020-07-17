import FluentSQLite
import Vapor
import FluentMySQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    //修改端口
    let myService = NIOServerConfig.default(port:8001)
    services.register(myService)
    try services.register(FluentSQLiteProvider())
    try services.register(FluentMySQLProvider())

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
    
//    //使用内存数据库
//    let sqlite = try SQLiteDatabase(storage: .memory)
    
    //使用文件数据库SQLite
    let sqlite = try SQLiteDatabase(storage: .file(path: "/Users/zhengzhilin/db.sqlite"))
    //使用mysql
    let config = MySQLDatabaseConfig(hostname: "127.0.0.1", port: 3306, username: "root", password: "123456", database: "mydb",transport: MySQLTransportConfig.unverifiedTLS)
    let mysql = MySQLDatabase(config: config)
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
//    databases.add(database: mysql, as: .mysql)
//    databases.enableLogging(on: .mysql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
//    migrations.add(model: Acronym.self, database: .sqlite)
    migrations.add(model: User.self, database: .sqlite)
    
//    migrations.add(migration: AddEmail.self, database: .mysql)
    
    var commandConfig = CommandConfig.default()
    commandConfig.useFluentCommands()
    services.register(commandConfig)
    
    services.register(migrations)
}
