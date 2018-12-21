require! 'dcs': {DcsTcpClient, IoProxyHandler}
require! 'dcs/drivers/vigor': {VigorDriver}
require! './config': {digital-io, namespace, dcs-port}

credentials =
    user: 'sgw'
    password: "1234"

new DcsTcpClient port: dcs-port .login credentials

handles =
    out:
        'red': "y0.2"
        'green': "y0.3"
        'beep': "y0.4"
    in:
        "a1": "x0.0"
        "a2": "x0.1"
        "a3": "x0.2"

driver = new VigorDriver
for dir, pin of handles
    for name, addr of pin
        # See the VigorDriver for handle format
        console.log "...initializing #{name} (#{addr})"
        handle =
            name: name
            addr: addr
            type: "bool"
            out: dir is \out
        new IoProxyHandler handle, "@sgw.#{handle.name}", driver
