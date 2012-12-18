include mongodb
exec { "apt-update":
    command => "apt-get update",
    path => "/usr/bin"
}
mongodb::configure { $::rs_name:
    arbiter => $::rs_arbiter,
    useauth => $::mongo_auth,
    #rest => true
}

include hosts::generated

