////import Fluent
//
//// I don't understand this very well yet, but I used the template provided by default
//
//struct CreateUserMigration: AsyncMigration {
//    func prepare(on database: any Database) async throws {
//        try await database.schema("users")
//            .id()
//            .field("username", .string, .required)
//            .field("email", .string, .required)
//            .field("password", .string, .required)
//            .field("created_at", .datetime)
//            .unique(on: "email")
//            .unique(on: "username")
//            .create()
//    }
//
//    func revert(on database: any Database) async throws {
//        try await database.schema("users").delete()
//    }
//}
