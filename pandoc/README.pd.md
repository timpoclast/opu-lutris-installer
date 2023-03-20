% OPU Lutris Installer README 

### Overview
A Lutris installer of the [Outpost Universe](https://www.outpost2.net/outpost2.html) unofficial update for [Outpost 2](https://lutris.net/games/outpost-2-divided-destiny/). Written using the Lutris [Writing installers](https://github.com/lutris/lutris/blob/master/docs/installers.rst) docs.

### Related issues
https://github.com/lutris/lutris/issues

2446, 2037, 3703

https://discord.com/channels/512538904872747018/538903130704838656/818346384544497675

https://forums.lutris.net/search?expanded=true&q=%22extends%22

### Bugs
Looks like the keyword is *service game* ie. <id> from <service> invoked by `-i` or GUI. At the moment, it seems this call is bypassed by extends?

3 methods of install: 

cli: [lutris](https://github.com/lutris/lutris/blob/master/bin/lutris) -i,  
	[lutris.gui.application.do\_command\_line()](https://github.com/lutris/lutris/blob/7b90acbcf2b255fd9ac82ae46d38735cbcdcc632/lutris/gui/application.py#L392)
	
	file: 
	
	uri: 

  app: click picture in gui
inheritance: `extends` or `requires` from other installer.

for early install, a bunch of properties are set e.g. "install", "service"

Still investigating but it looks like calling other installers (`extends`/`requires`) may only work for [conventional installers](https://github.com/lutris/lutris/blob/5564cd803acb23beaf146a39189d2388425cca10/lutris/api.py#L162) and not automatic ones (steam/gog). a work around maybe to call lutris from an `execute` directive with the `lutris:` link.

[gog installers are generated in memory](https://github.com/lutris/lutris/blob/7b90acbcf2b255fd9ac82ae46d38735cbcdcc632/lutris/services/gog.py#L510)

### Usage
`lutris -i opu-min-installer.yml`

test with
`lutris; lutris -i opu-min-installer.yml`

### To do
* check if there is a `latest` link for OPU installer.
* bake off `extends` and `requires`

