require! 'dcs/src/auth-helpers': {hash-passwd}
export do
    'test-user':
        passwd-hash: hash-passwd "1234"
        routes:
            \@sgw.**

    'sgw':
        passwd-hash: hash-passwd "1234"
