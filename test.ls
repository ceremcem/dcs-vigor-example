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
        timeout: 500ms
        route: "@sgw.#{..}"
        fps: 12fps
        #debug: true

<~ client.on \logged-in
# toggle led
period = 200ms
do ~>
    val = true
    <~ :lo(op) ~>
        err <~ io.red.write val
        if err
            console.log "error...", err
        else
            val := not val
        <~ sleep period
        lo(op)

do ~>
    val = true
    <~ :lo(op) ~>
        err <~ io.green.write val
        if err
            console.log "error...", err
        else
            val := not val
        <~ sleep period
        lo(op)

do ~>
    val = true
    <~ :lo(op) ~>
        err <~ io.beep.write val
        if err
            console.log "error...", err
        else
            val := not val
        <~ sleep period
        lo(op)

io.red.on \error, (err) ~>
    console.warn "We have an error: ", err

io.red.on \read, (value) ~>
    console.log "We got the value:", value
