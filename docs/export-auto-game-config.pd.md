#### Export auto config
Looks like game actions are defined in 
lutris/game\_actions.py which calls into 
lutris/game.py

They are visible based on props from the db


### Bugs
Looks like the keyword is *service game* ie. <id> from <service> invoked by `-i` or GUI. At the momen
t, it seems this call is bypassed by extends?

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

simple install

only by slug, not by path


> break here
get\_installers(), gui/installerwindow.on\_installer\_selected()
interpreter.ScriptInterpreter.\_check\_dependency()
	raise MissingGameDependency(slug=dependency)

What should happen? Extends needs to either: handle local installers or lookup service installers.

GOG
whatever comes from the app can also be gotten through 'view file' during the install routine.
service:
	lutris/services/base.py into e.g. lutris/services/gog.py

installer.save() is called by script interpreted & dir scanner

 interpreter.\_iter\_commands()
						.\_finish\_install()

launch\_install > install\_runners > launch\_installer commands > iter\_commands > finish\_install
													- self.installer.save()

config explicitly doesn't get writting in the case of `extends`


#### Context
discord search:
`in: lutris_support in: writing_installers requires extends`
https://discord.com/channels/512538904872747018/546612632027922452/831109393407410176
https://discord.com/channels/512538904872747018/546612632027922452/635247921050288129
https://discord.com/channels/512538904872747018/546612632027922452/636132541459333121
https://discord.com/channels/512538904872747018/546612632027922452/829371262454464524

`extends`: 2016, https://github.com/lutris/lutris/compare/v0.4.1...v0.4.2
  https://github.com/lutris/lutris/commit/61bdf56
	https://github.com/lutris/lutris/issues/390
	https://github.com/lutris/lutris/issues/2839
https://discord.com/channels/512538904872747018/546612632027922452/706367368359837716
https://discord.com/channels/512538904872747018/538903130704838656/818343688861777972


`requires`: 2013
  https://github.com/lutris/lutris/compare/282ac32...928bc5a
  https://github.com/lutris/lutris/releases/tag/v0.3.2

	https://github.com/lutris/lutris/issues/2835




