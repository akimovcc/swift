import UIKit
// Домашнее задание №7
//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

enum coffeeMachineError: Error, CustomStringConvertible{
    
    case insufficientFunds(moneyNeeded: Float)
    case notEnoughMilk(milkNeeded:Int)
    case notEnoughWater(waterNeeded:Int)
    case notEnoughCoffee(coffeeNeeded: Int)
    case cleaningRequired
    case invalidSelection

    var description: String {
        switch self {
        case .invalidSelection: return "Invalid selection. Try something else."
        case .insufficientFunds(let moneyNeeded): return "Need more \(moneyNeeded) money."
        case .notEnoughMilk(let milkNeeded): return "Need more \(milkNeeded) milk."
        case .notEnoughCoffee(let coffeeNeeded): return "Need more \(coffeeNeeded) coffee."
        case .notEnoughWater(let waterNeeded): return "Need more \(waterNeeded) water."
        case .cleaningRequired: return "Cleaning required!"
        }
    }
}

class coffeeMachine{

    struct item {
        var coffee: Int
        var water: Int
        var milk: Int
        var price: Float
    }

    var menu =  [
        "Americano" : item(coffee: 7, water: 43, milk: 0, price: 90),
        "Espresso" : item(coffee: 9, water: 61, milk: 0, price: 110),
        "Cappuccino" : item(coffee: 9, water: 101, milk: 40, price: 140)]
    
    var needClean = false
    var cycles = 0
    
    var balanceOfMoney: Float = 350
    var balanceOfWater: Int = 350
    var balanceOfCoffee: Int = 40
    var balanceOfMilk: Int = 60
    
    func cleanCoffeeMachine(){
        cycles = 0
    }
    
    func buyCoffee(itemNamed name: String) throws {
    
        guard let item = menu[name] else {
            throw coffeeMachineError.invalidSelection
        }
        
        guard cycles < 5 else {
            throw coffeeMachineError.cleaningRequired
        }
        
        guard item.price < balanceOfMoney else {
            throw coffeeMachineError.insufficientFunds(moneyNeeded: (item.price - balanceOfMoney))
        }
        
        guard item.coffee < balanceOfCoffee else {
            throw coffeeMachineError.notEnoughCoffee(coffeeNeeded: (item.coffee - balanceOfCoffee))
        }
        
        guard item.water < balanceOfWater else {
            throw coffeeMachineError.notEnoughWater(waterNeeded: (item.water - balanceOfWater))
        }
       
        guard item.milk < balanceOfMilk else {
            throw coffeeMachineError.notEnoughMilk(milkNeeded: item.milk - balanceOfMilk)
        }
        
        balanceOfMoney -= item.price
        balanceOfWater -= item.water
        balanceOfCoffee -= item.coffee
        balanceOfMilk -= item.milk
        cycles += 1
        print("Your coffee \(name) is ready!")
    }
}

var coffee = coffeeMachine()

do {
    try coffee.buyCoffee(itemNamed: "Americano")
} catch coffeeMachineError.invalidSelection{
    print("Ошибка выбора")
} catch coffeeMachineError.cleaningRequired{
    print("Требуется очистка")
} catch coffeeMachineError.insufficientFunds(let moneyNeeded){
    print("Недостаточно средств. Требуется \(moneyNeeded)")
} catch coffeeMachineError.notEnoughCoffee(let coffeeNeeded){
    print("Недостаточно кофе Требуется: \(coffeeNeeded) кофе")
} catch coffeeMachineError.notEnoughWater(let waterNeeded){
    print("Недостаточно воды. Требуется: \(waterNeeded) воды")
} catch coffeeMachineError.notEnoughMilk(let milkNeeded){
    print("Недостаточно молока Требуется: \(milkNeeded) молока")
}

do {
   try coffee.buyCoffee(itemNamed: "Espresso")
} catch let error as coffeeMachineError{
    print(error.description)
}

do {
    try coffee.buyCoffee(itemNamed: "Cappuccino")
} catch let error as coffeeMachineError{
    print(error.description)
}

do {
    try coffee.buyCoffee(itemNamed: "Latte")
} catch let error as coffeeMachineError{
    print(error.description)
}
