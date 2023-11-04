import ComposableArchitecture
import Foundation
import Network


public struct AppModule: Reducer {

    public static var controller: AppModuleReceiver!

    public init() {}

    public struct State: Equatable {
     public var hasNetworkConnection: Bool = true
     public var token: String?
    

    @PresentationState public let destination: AppModuleOverlayDestination.State?
     public let transactionListState: TransactionListModule.State = .init()
    

    public init(
    hasNetworkConnection: Bool = true,
    token: String? = nil
    
    ,destination: AppModuleOverlayDestination.State? = nil,
    transactionListState: TransactionListModule.State = .init()
    
    ) {
        self.hasNetworkConnection = hasNetworkConnection
        self.token = token
        
        self.destination = destination
        self.transactionListState = transactionListState
        
    }
}

    public enum Action: Equatable {
    case setupLaunch
    case updateNetworkConnection(status: NWPath.Status)
    
}

    public var body: some ReducerOf<Self> {
    Reduce { state, action in
        switch action {
        
            case .setupLaunch:
                return AppModule.controller.setupLaunch(state: &state, action: action)
        
            case .updateNetworkConnection(let status):
                return AppModule.controller.updateNetworkConnection(status: status, state: &state, action: action)
        
        }
    }
    .forEach(\.destination, action: /Action.destination){ AppModuleOverlayDestination() }
Scope(state: \.transactionListState, action: /Action.transactionListState){ TransactionListModule() }

}
}

public protocol AppModuleReceiver {
    func setupLaunch(state: inout AppModule.State, action: AppModule.Action) -> Effect<AppModule.Action> -> Effect<AppModule.Action>
    func updateNetworkConnection(status: NWPath.Status, state: inout AppModule.State, action: AppModule.Action) -> Effect<AppModule.Action> -> Effect<AppModule.Action>
    
}