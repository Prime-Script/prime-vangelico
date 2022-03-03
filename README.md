# Vangelico Heist For QBCore

# Disclaimer

- I have removed the police alert! Therefore you will have to add your own, I won't be offering support on this section.

# Requirements
- QB-Framework: https://github.com/qbcore-framework/qb-core

- PolyZone: https://github.com/qbcore-framework/PolyZone

- QB-Target: https://github.com/BerkieBb/qb-target

- Thermite Minigame: This will be located in the folder assets

- Laptop Minigame: This will be located in the folder assets

# Future Updates

- Adding Translations to the progressbar

- Adding More Dispatch Systems (Will be adding Core, CDD and ERP_MDT when released)

# Installation

- Create a file inside nui_doorlock / config, and add this inside the file (this will ensure the door is locked)
```
Config.DoorList['vangelicodoor'] = {
	authorizedJobs = { ['police']=0 }, -- ['ambulance']=0, ['bcso']=0
	lockpick = false,
	doors = {
		{objHash = 1425919976, objHeading = 306.00003051758, objCoords = vec3(-631.955384, -236.333268, 38.206532)},
		{objHash = 9467943, objHeading = 306.00003051758, objCoords = vec3(-630.426514, -238.437546, 38.206532)}
    },
	audioRemote = false,
	locked = true,
	slides = false,
	maxDistance = 2.5,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000
}
```

- Add this item to qb-core / shared / items.lua

```
["usb_green"] 		 	     	 = {["name"] = "usb_green", 					["label"] = "Green USB", 				["weight"] = 5000, 	    ["type"] = "item", 		["image"] = "usb_green.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "What is this USB used for?"},
```

- Add usb_green to inventory / html / images

This will be located in the folder assets

# Locales System

- English, Turkish, French

Other Languages Coming Soon!

[Discord](https://discord.gg/Z3mHA3eez9) | [Tebex](https://prime-scripts.tebex.io/)

# License

This script provided by Prime Scripts, is under the protection of [Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
