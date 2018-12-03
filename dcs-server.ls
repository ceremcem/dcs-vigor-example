require! 'dcs/services/dcs-proxy/tcp/server': {AuthDB, DcsTcpServer}
require! './config': {dcs-port}

# Create auth db
db = new AuthDB (require './users')
# use ..update(users) to add more users in the runtime

# Create a TCP DCS Service
new DcsTcpServer {port: dcs-port, db}
