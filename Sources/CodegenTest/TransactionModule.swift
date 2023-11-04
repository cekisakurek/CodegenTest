import ComposableArchitecture
import Foundation


public struct TransactionModule: Reducer {

    public static var controller: TransactionModuleReceiver!

    public init() {}

    public struct State: Equatable {
     public var transaction: Transaction
    

    

    public init(
    transaction: Transaction
    
    
    ) {
        self.transaction = transaction
        
        
    }
}

    public enum Action: Equatable {
    
}

    public var body: some ReducerOf<Self> {
    Reduce { state, action in
        switch action {
        
        }
    }
    
}
}

public protocol TransactionModuleReceiver {
    
}