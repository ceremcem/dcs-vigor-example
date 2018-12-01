require! os
export dcs-port = 4039
export node-name = "#{os.hostname!}"
export namespace = "io.#{node-name}"
export digital-io = 
    inputs:
        "test-input1": 24
        "test-input2": 23

    outputs: 
        "test-output1": 0

