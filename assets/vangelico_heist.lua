-- This will add the lock to the vangelico doors, DO NOT CHANGE Config.DoorList['doubledoor'] AS THIS WILL BREAK THE SCRIPT!

Config.DoorList['doubledoor'] = {
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