runos docker image
==================

runosdev
--------

A script which helps to start container properly. Just copy it to /usr/local/bin,
then run

```
$ runosdev
```

Features:

  * Uses your current directory with sources;
  * Local user (no more chown-ing!);
  * Port forwarding by default (web interface on localhost:8000 will work);
  * Everything is ready to compile;
  * OVS 2.8.1
  * mininet 2.2.1
  * tmux


Build image
-----------

```
$ docker build -t runos .
```

