import ComposableArchitecture
import Foundation


public struct TransactionListModule: Reducer {

    public static var controller: TransactionListModuleReceiver!

    public init() {}

    public struct State: Equatable {
     public var allTransactions: [Transaction] = []
     public var filteredAndSortedTransactions: [Transaction] = []
     public var isLoading: Bool = true
     public var selectedCategory: Transaction.Category = .all
     public var selectedSortDirection: TransactionSortDirection = .bookingDateDesc
     public var transactionsTotal: Transaction.Detail.Value?
    

    

    public init(
    allTransactions: [Transaction] = [],
    filteredAndSortedTransactions: [Transaction] = [],
    isLoading: Bool = true,
    selectedCategory: Transaction.Category = .all,
    selectedSortDirection: TransactionSortDirection = .bookingDateDesc,
    transactionsTotal: Transaction.Detail.Value? = nil
    
    
    ) {
        self.allTransactions = allTransactions
        self.filteredAndSortedTransactions = filteredAndSortedTransactions
        self.isLoading = isLoading
        self.selectedCategory = selectedCategory
        self.selectedSortDirection = selectedSortDirection
        self.transactionsTotal = transactionsTotal
        
        
    }
}

    public enum Action: Equatable {
    case loadTransactions
    case loadTransactionsResponse(result: TaskResult<[Transaction]>?)
    case retryAction
    case setSelectedCategory(category: Transaction.Category)
    case setSelectedSortDirection(direction: TransactionSortDirection)
    case transactions(id: TransactionModule.State.ID, moduleAction: TransactionModule.Action)
    case transactionsTotalUpdated(value: TaskResult<Transaction.Detail.Value>?)
    case updateTransactionTotal
    case waitAndLoad
    
}

    public var body: some ReducerOf<Self> {
    Reduce { state, action in
        switch action {
        
            case .loadTransactions:
                return TransactionListModule.controller.loadTransactions(state: &state, action: action)
        
            case .loadTransactionsResponse(let result):
                return TransactionListModule.controller.loadTransactionsResponse(result: result, state: &state, action: action)
        
            case .retryAction:
                return TransactionListModule.controller.retryAction(state: &state, action: action)
        
            case .setSelectedCategory(let category):
                return TransactionListModule.controller.setSelectedCategory(category: category, state: &state, action: action)
        
            case .setSelectedSortDirection(let direction):
                return TransactionListModule.controller.setSelectedSortDirection(direction: direction, state: &state, action: action)
        
            case .transactions(let id, let moduleAction):
                return TransactionListModule.controller.transactions(id: id, moduleAction: moduleAction, state: &state, action: action)
        
            case .transactionsTotalUpdated(let value):
                return TransactionListModule.controller.transactionsTotalUpdated(value: value, state: &state, action: action)
        
            case .updateTransactionTotal:
                return TransactionListModule.controller.updateTransactionTotal(state: &state, action: action)
        
            case .waitAndLoad:
                return TransactionListModule.controller.waitAndLoad(state: &state, action: action)
        
        }
    }
    
}
}

public protocol TransactionListModuleReceiver {
    func loadTransactions(state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func loadTransactionsResponse(result: TaskResult<[Transaction]>?, state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func retryAction(state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func setSelectedCategory(category: Transaction.Category, state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func setSelectedSortDirection(direction: TransactionSortDirection, state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func transactions(id: TransactionModule.State.ID, moduleAction: TransactionModule.Action, state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func transactionsTotalUpdated(value: TaskResult<Transaction.Detail.Value>?, state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func updateTransactionTotal(state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    func waitAndLoad(state: inout TransactionListModule.State, action: TransactionListModule.Action) -> Effect<TransactionListModule.Action> -> Effect<TransactionListModule.Action>
    
}