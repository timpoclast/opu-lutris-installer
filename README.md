### Overview

A Lutris installer of the [Outpost
Universe](https://www.outpost2.net/outpost2.html) unofficial update for
[Outpost 2](https://lutris.net/games/outpost-2-divided-destiny/).
Written using the Lutris [Writing
installers](https://github.com/lutris/lutris/blob/master/docs/installers.rst)
docs.

### Issues

Looks like the keyword is *service game* ie. <id> from <service> invoked
by `-i` or GUI. At the moment, it seems this call is bypassed by
extends?

3 methods of install:

cli: [lutris](https://github.com/lutris/lutris/blob/master/bin/lutris)
-i,  
[lutris.gui.application.do_command_line()](https://github.com/lutris/lutris/blob/7b90acbcf2b255fd9ac82ae46d38735cbcdcc632/lutris/gui/application.py#L392)

    file: 

    uri: 

app: click picture in gui inheritance: `extends` or `requires` from
other installer.

for early install, a bunch of properties are set e.g. “install”,
“service”

## Issues
`extends` doesn't work with auto installers.
`requires` blocks modification of the `game` section.

It isn't currently possible to update the `game` portion of 

i.e.
Goal: Create installer for the GoG release of Outpost 2: Divided Destiny.

Current work around: Wrapper script which currently:
    * calls installer
    * replaces 

Issue: 

To comply with EULA/TOU, a community patch for Outpost 2: Divided Destiny, called OPU (OutPost Universe) is activated by callng the main executable with an arg. 

Still investigating but it looks like calling other installers
(`extends`/`requires`) may only work for [conventional
installers](https://github.com/lutris/lutris/blob/5564cd803acb23beaf146a39189d2388425cca10/lutris/api.py#L162)
and not automatic ones (steam/gog). a work around maybe to call lutris
from an `execute` directive with the `lutris:` link.

[gog installers are generated in
memory](https://github.com/lutris/lutris/blob/7b90acbcf2b255fd9ac82ae46d38735cbcdcc632/lutris/services/gog.py#L510)

### Usage

`lutris -i opu-min-installer.yml`

test with `lutris; lutris -i opu-min-installer.yml`

### To do

- check if there is a `latest` link for OPU installer.
- bake off `extends` and `requires`
