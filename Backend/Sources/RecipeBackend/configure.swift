import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor
import JWT

// from tutorial
extension String {
    var bytes: [UInt8] {.init(self.utf8)}
}

// configures your application
public func configure(_ app: Application) async throws {

    app.jwt.signers.use(.hs256(key: "your-secret-key"))
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//    app.databases.use(DatabaseConfigurationFactory.mysql(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .mysql)
    
    app.databases.use(.mysql(
        hostname: "localhost",
        port: 3306,
        username: "jenna",
        password: "password",
        database: "recipeappdb",
        tlsConfiguration: .forClient(certificateVerification: .none)
    ), as: .mysql)

//    app.migrations.add(CreateUserMigration())
//    app.migrations.add(CreateRecipeMigration())
//    app.migrations.add(CreateLikeMigration())
//    app.migrations.add(CreateCommentMigration())
    
    // from tutorial
//    let privateKey = try String(contentsOfFile:
//                                    app.directory.workingDirectory + "myjwt.key")
//    let privateSigner = try JWTSigners.rs256(key: .private(pem:
//                                                            privateKey.bytes))
//    
//    let publicKey = try String(contentsOfFile:
//                                    app.directory.workingDirectory + "myjwt.key.pub")
//    let publicSigner = try JWTSigners.rs256(key: .public(pem:
//                                                            publicKey.bytes))
//    
//    app.jwt.signers.use(privateSigner, kid: .private)
//    app.jwt.signers.use(publicSigner, kid: .public, isDefault: true)

    // register routes
    try routes(app)
}
