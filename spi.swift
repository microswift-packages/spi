// spcr bits
let SPIE = 7
let SPE = 6
let DORD = 5
let MSTR = 4
let CPOL = 3
let CPHA = 2
let SPR1 = 1
let SPR0 = 0

// spsr bits
let SPIF = 7
let WCOL = 6
let SPI2X = 0

import HAL

// ^^ imports Spi protocol...
//public protocol Spi {
//    associatedtype Spsr: MutableRegisterValue
//    associatedtype Spcr: MutableRegisterValue
//
//    static var spsr: Spsr  { get set }
//    static var spdr: UInt8 { get set }
//    static var spcr: Spcr  { get set }
//}

public extension Spi where Spcr.RegisterType == UInt8 {
    static func stop() {
    	spcr.registerValue &= ~(1<<SPE)
    }

    static func startMaster(speed: UInt8, mode: UInt8, lsb: Bool) {
        let masterSPCR: UInt8 = (1<<SPE)|(1<<MSTR)|((mode&3)<<CPHA)|((lsb ? 1 : 0)<<DORD)|(speed&3)
        spcr.registerValue = masterSPCR
    }

    // not recommended when already running on maximum speed (speed == 0, clock/4)
    static func setDoubleSpeed(doubleSpeed: Bool) {
    	if doubleSpeed {
    		spsr.registerValue |= (1<<SPI2X)
    	} else {
    		spsr.registerValue &= ~(1<<SPI2X)
    	}
    }

    static func sendByte(_ byte: UInt8) -> UInt8 {
        spdr = byte
        while (spsr.registerValue & (1<<SPIF)) == 0 {}
        return spdr
    }
}