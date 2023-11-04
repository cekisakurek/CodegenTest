import ComposableArchitecture
import Foundation


public struct RegisterModule: Reducer {

    public static var controller: RegisterModuleReceiver!

    public init() {}

    public struct State: Equatable {
     public var password: String = ""
     public var passwordConfirm: String = ""
     public var username: String = ""
    

    

    public init(
    password: String = "",
    passwordConfirm: String = "",
    username: String = ""
    
    
    ) {
        self.password = password
        self.passwordConfirm = passwordConfirm
        self.username = username
        
        
    }
}

    public enum Action: Equatable {
    case registerButtonTapped
    case registerResponse(result: TaskResult<String>?)
    case setPassword(password: String)
    case setPasswordConfirm(passwordConfirm: String)
    case setUsername(username: String)
    
}

    public var body: some ReducerOf<Self> {
    Reduce { state, action in
        switch action {
        
            case .registerButtonTapped:
                return RegisterModule.controller.registerButtonTapped(state: &state, action: action)
        
            case .registerResponse(let result):
                return RegisterModule.controller.registerResponse(result: result, state: &state, action: action)
        
            case .setPassword(let password):
                return RegisterModule.controller.setPassword(password: password, state: &state, action: action)
        
            case .setPasswordConfirm(let passwordConfirm):
                return RegisterModule.controller.setPasswordConfirm(passwordConfirm: passwordConfirm, state: &state, action: action)
        
            case .setUsername(let username):
                return RegisterModule.controller.setUsername(username: username, state: &state, action: action)
        
        }
    }
    
}
}

public protocol RegisterModuleReceiver {
    func registerButtonTapped(state: inout RegisterModule.State, action: RegisterModule.Action) -> Effect<RegisterModule.Action> -> Effect<RegisterModule.Action>
    func registerResponse(result: TaskResult<String>?, state: inout RegisterModule.State, action: RegisterModule.Action) -> Effect<RegisterModule.Action> -> Effect<RegisterModule.Action>
    func setPassword(password: String, state: inout RegisterModule.State, action: RegisterModule.Action) -> Effect<RegisterModule.Action> -> Effect<RegisterModule.Action>
    func setPasswordConfirm(passwordConfirm: String, state: inout RegisterModule.State, action: RegisterModule.Action) -> Effect<RegisterModule.Action> -> Effect<RegisterModule.Action>
    func setUsername(username: String, state: inout RegisterModule.State, action: RegisterModule.Action) -> Effect<RegisterModule.Action> -> Effect<RegisterModule.Action>
    
}