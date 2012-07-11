Vagrant plugin and puppet manifests for MongoDB
===============================================

Creates (by default) 8 virtual machines based on Ubuntu Lucid (64bits).

* 1x ReplicaSet (primary, secondary, arbiter) without authentication.
* 1x ReplicaSet (primary, secondary, arbiter) wit authentication.
* 1x Standalone server without authentication.
* 1x Standalone server with authentication.

The ReplicaSet servers will have their _/etc/hosts_ synchronized among them.

All servers will retrieve and install the latest MongoDB from the official 10gen repository.

Several new Vagrant configurations are available in the _Vagrantfile_
to configure a MongoDB replicaset, such as the servers priority.

A new Vagrant comand is availalbe to initialize the replicaset based on
the configuration in the _Vagrantfile_, and to create users for authenticated setup.


Usage
-----
    $ git clone https://github.com/bjori/vagrant-mongodb-replicaset.git
    $ cd vagrant-mongodb-replicaset
    $ vagrant up # Will bootup *all 8 servers*

Or only bootup the things you want to run

    $ vagrant up primary secondary tertiary # Will bootup only one ReplicaSet
    $ vagrant up primaryauth secondaryauth tertiaryauth # RS with auth
    $ vagrant up standalone # Will bootup the standalone server
    $ vagrant up standaloneauth # Standalone with auth

Initializing ReplicaSets
------------------------
To initialize the ReplicaSet for the first time, type

    $ vagrant mongo primary --init-replicaset

and/or

    $ vagrant mongo primaryauth --init-replicaset

To initialize the ReplicaSet for the authenticated environment.

Creating users
--------------

To create a first time admin user on a standalone server run

    $ vagrant mongo standaloneauth -c -u adm -p pass --db admin

or for ReplicaSet environment

    $ vagrant mongo primaryauth -c -u adm -p pass --db admin

To create more users you have to authenticate using that admin user

    $ vagrant mongo standaloneauth -c -u user -p mypass --db mydb --authuser adm --authpass pass --authdb admin


/etc/hosts
----------

The ReplicaSets are configured using the hostnames defined in the _Vagrantfile_.
I recommend you add all these hosts to your local _/etc/hosts_ (the servers themselves already have).

By default the following hostnames and IPs are used

    172.16.1.10 primaryauth.rs.local primaryauth
    172.16.1.11 secondaryauth.rs.local secondaryauth
    172.16.1.12 tertiaryauth.rs.local tertiaryauth
    172.16.2.10 standaloneauth.local standaloneauth

    172.16.3.10 primary.rs.local primary
    172.16.3.11 secondary.rs.local secondary
    172.16.3.12 tertiary.rs.local tertiary
    172.16.4.10 standalone.local standalone


Thats it folks!
---------------
And there we go!
Now you have a full MongoDB replicaset running in its own virtualized network,
and all of the servers are running on the default ports.
To connect to MongoDB, just fire up your favorite driver and connect :)


Fixing my mess?
---------------
This is the first time I have ever created a puppet module, puppet manifest, vagrant plugin
or written Ruby code at all.
There is very likely something could have been done better or prettier.
I would love it if you forked this repo and applied your skillz cleaning things up.

Everything should work out of the box though :)

TODO
----
* MongoDB Sharded environment
* mongobride support
  * _vagrant mongo_ command to tune mongobridge
  * Configuration settings
* Split the _vagrant mongo_ command to simplify creating users
* Automatically initialize ReplicaSets when all RS vms have booted up


