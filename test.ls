require! 'dcs': {DcsTcpClient, IoProxyClient, sleep}
require! './config': {dcs-port}

credentials =
    user: 'test-user'
    password: "1234"
client = new DcsTcpClient port: dcs-port
    ..login credentials

io = {}
for <[ red green beep ]>
    io[..] = new IoProxyClient do
        timeout: 1000ms
        route: "@sgw.#{..}"
        fps: 12fps
        #debug: true

<~ client.on \logged-in
# toggle led
do
    val = true
    <~ :lo(op) ~>
        err <~ io.red.write val
        if err
            console.log "error..."
        else
            console.log "success"
        val := not val
        <~ sleep 1000ms
        lo(op)

do
    val = true
    <~ :lo(op) ~>
        err <~ io.green.write val
        if err
            console.log "error..."
        else
            console.log "success"
        val := not val
        <~ sleep 1000ms
        lo(op)

do
    val = true
    <~ :lo(op) ~>
        err <~ io.beep.write val
        if err
            console.log "error..."
        else
            console.log "success"
        val := not val
        <~ sleep 1000ms
        lo(op)

io.red.on \error, (err) ~>
    console.warn "We have an error: ", err

io.red.on \read, (value) ~>
    console.log "We got the value:", value
