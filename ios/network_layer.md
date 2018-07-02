# Network Layer based on Provider <- Router <- DTO (Data Transfer Object)

This example shows how to organize network layer without traditional NetworkManager class.

**Provider** is class which has two public methods: 

```swift
static func provideObject<T: Decodable>(_ router: APIRouterProtocol, completion: @escaping (T?, ErrorDTO?) -> Void) (1)
static func provideList<T: Decodable>(_ router: APIRouterProtocol, completion: @escaping ([T]?, ErrorDTO?) -> Void) (2)
```
*T - your DTO type.

You will be using **(1)** in the case when type of response object is `T` and **(2)** when is `Array<T>`

**Router** is object that conforms to `APIRouter` protocol:

```swift
protocol APIRouter: URLRequestConvertible {
var path: String { get }
var baseUrl: String { get }
var method: HTTPMethod { get }
var parameters: Parameters? { get }
}
```

**DTO** is an API model: 

```swift
struct UserRegistrationDTO: Codable {
let email: String
let password: String
let confirmPassword: String
}
```

You can use this example in your project and all you need is `create your own APIRouter` and `DTOs`.

Usage (from example project): 

```swift
APIProvider.provideObject(APIRouter.signUp(model: model)) { (_ successDTO: SuccessResponseDTO?, error) in
if successDTO?.success == true {
//TODO: Handle success
return
}
if let error = error {
//TODO: Handle error
}
}
```
