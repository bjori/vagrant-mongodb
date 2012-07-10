class mongodb {
    package { "python-software-properties":
        ensure => installed,
    }

    exec { "apt-repo-10gen":
        path => "/bin:/usr/bin",
        command => "add-apt-repository 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'",
        unless => "cat /etc/apt/sources.list | grep 10gen | grep downloads-distro",
        require => Package["python-software-properties"],
    }

    exec { "apt-key-10gen":
        path => "/bin:/usr/bin",
        command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
        unless => "apt-key list | grep 10gen",
        require => Exec["apt-repo-10gen"],
    }

    exec { "update-apt":
        path => "/bin:/usr/bin",
        command => "apt-get update",
        require => Exec["apt-key-10gen"],
    }

    package { "mongodb-10gen":
        ensure => installed,
        require => Exec["update-apt"],
    }

    service { "mongodb":
        enable => true,
        ensure => running,
        require => File['/etc/mongodb.key'],
    }

}

