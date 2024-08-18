# spi

Very simple SPI layer.

`static func startMaster(speed: UInt8, mode: UInt8, lsb: Bool)`

Switches the SPI pins MISO, MOSI, SCK to SPI mode, overriding alternate functions.

`static func stop()`

Disables SPI and restores alternate pin functions for the SPI pins MISO, MOSI, SCK.

`static func sendByte(_ byte: UInt8) -> UInt8 `

Send (and receive) one byte. To send a buffer use something like...

```
let myBufferSize: Int = 20

if let myBuffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: myBufferSize) {

    ATmega328P.Spi.startMaster(speed: 0, mode: 0, lsb: false)
                
    myBuffer[0] = 1
    myBuffer[1] = 0
    myBuffer[2] = 128
    myBuffer[3] = 91

    for byte in myBuffer {
        ATmega328P.Spi.sendByte(byte)
    }
}
```
