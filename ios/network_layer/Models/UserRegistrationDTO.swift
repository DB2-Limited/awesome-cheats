import Foundation

struct UserRegistrationDTO: Codable {
    let email: String
    let password: String
    let confirmPassword: String
}
