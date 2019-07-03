import UIKit

enum colors{ case red, orange, yellow, green, blue, purple, black, white, silver }
    

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
class Car {
    
    enum action {case prepare, start, stop, recharge}
    var brand, model : String
    var color: colors
    var productionYear, seats: Int
    static var countOfCars: Int = 0
    
    func action(action:action){
        
    }
   
    init(brand: String, model: String, color: colors, productionYear: Int, seats:Int){
        self.brand = brand
        self.model = model
        self.color = color
        self.productionYear = productionYear
        self.seats = seats

        Car.countOfCars += 1
        print("Добавлен автомобиль")
    }
    
    deinit {
       Car.countOfCars -= 1
        print("Удален автомобиль")
    }
    
   func description(){
    print("Создан \(brand) \(model) \(color) цвет, произведено в \(productionYear) году, количество мест \(seats).")
    }

}

//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
class sportCar: Car{
 //3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
    enum bodyKit{
       case competitionKit, sportKit, raceKit
    }
    enum engineTuning{
        case stageOne, stageTwo, stageThree
    }
    enum driveType{case FR, FF, MR, AWD}
    
    enum switchDoors{case opened, closed}

    var driveType: driveType
    var accelerationTime: Float
    var maxSpeed: Float
    var botyKit: bodyKit
    var engineTuning: engineTuning
    var turbo: Bool
    var spoiler: Bool
    var tyreInch: Int
    
    var driverInCar: Bool
    var switchDoors: switchDoors
    var speed : Float
    var fastenSeatBelt : Bool

    static var countOfSportCars: Int = 0

    init(brand: String, model:String, color:colors, productionYear: Int, seats: Int , driveType: driveType, accelerationTime: Float, maxSpeed: Float, bodyKit: bodyKit, engineTuning:engineTuning, turbo: Bool, spoiler: Bool, tyreInch: Int){

        self.driveType = driveType
        self.accelerationTime = accelerationTime
        self.maxSpeed = maxSpeed
        self.botyKit = bodyKit
        self.engineTuning = engineTuning
        self.turbo = turbo
        self.spoiler = spoiler
        self.tyreInch = tyreInch
        
        self.driverInCar = false
        self.fastenSeatBelt = false
        self.switchDoors = .opened
        self.speed = 0
        

       super.init(brand: brand, model: model, color:color, productionYear:productionYear,seats:seats)

        sportCar.countOfSportCars += 1
        print("Добавлен спорткар")
    }

    deinit {
        sportCar.countOfCars -= 1
        print("Удален спорткар")
    }
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    override func action(action:action) {
        switch action {
        case .prepare:
            self.driverInCar = true
            self.switchDoors = .closed
            self.fastenSeatBelt = true
            self.speed = 0
            print("Водитель сел в автомобиль, двери закрыты, ремень пристёгнут. Готов к гонке!")
        case .start:
            self.speed = self.maxSpeed
            print("Водитель двигается с максимальной скоростью \(self.maxSpeed) км/ч")
        case .stop:
            self.speed = 0
            print("Водитель остановился")
        case .recharge:
            self.fastenSeatBelt = false
            self.switchDoors = .opened
            self.driverInCar = false
            print("Ремень безопасности отстегнут, двери открыты, водитель покинул автомобиль")
        }
    }
    
    override func description() {
        super.description()
        print("Привод спортивного автомобиля \(self.driveType), время разгона до 100 км/ч составляет \(self.accelerationTime) секунд, максимальная скорость \(self.maxSpeed) км/ч, турбина \(self.turbo ? "установлена": "отсутсвует"), антикрыло \(self.spoiler ? "установлен": "отсутсвует"), размер колес в дюймах: \(self.tyreInch), обвес автомобиля: \(self.botyKit)")
    }
}

class trunkCar: Car{
    enum truckClasses {
        case class1, class2, class3, class4, class5, class6, class7, class8
        var description: ClosedRange <Float>{
            switch self {
            case .class1: return (0...2722)
            case .class2: return (2723...4536)
            case .class3: return (4537...6350)
            case .class4: return (6351...7257)
            case .class5: return (7258...8845)
            case .class6: return (8846...11793)
            case .class7: return (11794...14969)
            case .class8: return (14970...100000)
            }
        }
    }
    
    
    
    enum bodyType{ case light, medium, heavy }
    
    var trunkClass: truckClasses
    var trunkMaxCapacity: Int
    var trunkCapacity: Int
    var powerOfTheTruck: Int
    var bodyType: bodyType
    
    static var countOfTrunkCars: Int = 0
    
    init(brand: String, model:String, color:colors, productionYear: Int, seats: Int, trunkClass: truckClasses, bodyType:bodyType, powerOfTheTruck: Int){
        
        self.trunkClass = trunkClass
        self.bodyType = bodyType
        self.trunkMaxCapacity = Int(trunkClass.description.upperBound)
        self.trunkCapacity = trunkMaxCapacity
        self.powerOfTheTruck = powerOfTheTruck
        
        super.init(brand: brand, model: model, color:color, productionYear:productionYear,seats:seats)
        
        trunkCar.countOfTrunkCars += 1
        print("Добавлен грузовик")
    }
    
    deinit {
        sportCar.countOfCars -= 1
        print("Удален грузовик")
    }
    
    override func action(action:action) {
        switch action {
        case .prepare:
                print("Грузовик загружен на \(self.trunkCapacity) кг")
        case .start:
            print("Грузовик отправился к точке разгрузки")
        case.stop:
            print("Грузовик добрался до точки разгрузки и остановился.")
        case.recharge:
            print("Грузовик разгрузил груз на \(self.trunkCapacity) кг")
        }
    }
    
    override func description() {
        super.description()
        print("Максимальная грузоподъемность составляет: \(self.trunkMaxCapacity) кг, мощность грузовика составляет: \(self.powerOfTheTruck) тип грузовика \(self.bodyType)")
    }
}
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
var nismo = sportCar(brand: "Nissan", model: "GTR", color: .white, productionYear: 2017, seats: 2, driveType: .AWD, accelerationTime: 2.4, maxSpeed: 240, bodyKit: .raceKit, engineTuning: .stageThree, turbo: true, spoiler: false, tyreInch: 29)

var volvo = trunkCar(brand: "Volvo", model: "FMX", color: .green, productionYear: 2018, seats: 3, trunkClass: .class6, bodyType: .heavy, powerOfTheTruck: 890)

//6. Вывести значения свойств экземпляров в консоль.
nismo.description()
nismo.action(action: .prepare)
nismo.action(action: .start)
nismo.action(action: .stop)

volvo.description()
volvo.action(action: .prepare)
volvo.action(action: .start)
volvo.action(action: .stop)
volvo.action(action: .recharge)
