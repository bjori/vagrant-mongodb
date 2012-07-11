include mongodb
mongodb::configure { $::rs_name:
    arbiter => $::rs_arbiter,
    useauth => $::mongo_auth,
    #rest => true
}

include hosts::generated

