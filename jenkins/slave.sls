{% from "jenkins-formula/jenkins/map.jinja" import jenkins with context %}
{% set slave_name = salt['grains.get']('host') %}

jenkins_group:
  group.present:
    - name: {{ jenkins.group }}
    - system: True

jenkins_user:
  file.directory:
    - name: {{ jenkins.home }}
    - user: {{ jenkins.user }}
    - group: {{ jenkins.group }}
    - mode: 0755
    - require:
      - user: jenkins_user
      - group: jenkins_group
  user.present:
    - name: {{ jenkins.user }}
    - groups:
      - {{ jenkins.group }}
    - system: True
    - home: {{ jenkins.home }}
    - shell: /bin/bash
    - require:
      - group: jenkins_group

default-jre:
  pkg.installed

default-jdk:
  pkg.installed

/opt/swarm-client.jar:
  file.managed:
    - source: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.2/swarm-client-2.2-jar-with-dependencies.jar
    - source_hash: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/2.2/swarm-client-2.2-jar-with-dependencies.jar.sha1

/etc/init.d/swarm:
  file.managed:
    - source: salt://jenkins-formula/jenkins/files/swarm_service
    - mode: 755
    - template: jinja
    - default:
      slave_name: {{ slave_name }}

vnc4server:
  pkg.installed

expect:
  pkg.installed

vnc_directory:
  file.directory:
    - name: {{ jenkins.home }}/.vnc
    - user: {{ jenkins.user }}
    - group: {{ jenkins.group }}
    - mode: 0755
    - require:
      - user: jenkins_user
      - group: jenkins_group

swarm:
  service.running


