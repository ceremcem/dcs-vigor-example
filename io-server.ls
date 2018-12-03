require! 'dcs': {DcsTcpClient, IoProxyHandler}
require! 'dcs/drivers/rpi': {RpiGPIODriver, RpiGPIODriverSimulator}
require! './config': {digital-io, namespace, dcs-port}

credentials =
    user: 'sgw'
    password: "1234"

new DcsTcpClient port: dcs-port .login credentials

handles =
    out:
        'red': 0
        'green': 7
        'beep': 11

driver = new RpiGPIODriverSimulator
for dir, pin of handles
    for name, num of pin
        # See the RpiGPIODriver for handle format
        handle =
            name: name
            gpio: num
            out: dir is \out
        new IoProxyHandler handle, "@sgw.#{handle.name}", driver
