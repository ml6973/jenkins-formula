jenkins
=======

Install/Setup SaltStack
=======================

Run saltstack installation

.. code-block::

    $ sudo add-apt-repository ppa:saltstack/salt
    
    $ sudo apt-get update
    
    $ apt-get install salt-api salt-cloud salt-master salt-minion salt-ssh salt-syndic
    
    $ mkdir /srv/salt
    
    $ mkdir /srv/pillar

Create /srv/salt/top.sls

.. code-block:: yaml

    base:
      '\*jenkins*':
      \- jenkins-formula.jenkins

Create /srv/pillar/top.sls

.. code-block:: yaml

    base:
      '\*jenkins*':
        \- jenkins
    
put jenkins pillars into /srv/pillar/jenkins.sls
    

Available states
================

.. contents::
    :local:

``jenkins``
-----------

Install jenkins from the source package repositories and start it up.

``jenkins.nginx``
-----------------

Add a jenkins nginx entry. It depends on the nginx formula being installed and
requires manual inclusion `nginx` and `jenkins` states in your `top.sls` to
function, in this order: `jenkins`, `nginx`, `jenkins.nginx`.

Pillar customizations:
==========================

.. code-block:: yaml

    jenkins:
      lookup:
        port: 80
        home: /usr/local/jenkins
        user: jenkins
        group: www-data
        server_name: ci.example.com
