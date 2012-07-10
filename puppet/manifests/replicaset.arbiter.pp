include mongodb
mongodb::replicaset { 'RS':
    arbiter => 'true',
}

host { 'primary.rs.local':
    ensure => 'present',
    target => '/etc/hosts',
    ip => '172.16.1.10',
    host_aliases => ['primary.rs.local', 'primary']
}

host { 'secondary.rs.local':
    ensure => 'present',
    target => '/etc/hosts',
    ip => '172.16.1.11',
    host_aliases => ['secondary.rs.local', 'secondary']
}

host { 'tertiary.rs.local':
    ensure => 'present',
    target => '/etc/hosts',
    ip => '172.16.1.12',
    host_aliases => ['tertiary.rs.local', 'tertiary']
}

