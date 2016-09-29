include:
  - jenkins
  - jenkins.cli

{% from "jenkins-formula/jenkins/map.jinja" import jenkins with context %}

python-pip:
  pkg.installed

jenkins-job-builder:
  pip.installed:
    - require:
      - pkg: python-pip


  
