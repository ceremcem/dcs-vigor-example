require! 'dcs': {DcsTcpClient, IoProxyClient, sleep}
require! './config': {dcs-port}

credentials =
    user: 'test-user'
    password: "1234"
client = new DcsTcpClient port: dcs-port
    ..login credentials

io = {}
for let <[ red green beep a1 a2 a3 ]>
    io[..] = new IoProxyClient do
        timeout: 500ms
        route: "@sgw.#{..}"
        fps: 12fps
        #debug: true

    io[..].on \read, (value) ->
        console.log "state changed for #{..}: ", value

<~ client.on \logged-in
#<~ sleep 1000ms
period = 1000ms
do ~>
    val = true
    <~ :lo(op) ~>
        console.log "setting green: #{val}"
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
        console.log "setting red: #{val}"
        err <~ io.red.write val
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
