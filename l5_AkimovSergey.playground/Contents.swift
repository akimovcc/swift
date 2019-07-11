import UIKit
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.


//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

enum colors{ case красный, синий, зеленый, желтый, оранжевый, голубой, черный, белый, серебристый, перламутровый }

enum engineStatus: CustomStringConvertible {
    case on, off
    var description: String {
        switch self {
        case .on:
            return "Двигатель заведён"
        case .off:
            return "Двигатель заглушен"
        }
    }
}


protocol Car{

    var brand: String { get }
    var model: String { get }
    var color: colors { get set }
    var productionYear: Int { get }

    var wheels: Int { get }
    
    //два варианта через enum и через расширение Bool
    var engineStarted: engineStatus { get set }
    var windowsOpened: Bool { get set }
    
    associatedtype Value
    func action(action:Value)
}
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension Bool {
    mutating func toggle(){
        self = !self
    }
}

extension Car {
    mutating func toggleEngine(){
        switch self.engineStarted {
        case .on:
            self.engineStarted = .off
            print("Двигатель заглушен")
        case .off:
            self.engineStarted = .on
            print("Двигатель заведен")
        }
        
    }
    
    mutating func toggleWindows(){
        print(self.windowsOpened ? "Окна закрыты": "Окна открыты")
        return self.windowsOpened.toggle()
    }
    
    mutating func changeColor(color:colors){
        print("Цвет \(self.color) перекрашен в \(color)")
        self.color = color
    }
}

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class sportCar: Car{
    typealias Value = sportCarAction
    
    enum sportCarAction{ case accelerate(speed: Float), stop, turnLeft, turnRight, upToMaxSpeed}
    
    func action(action: sportCarAction) {
        switch action {
        case .accelerate(let speed):
            print("скорость автомобиля измена с \(self.speed) на \(self.speed + speed)")
            self.speed += speed
        case .stop:
            self.speed = 0
            print("Спортивный автомобиоль остановился")
        case .turnLeft:
            self.direction = (self.direction + 3) % 4
            print("Автомобиль повернул налево")
        case .turnRight:
            self.direction = (self.direction + 1) % 4
            print("Автомобиль повернул направо")
        case .upToMaxSpeed:
            self.speed = self.maxSpeed
            print("Спортивный автомобиоль разогнался до максимальной скорости \(self.maxSpeed)")
        }
    }
    
    var brand: String
    var model: String
    var color: colors
    var productionYear: Int
    
    var wheels: Int
    var windowsOpened: Bool
    var engineStarted: engineStatus
    var maxSpeed: Float
    var accelerationTime: Float
    var speed: Float
    var direction: Int = 0
    
    static var countSportCars: Int = 0
    
    init(brand: String, model: String, color: colors, productionYear: Int, wheels: Int , maxSpeed: Float, accelerationTime: Float){
        self.brand = brand
        self.model = model
        self.color = color
        self.productionYear = productionYear
        self.wheels = wheels
        self.engineStarted = .off
        self.windowsOpened = false
        self.maxSpeed = maxSpeed
        self.accelerationTime = accelerationTime
        self.speed = 0.0
        self.direction = 0
        sportCar.countSportCars += 1
        print("Добавлен спортивный автомобиль")
    }
    
    deinit {
       sportCar.countSportCars -= 1
        print("Спортивный автомобиль удален")
    }
    
    func showDirection()->String{
        let act = self.speed > 0 ? "двигается" : "остановилась, в направлении"
        
        
        switch self.direction {
        case 0 :
            return "Машина \(act) на Север"
        case 1 :
            return "Машина \(act) на Запад"
        case 2 :
            return "Машина \(act) на Юг"
        case 3 :
            return "Машина \(act) на Восток"
        default: return "Машина двигается в неизвестном направлении"
        }
    }
}

//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension sportCar: CustomStringConvertible {
    var description: String {
        return "Спортивный автомобиль \(self.brand) \(self.model) цвет автомобиля \(self.color), \(productionYear) год выпуска, количество колес \(self.wheels), \(engineStarted) Окна \(windowsOpened ? "открыты":"закрыты"), скорость: \(self.speed) км/ч \(showDirection())"
    }
}

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class trunkCar: Car{

    typealias Value = trunkCarAction
    
    func action(action: trunkCar.trunkCarAction) {
        switch action {
        case .loadTrunk(let capacity):
            if ((self.capacity + capacity) < self.maxCapacity){
            self.capacity += capacity
            print("Загружено \(capacity) кг в цистерну.")
            }else{
            print("Превышен объем. Загружено только \(self.maxCapacity - self.capacity) кг в цистерну.")
                self.capacity = self.maxCapacity
        }
        case .unloadTrunk(let capacity):
            if ((self.capacity - capacity) >= 0){
                self.capacity -= capacity
             print("Разгружено \(capacity) кг из цистерны.")
            }else{
                print("Недостаточно груза в цистерне. Выгружено \(self.capacity) кг из цистерны.")
                self.capacity = 0
            }
        }
    }
    
    enum trunkCarAction{
        case loadTrunk(capacity: Float),unloadTrunk(capacity: Float)}

    var brand: String
    var model: String
    var color: colors
    var productionYear: Int
    
    var wheels: Int
    var windowsOpened: Bool
    var engineStarted: engineStatus
    
    var maxCapacity: Float
    var uploadingTime: Float
    var capacity: Float
    
    static var countTrunkCars: Int = 0
    
    init(brand: String, model: String, color: colors, productionYear: Int, wheels: Int , maxCapacity: Float, uploadingTime: Float){
        self.brand = brand
        self.model = model
        self.color = color
        self.productionYear = productionYear
        self.wheels = wheels
        self.engineStarted = .off
        self.windowsOpened = false
        self.maxCapacity = maxCapacity
        self.uploadingTime = uploadingTime
        self.capacity = 0.0
        trunkCar.countTrunkCars += 1
        print("Добавлена грузовая цистерна")
    }

    deinit {
        trunkCar.countTrunkCars -= 1
        print("Удалена грузовая цистерна")
    }
}
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension trunkCar: CustomStringConvertible {
    var description: String {
        return "Грузовая цистерна \(self.brand) \(self.model) цвет цистерны \(self.color), \(productionYear) год выпуска, количество колес \(self.wheels), \(engineStarted) Окна \(windowsOpened ? "открыты":"закрыты"), максимальный объем цистерны \(maxCapacity) заполнен на \(NSString(format:"%.2f", capacity/maxCapacity*100))%"
    }
}
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
var audi = sportCar(brand: "Audi", model: "TT", color:.оранжевый, productionYear: 2018, wheels: 4, maxSpeed: 262.5, accelerationTime: 5.3)
var volvo = trunkCar(brand: "Volvo", model: "FMX", color: .серебристый, productionYear: 2015, wheels: 10, maxCapacity: 20000.0, uploadingTime: 2500.5)

print(audi)

audi.changeColor(color: .красный)
audi.toggleEngine()
audi.toggleWindows()
audi.action(action: .accelerate(speed: 141.5))
audi.action(action: .turnLeft)
audi.action(action: .turnLeft)
audi.action(action: .turnRight)
audi.action(action: .turnRight)
audi.action(action: .upToMaxSpeed)

print(audi)

audi.action(action: .stop)

print(volvo)

volvo.toggleEngine()
volvo.toggleWindows()
volvo.action(action: .loadTrunk(capacity: 5550.90))
volvo.action(action: .unloadTrunk(capacity: 2350.40))
//6. Вывести сами объекты в консоль.
print(audi)
print(volvo)
