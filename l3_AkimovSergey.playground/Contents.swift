import UIKit

enum turnWin{   case open,  close   }
enum turnEng{   case on,    off     }
enum loadCargo{ case upload,unload  }
enum menagePas{ case add,   put     }
enum colors{    case red,   orange, yellow, green, blue, purple, black, white, silver   }

//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
struct Car{
    enum carBodyType{ case hatchback, sedan, SUV, Coupe, Convertible, Wagon, Van, Jeep }
    //2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника
    let accelerationTime: Float
    let brand, model: String
    let bodyType: carBodyType
    let color: colors
    let productionYear, seats : Int
    let trunkVolume: Float
    var filledTrunkVolume : Float
    var engineStarted, windowsOpened  : Bool
    var freeSeats : Int
    //3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
    enum carAction{
        case move(meters: Int, speed: Int)
        case stop
        case turnEngine(pos: turnEng)
        case turnWindows(pos: turnWin)
        case manageCargo(act: loadCargo, capacity: Float)
        case managePassengers(act: menagePas, numberOfPassengers: Int)
    }
    
    init(inputBrand: String,
         inputModel: String,
         inputBodyType : carBodyType,
         inputColor: colors,
         inputProductionYear: Int,
         inputSeats: Int,
         inputTrunkVolume: Float,
         inputAccelerationTime: Float){
        
        self.brand = inputBrand
        self.model = inputModel
        self.bodyType = inputBodyType
        self.color = inputColor
        self.productionYear = inputProductionYear
        self.seats = inputSeats
        self.freeSeats = self.seats
        self.trunkVolume = inputTrunkVolume
        self.filledTrunkVolume = 0.0
        self.engineStarted = false
        self.windowsOpened = false
        self.accelerationTime = inputAccelerationTime
    }

//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    mutating func carAction(action : carAction){
       let name = "\(self.brand) \(self.model)"
        switch action{
        case .turnEngine(.on):
            self.engineStarted = true
            print("\(name) engine is on")
        case .turnEngine(.off):
            self.engineStarted = false
            print("\(name) engine is off")
        case .manageCargo(.upload, let capacity):
            if(capacity <= self.trunkVolume - self.filledTrunkVolume){
                self.filledTrunkVolume += capacity
                print("\(name) uploaded \(capacity)")
            }else{
                print("\(name) not enought free space")
            }
         case .manageCargo(.unload, let capacity):
            if(capacity > self.filledTrunkVolume){
                print("\(name) not enouth cargo on board.")
            }else{
                self.filledTrunkVolume -= capacity
                print("\(name) unloaded \(capacity)\n")
                print("\(name) \(self.filledTrunkVolume) baggage in car")
            }
            
        case .move(let meters, let speed):
            if(self.engineStarted){
                print("\(name) engine is on")
                print("\(name) car moved on \(meters) by \(speed)")
            }else{
                print("\(name) you need start engine first!")
            }
        
        case .turnWindows(.open):
            self.windowsOpened = true
            print("\(name) windows opened")
          case .turnWindows(.close):
            self.windowsOpened = false
            print("\(name) windows closed")
        case .managePassengers(.add, let numberOfPassengers):
            if(numberOfPassengers <= self.freeSeats){
                self.freeSeats -= numberOfPassengers
                print("\(name) car edded \(numberOfPassengers) passengers")
            }else{
                print("\(name) not enouth seats for passengers")
            }
        case .managePassengers(.put, let numberOfPassengers):
            if(numberOfPassengers <= (self.seats - self.freeSeats)){
                self.freeSeats += numberOfPassengers
                print("\(name) go out of the car: \(numberOfPassengers) passengers")
            }else{
                print("\(name) passengers in the car less than the specified")
            }
        case .stop:
            print("\(name) car stopped")
        }
    }
    
    func description(){
        print("""
Car Brand: \(self.brand) Model: \(self.model)
Body type: \(self.bodyType) Color: \(self.color) Production year: \(self.productionYear)
Seats: \(self.seats) Passangers in car: \(self.seats-self.freeSeats)
Windows are \(self.windowsOpened ? "opened" : "closed"). Engine is \(self.engineStarted ? "on": "off").
Trunk volume: \(self.trunkVolume) Filled trunk volume: \(self.filledTrunkVolume)\n
""")
    }
}

struct Truck{
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
    
        let brand, model: String
        let truckClass: truckClasses
        let color: colors
        let productionYear, seats : Int
        let trunkVolume : Float
        var filledTrunkVolume : Float
        var engineStarted, windowsOpened  : Bool
        var freeSeats : Int
    
        enum truckAction{
            case move(meters: Int, speed: Int)
            case stop
            case turnEngine(pos: turnEng)
            case turnWindows(pos: turnWin)
            case manageCargo(act: loadCargo, capacity: Float)
            case managePassengers(act: menagePas, numberOfPassengers: Int)
        }
    
        init(inputBrand: String,
             inputModel: String,
             inputTruckClass : truckClasses,
             inputColor: colors,
             inputProductionYear: Int,
             inputSeats: Int){
            
            self.brand = inputBrand
            self.model = inputModel
            self.truckClass = inputTruckClass
            self.color = inputColor
            self.productionYear = inputProductionYear
            self.seats = inputSeats
            self.freeSeats = self.seats
            self.trunkVolume = self.truckClass.description.upperBound
            self.filledTrunkVolume = 0.0
            self.engineStarted = false
            self.windowsOpened = false
        }
        
        mutating func truckAction(action : truckAction){
            
            let name = "\(self.brand) \(self.model)"
            
            switch action {
            case .turnEngine(.on):
                self.engineStarted = true
                print("\(name) Engine is on")
             case .turnEngine(.off):
                self.engineStarted = false
                print("\(name) Engine is off")
            case  .manageCargo(.upload, let capacity):
                if(capacity <= self.trunkVolume - self.filledTrunkVolume){
                    self.filledTrunkVolume += capacity
                    print("\(name) uploaded \(capacity)")
                }else{
                    print("\(name) not enought free space")
                }
            case .manageCargo(.unload, let capacity):
                if(capacity > self.filledTrunkVolume){
                    print("\(name) Not enouth cargo on board. Please try again")
                }else{
                    self.filledTrunkVolume -= capacity
                    print("\(name) unloaded \(capacity)")
                    print("\(name) \(self.filledTrunkVolume) baggage in car")
                }
                
            case .move(let meters, let speed):
                if(self.engineStarted){
                    print("\(name) engine is on")
                    print("\(name) truck moved on \(meters) by \(speed)")
                }else{
                    print("\(name) you need start engine first!")
                }
            case .stop:
                print("\(name) truck stopped")
            case .turnWindows(.open):
                self.windowsOpened = true
                print("\(name) windows opened")
            case .turnWindows(.close):
                self.windowsOpened = false
                print("\(name) windows closed")
            case .managePassengers(.add, let numberOfPassengers):
                if(numberOfPassengers <= self.freeSeats){
                    self.freeSeats -= numberOfPassengers
                    print("\(name) truck added \(numberOfPassengers) passengers")
                }else{
                    print("\(name) not enouth seats for passengers")
                }
            case .managePassengers(.put, let numberOfPassengers):
                if(numberOfPassengers <= (self.seats - self.freeSeats)){
                    self.freeSeats += numberOfPassengers
                    print("\(name) go out of the truck: \(numberOfPassengers) passengers")
                }else{
                    print("\(name) Passengers in the car less than the specified")
                }
            }
        }
        
        func description(){
            print("""
                Truck Brand: \(self.brand) Model: \(self.model)
                Body type: \(self.truckClass) Color: \(self.color) Production year: \(self.productionYear)
                Seats: \(self.seats) Passangers in car: \(self.seats-self.freeSeats)
                Windows are \(self.windowsOpened ? "opened" : "closed"). Engine is \(self.engineStarted ? "on": "off").
                Trunk volume: \(self.trunkVolume) Filled trunk volume: \(self.filledTrunkVolume)\n
                """)
        }
    }
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
        var workCar =   Car(inputBrand: "Honda",
                            inputModel: "Civic",
                            inputBodyType: .hatchback,
                            inputColor: .purple,
                            inputProductionYear: 2016,
                            inputSeats: 5,
                            inputTrunkVolume: 450,
                            inputAccelerationTime: 7.8)

        var sportCar =  Car(inputBrand: "Porshe",
                            inputModel: "911 Turbo",
                            inputBodyType: .Coupe,
                            inputColor: .silver,
                            inputProductionYear: 2019,
                            inputSeats: 2,
                            inputTrunkVolume: 210,
                            inputAccelerationTime: 3.8)

  var magazineTruck = Truck(inputBrand: "Hyndai",
                            inputModel: "HD200",
                            inputTruckClass: .class1,
                            inputColor: .white,
                            inputProductionYear: 2007,
                            inputSeats: 3)

   var trailerTruck = Truck(inputBrand: "Volvo",
                            inputModel: "FMX",
                            inputTruckClass: .class6,
                            inputColor: .blue,
                            inputProductionYear: 2017,
                            inputSeats: 3)

let timeAdvantage : Float = (sportCar.accelerationTime - workCar.accelerationTime)
if(timeAdvantage == 0){
    print("Сars finished at the same time")
}else{
    let winner : String = (timeAdvantage < 0) ? "\(sportCar.brand) \(sportCar.model)": "\(workCar.brand) \(workCar.model)"
    print ("\(winner) is faster then opponent for \(abs(timeAdvantage)) seconds\n")
}
workCar.description()
sportCar.description()
magazineTruck.description()
trailerTruck.description()

workCar.carAction(action: .manageCargo(act: .upload, capacity: 340.50))
workCar.carAction(action: .managePassengers(act: .add, numberOfPassengers: 4))
workCar.carAction(action: .turnEngine(pos:.on))
workCar.carAction(action: .move(meters: 2500, speed: 60))
workCar.carAction(action: .stop)
workCar.carAction(action: .turnEngine(pos: .off))
workCar.carAction(action: .managePassengers(act: .put, numberOfPassengers: 3))
workCar.carAction(action: .manageCargo(act: .unload, capacity: 240.50))

sportCar.carAction(action: .manageCargo(act: .upload, capacity: 48.70))
sportCar.carAction(action: .managePassengers(act: .add, numberOfPassengers: 2))
sportCar.carAction(action: .turnEngine(pos:.on))
sportCar.carAction(action: .turnWindows(pos: .open))
sportCar.carAction(action: .move(meters: 7500, speed: 100))
sportCar.carAction(action: .stop)
sportCar.carAction(action: .turnWindows(pos: .close))
sportCar.carAction(action: .turnEngine(pos: .off))
sportCar.carAction(action: .managePassengers(act: .put, numberOfPassengers: 1))
sportCar.carAction(action: .manageCargo(act: .unload, capacity: 20.70))

magazineTruck.truckAction(action: .manageCargo(act: .upload, capacity: 2552.50))
magazineTruck.truckAction(action: .managePassengers(act: .add, numberOfPassengers: 2))
magazineTruck.truckAction(action: .turnEngine(pos:.on))
magazineTruck.truckAction(action: .move(meters: 1800, speed: 50))
magazineTruck.truckAction(action: .stop)
magazineTruck.truckAction(action: .turnEngine(pos: .off))
magazineTruck.truckAction(action: .managePassengers(act: .put, numberOfPassengers: 1))
magazineTruck.truckAction(action: .manageCargo(act: .unload, capacity: 1552.50))

trailerTruck.truckAction(action: .manageCargo(act: .upload, capacity: 10250.90))
trailerTruck.truckAction(action: .managePassengers(act: .add, numberOfPassengers: 3))
trailerTruck.truckAction(action: .turnEngine(pos: .on))
trailerTruck.truckAction(action: .turnWindows(pos: .open))
trailerTruck.truckAction(action: .move(meters: 15000, speed: 80))
trailerTruck.truckAction(action: .stop)
trailerTruck.truckAction(action: .turnWindows(pos: .close))
trailerTruck.truckAction(action: .turnEngine(pos: .off))
trailerTruck.truckAction(action: .managePassengers(act: .put, numberOfPassengers: 1))
trailerTruck.truckAction(action: .manageCargo(act: .unload, capacity: 2552.50))

//6. Вывести значения свойств экземпляров в консоль.
workCar.description()
sportCar.description()
magazineTruck.description()
trailerTruck.description()
