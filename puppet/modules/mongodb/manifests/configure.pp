define mongodb::configure (
    $replicaset    = $title,
    $arbiter    = 'false',
    $useauth    = 'false',
    $rest       = '',
    $prealloc = '',
    $journal  = '',
    $port       = '27017',
    $rest       = false,
) {

    include mongodb

    if ($arbiter == 'true') {
        if ($journal == '') {
            $nojournal = 'true'
        }
        if ($noprealloc == '') {
            $noprealloc = 'true'
        }
    } else {
        if ($journal == '') {
            $nojournal = 'false'
        }
        if ($prealloc == '') {
            $noprealloc = 'false'
        }
    }

    if ($useauth == 'false'){
        $auth = 'false'
        if ($replicaset) {
            $replSet = $replicaset
        } else {
            $replSet = false
        }
    } else {
        $auth = 'true'
        if ($replicaset) {
            $replSet = $replicaset
            $keyFile = "/etc/mongodb.key"
        } else {
            $replSet = false
        }
    }

    file { '/etc/mongodb.key':
        content => template('mongodb/mongodb.key.erb'),
        mode => '0600',
        owner => 'mongodb',
        notify => Service['mongodb'],
        require => File['/etc/mongodb.conf'],
    }
    file { '/etc/mongodb.conf':
        content => template('mongodb/mongodb.conf.erb'),
        mode => '0644',
        notify => Service['mongodb'],
        require => File['/etc/default/mongodb'],
    }
    file { '/etc/default/mongodb':
        content => template('mongodb/mongodb.upstart.default.erb'),
        mode => '0644',
        notify => Service['mongodb'],
        require => File['/etc/init/mongodb.conf'],
    }
    file { '/etc/init/mongodb.conf':
        content => template('mongodb/mongodb.upstart.conf.erb'),
        mode => '0644',
        notify => Service['mongodb'],
        require => Package['mongodb-10gen'],
    }
}

