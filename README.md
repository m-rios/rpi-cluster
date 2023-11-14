# My Homelab Raspberry Pi Cluster

:warning: :construction: This documentation and the configuration it describes
is still very much a WIP. Use it at your own risk

This repository contains all the configuration i use to provision, deploy and
maintain my raspberry pi cluster. I use ansible to provision the raspberry pi
nodes, and nomad to orchestrate the applications.

## Makefile Reference

| command   | description                      |
| --------- | -------------------------------- |
| fmt       | format files using prettier      |
| bootstrap | create a bootable sd card        |
| nomad     | apply the ansible nomad playbook |

## Repository Structure

```
.
+-- ansible // root of ansible config to setup live raspberry pi instances
+-- bootstrap // utilities to create a bootable raspberry pi sd card with some
    |            basic configuration
    +-- bin // scripts to run the bootstrap process
    +-- boot // set of raspberry pi boot config files, e.g. to enable ssh and
                configure WiFi
```

## Deployment Diagram

## Getting Started

### Hard Dependencies

The bare minimum dependencies to run the automations in this repository are:

1. Unix-like system. All automations have been tested on Ubuntu and MacOS, other
   operating systems or distributions might not be compatible
2. ansible

### Soft Dependencies

Additionally, in order to execute some other actions you might need:

1. yarn (used for book-keeping tasks like formatting the files using prettier)

### Create a bootable sd card

Before being able to provision a raspberrypi node, you must create a bootable sd
card and setup the network configuration. To do this, insert the sd card and
take note of its path. Copy `bootstrap/.env.example` to `bootstrap/.env` and customize
the values to your needs. The wifi fields can be removed if you're planning on using ethernet.
Finally, once all parameters have been defined simply call:

```bash
make bootstrap
```

You will need to repeat this process for each node you want to provision.
