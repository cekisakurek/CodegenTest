import ComposableArchitecture
import Foundation


public struct ForgotPasswordModule: Reducer {

    public static var controller: ForgotPasswordModuleReceiver!

    public init() {}

    public struct State: Equatable {
     public var username: String = ""
    

    

    public init(
    username: String = ""
    
    
    ) {
        self.username = username
        
        
    }
}

    public enum Action: Equatable {
    case remindPasswordButtonTapped
    case remindResponse(result: TaskResult<String>?)
    case setUsername(username: String)
    
}

    public var body: some ReducerOf<Self> {
    Reduce { state, action in
        switch action {
        
            case .remindPasswordButtonTapped:
                return ForgotPasswordModule.controller.remindPasswordButtonTapped(state: &state, action: action)
        
            case .remindResponse(let result):
                return ForgotPasswordModule.controller.remindResponse(result: result, state: &state, action: action)
        
            case .setUsername(let username):
                return ForgotPasswordModule.controller.setUsername(username: username, state: &state, action: action)
        
        }
    }
    
}
}

public protocol ForgotPasswordModuleReceiver {
    func remindPasswordButtonTapped(state: inout ForgotPasswordModule.State, action: ForgotPasswordModule.Action) -> Effect<ForgotPasswordModule.Action> -> Effect<ForgotPasswordModule.Action>
    func remindResponse(result: TaskResult<String>?, state: inout ForgotPasswordModule.State, action: ForgotPasswordModule.Action) -> Effect<ForgotPasswordModule.Action> -> Effect<ForgotPasswordModule.Action>
    func setUsername(username: String, state: inout ForgotPasswordModule.State, action: ForgotPasswordModule.Action) -> Effect<ForgotPasswordModule.Action> -> Effect<ForgotPasswordModule.Action>
    
}