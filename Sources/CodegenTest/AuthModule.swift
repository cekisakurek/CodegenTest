import ComposableArchitecture
import Foundation


public struct AuthModule: Reducer {

    public static var controller: AuthModuleReceiver!

    public init() {}

    public struct State: Equatable {
     public var password: String = ""
     public var username: String = ""
    

    @PresentationState public let destination: AuthDestination.State?
    

    public init(
    password: String = "",
    username: String = ""
    
    ,destination: AuthDestination.State? = nil
    
    ) {
        self.password = password
        self.username = username
        
        self.destination = destination
        
    }
}

    public enum Action: Equatable {
    case forgotPasswordButtonTapped
    case loginButtonTapped
    case loginResponse(token: TaskResult<String>?)
    case registerButtonTapped
    case setPassword(password: String)
    case setUsername(username: String)
    
}

    public var body: some ReducerOf<Self> {
    Reduce { state, action in
        switch action {
        
            case .forgotPasswordButtonTapped:
                return AuthModule.controller.forgotPasswordButtonTapped(state: &state, action: action)
        
            case .loginButtonTapped:
                return AuthModule.controller.loginButtonTapped(state: &state, action: action)
        
            case .loginResponse(let token):
                return AuthModule.controller.loginResponse(token: token, state: &state, action: action)
        
            case .registerButtonTapped:
                return AuthModule.controller.registerButtonTapped(state: &state, action: action)
        
            case .setPassword(let password):
                return AuthModule.controller.setPassword(password: password, state: &state, action: action)
        
            case .setUsername(let username):
                return AuthModule.controller.setUsername(username: username, state: &state, action: action)
        
        }
    }
    .forEach(\.destination, action: /Action.destination){ AuthDestination() }

}
}

public protocol AuthModuleReceiver {
    func forgotPasswordButtonTapped(state: inout AuthModule.State, action: AuthModule.Action) -> Effect<AuthModule.Action> -> Effect<AuthModule.Action>
    func loginButtonTapped(state: inout AuthModule.State, action: AuthModule.Action) -> Effect<AuthModule.Action> -> Effect<AuthModule.Action>
    func loginResponse(token: TaskResult<String>?, state: inout AuthModule.State, action: AuthModule.Action) -> Effect<AuthModule.Action> -> Effect<AuthModule.Action>
    func registerButtonTapped(state: inout AuthModule.State, action: AuthModule.Action) -> Effect<AuthModule.Action> -> Effect<AuthModule.Action>
    func setPassword(password: String, state: inout AuthModule.State, action: AuthModule.Action) -> Effect<AuthModule.Action> -> Effect<AuthModule.Action>
    func setUsername(username: String, state: inout AuthModule.State, action: AuthModule.Action) -> Effect<AuthModule.Action> -> Effect<AuthModule.Action>
    
}