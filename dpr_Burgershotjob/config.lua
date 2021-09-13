Config = {
    blip = true, -- Affichage du blip (true = oui, false = non)

    BlipId = 52, -- Id du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipTaille = 0.7, -- Taille du blip
    BlipCouleur = 2, -- Couleur du blip voir: https://wiki.gtanet.work/index.php?title=Blips
    BlipRange = true, -- Garder le blip sur la map (true = désactiver, false = activé)

    MarkerType = 21, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
    MarkerSizeLargeur = 0.7, -- Largeur du marker
    MarkerSizeEpaisseur = 0.7, -- Épaisseur du marker
    MarkerSizeHauteur = 0.7, -- Hauteur du marker
    MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
    MarkerColorR = 252, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorG = 186, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorB = 3, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)
    MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
    MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)

    TextCoffre = "Appuyez sur ~o~[E] ~s~pour accèder au ~o~coffre ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 
    TextCuisine = "Appuyez sur ~o~[E] ~s~pour ~o~cuisiner ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 
    TextStock = "Appuyez sur ~o~[E] ~s~pour pour accèder au ~o~stock ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 
    TextBoisson = "Appuyez sur ~o~[E] ~s~pour pour accèder au ~o~boisson ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 
    TextBoss = "Appuyez sur ~o~[E] ~s~pour pour accèder au ~o~action patron ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 
    TextGarage = "Appuyez sur ~o~[E] ~s~pour accèder au ~o~garage ~s~!", -- Text écris lors de l'approche du blip voir: https://discord.gg/dkHFBkBBPZ Channel couleur pour changer la couleur du texte 

    Preparation = {
        {Nom = "Cheese Burger", ItemRequis = "bread", ItemCuisiner = "cheeseburger"},
        {Nom = "Nuggets", ItemRequis = "nuggetscru", ItemCuisiner = "nuggets"},
        {Nom = "Frite", ItemRequis = "fritecru", ItemCuisiner = "frite"},
        {Nom = "Wrap", ItemRequis = "gallette", ItemCuisiner = "wrap"},
    },

    Stock = {
        {Nom = "Pain", Item = "bread"},
        {Nom = "Nuggets Cru", Item = "nuggetscru"},
        {Nom = "Frite Cru", Item = "fritecru"},
        {Nom = "Gallette", Item = "gallette"},
    },

    Boisson = {
        {Nom = "Coca-cola", Item = "coca"},
        {Nom = "Fanta", Item = "fanta"},
        {Nom = "Sprite", Item = "sprite"},
    },

    Vehicule = {
        {Nom = "Déplacement", Spawn = "exemplar"},
        {Nom = "Camionnette", Spawn = "mule2"},
    },

    Position = {
        Coffre = {vector3(-1202.83, -895.33, 13.99)},
        Cuisine = {vector3(-1199.63, -900.24, 13.99)},
        Stock = {vector3(-1198.68, -901.97, 13.99)},
        Boisson = {vector3(-1198.51, -894.86, 13.99)},
        Boss = {vector3(-1192.07, -897.88, 13.99)},
        Garage = {vector3(-1176.81, -890.68, 13.8)},
    }

}