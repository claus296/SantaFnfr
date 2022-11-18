local character = {}

function character.daddydearest(x, y)
    curEnemy = "daddydearest"
    local char = paths.sprite(x or 0, y or 0, "week1/DADDY_DEAREST")
    char:addByPrefix("idle", "Dad idle dance", 24, false)

    char:addByPrefix("left", "Dad Sing Note LEFT", 24, false)
    char:addByPrefix("right", "Dad Sing Note RIGHT", 24, false)
    char:addByPrefix("up", "Dad Sing Note UP", 24, false)
    char:addByPrefix("down", "Dad Sing Note DOWN", 24, false)

    char:addOffset("idle",  0, 0   )

    char:addOffset("left", -9, 10  )
    char:addOffset("right", 0, 27  )
    char:addOffset("up",   -6, 50  )
    char:addOffset("down",  0, -30 )

    char:animate("idle", false)

    char.colours = {175,102,206}

    return char
end

function character.boyfriend(x, y)
    curPlayer = "boyfriend"
    local char = paths.sprite(x or 0, y or 0, "BOYFRIEND")
    char:addByPrefix("idle", "BF idle dance", 24, false)
    char:addByPrefix("shaking", "BF idle shaking", 24, false)
    char:addByPrefix("hey", "BF HEY!!", 24, false)

    char:addByPrefix("left", "BF NOTE LEFT", 24, false)
    char:addByPrefix("right", "BF NOTE RIGHT", 24, false)
    char:addByPrefix("up", "BF NOTE UP", 24, false)
    char:addByPrefix("down", "BF NOTE DOWN", 24, false)

    char:addByPrefix("miss left", "BF NOTE LEFT MISS", 24, false)
    char:addByPrefix("miss right", "BF NOTE RIGHT MISS", 24, false)
    char:addByPrefix("miss up", "BF NOTE UP MISS", 24, false)
    char:addByPrefix("miss down", "BF NOTE DOWN MISS", 24, false)

    char:addOffset("idle",      0, 0      )
    char:addOffset("shaking",  -4, 0      )
    char:addOffset("hey",      -3, 5      )

    char:addOffset("left",   5, -6        )
    char:addOffset("right", -48, -7       )
    char:addOffset("up",    -46, 27       )
    char:addOffset("down",  -20, -51      )

    char:addOffset("miss left",   7, 19   )
    char:addOffset("miss right", -44, 22  )
    char:addOffset("miss up",    -46, 27  )
    char:addOffset("miss down",  -15, -19 )

    char:animate("idle", false)

    char.colours = {49,176,209}

    return char
end

function character.girlfriend(x, y, isEnemy)
    if isEnemy then
        curEnemy = "girlfriend"
    end
    local char = paths.sprite(x or 0, y or 0, "GF_assets")
    char:addByPrefix("idle", "GF Dancing Beat", 24, false)
    char:addByPrefix("sad", "gf sad", 24, false)
    char:addByPrefix("fear", "GF FEAR ", 24, false)
    char:addByPrefix("cheer", "GF Cheer", 24, false)

    char:addByPrefix("left", "GF left note", 24, false)
    char:addByPrefix("right", "GF Right Note", 24, false)
    char:addByPrefix("up", "GF Up Note", 24, false)
    char:addByPrefix("down", "GF Down Note", 24, false)

    char:addOffset("idle",  0, 0    )
    char:addOffset("sad",  -2, -21  )
    char:addOffset("fear",  -2, -17 )
    char:addOffset("cheer",  3, 0   )

    char:addOffset("left",  0, -19  )
    char:addOffset("right", 0, -20  )
    char:addOffset("up",    0, 4    )
    char:addOffset("down",  0, -20  )

    char:animate("idle", false)

    char.colours = {165,0,77}

    return char
end

function character.spookykids(x, y)
    curEnemy = "spookykids"
    local char = paths.sprite(x or 0, y or 0, "week2/spooky_kids_assets")
    char:addByPrefix("idle", "spooky dance idle", 24, false)

    char:addByPrefix("left", "note sing left", 24, false)
    char:addByPrefix("right", "spooky sing right", 24, false)
    char:addByPrefix("up", "spooky UP NOTE", 24, false)
    char:addByPrefix("down", "spooky DOWN note", 24, false)

    char:addOffset("idle",  0, 0      )

    char:addOffset("left",  130, -10  )
    char:addOffset("right", -130, -14 )
    char:addOffset("up",    -20, 26   )
    char:addOffset("down",  -50, -130 )

    char:animate("idle", false)

    char.colours = {213,126,0}

    return char
end

function character.monster(x, y)
    curEnemy = "monster"
    local char = paths.sprite(x or 0, y or 0, "week2/monster_assets")
    char:addByPrefix("idle", "monster idle", 24, false)

    char:addByPrefix("left", "Monster left note", 24, false)
    char:addByPrefix("right", "Monster Right note", 24, false)
    char:addByPrefix("up", "monster up note", 24, false)
    char:addByPrefix("down", "monster down", 24, false)

    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  -30, 20  )
    char:addOffset("right", -51, 30  )
    char:addOffset("up",    -20, 94  )
    char:addOffset("down",  -50, -80 )

    char:animate("idle", false)

    char.colours = {243,255,110}

    return char
end

function character.pico(x, y)
    curEnemy = "pico"
    local char = paths.sprite(x or 0, y or 0, "week3/Pico_FNF_assetss")
    char:addByPrefix("idle", "Pico Idle Dance", 24, false)

    char:addByPrefix("left", "Pico Note Right", 24, false)
    char:addByPrefix("right", "Pico NOTE LEFT", 24, false)
    char:addByPrefix("up", "pico Up note", 24, false)
    char:addByPrefix("down", "Pico Down Note", 24, false)

    -- redo these offsets later lmao
    char:addOffset("idle",  0, 0         )

    char:addOffset("left",  -52, 0        )
    char:addOffset("right", -82, -11      )
    char:addOffset("up",    -78, 24      )
    char:addOffset("down",  120, -79     )

    char:animate("idle", false)

    char.colours = {183,216,85}

    return char
end

function character.momcar(x, y)
    curEnemy = "mommymearest"
    local char = paths.sprite(x or 0, y or 0, "week4/momCar")
    char:addByPrefix("idle", "Mom Idle", 24, false)

    char:addByPrefix("left", "Mom Left Pose", 24, false)
    char:addByPrefix("right", "Mom Pose Left", 24, false) -- its called mom pose left even tho its right because fnf moment
    char:addByPrefix("up", "Mom Up Pose", 24, false)
    char:addByPrefix("down", "MOM DOWN POSE", 24, false)

    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  250, -23      )
    char:addOffset("right", 10, -60      )
    char:addOffset("up",    14, 71      )
    char:addOffset("down",  20, -160      )

    char:animate("idle", false)

    char.colours = {216,85,142}

    return char
end

function character.boyfriendcar(x, y)
    curPlayer = "boyfriend"
    local char = paths.sprite(x or 0, y or 0, "week4/bfCar")
    char:addByPrefix("idle", "BF idle dance", 24, false)

    char:addByPrefix("left", "BF NOTE LEFT", 24, false)
    char:addByPrefix("right", "BF NOTE RIGHT", 24, false)
    char:addByPrefix("up", "BF NOTE UP", 24, false)
    char:addByPrefix("down", "BF NOTE DOWN", 24, false)

    char:addByPrefix("miss left", "BF NOTE LEFT MISS", 24, false)
    char:addByPrefix("miss right", "BF NOTE RIGHT MISS", 24, false)
    char:addByPrefix("miss up", "BF NOTE UP MISS", 24, false)
    char:addByPrefix("miss down", "BF NOTE DOWN MISS", 24, false)
    
    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  12, -6      )
    char:addOffset("right", -38, -7      )
    char:addOffset("up",    -29, 27      )
    char:addOffset("down",  -10, -50      )

    char:addOffset("miss left",  12, 24      )
    char:addOffset("miss right", -30, 21      )
    char:addOffset("miss up",    -29, 27      )
    char:addOffset("miss down",  -11, -19      )

    char:animate("idle", false)

    char.colours = {49,176,209}

    return char
end

function character.girlfriendcar(x, y)
    local char = paths.sprite(x or 0, y or 0, "week4/gfCar")
    char:addByPrefix("idle", "GF Dancing Beat Hair blowing CAR", 24, false)

    char:addOffset("idle",  0, 0    )

    char:animate("idle", false)

    char.colours = {165,0,77}

    return char
end

function character.dearestduo(x, y)
    curEnemy = "dearestduo"
    local char = paths.sprite(x or 0, y or 0, "week5/mom_dad_christmas_assets")
    char:addByPrefix("idle", "Parent Christmas Idle", 24, false)

    char:addByPrefix("left", "Parent Left Note Dad", 24, false)
    char:addByPrefix("right", "Parent Right Note Dad", 24, false)
    char:addByPrefix("up", "Parent Up Note Dad", 24, false)
    char:addByPrefix("down", "Parent Down Note Dad", 24, false)

    char:addByPrefix("left alt", "Parent Left Note Mom", 24, false)
    char:addByPrefix("right alt", "Parent Right Note Mom", 24, false)
    char:addByPrefix("up alt", "Parent Up Note Mom", 24, false)
    char:addByPrefix("down alt", "Parent Down Note Mom", 24, false)

    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  -30, 16      )
    char:addOffset("right", -1, -23      )
    char:addOffset("up",    -47, 24      )
    char:addOffset("down",  -31, -29      )

    char:addOffset("left alt",  -30, 15      )
    char:addOffset("right alt", -1, -24      )
    char:addOffset("up alt",    -47, 24      )
    char:addOffset("down alt",  -30, -27      )

    char:animate("idle", false)

    char.colours = {175,102,206}

    return char
end

function character.boyfriendchristmas(x, y)
    curPlayer = "boyfriend"
    local char = paths.sprite(x or 0, y or 0, "week5/bfChristmas")
    char:addByPrefix("idle", "BF idle dance", 24, false)

    char:addByPrefix("left", "BF NOTE LEFT", 24, false)
    char:addByPrefix("right", "BF NOTE RIGHT", 24, false)
    char:addByPrefix("up", "BF NOTE UP", 24, false)
    char:addByPrefix("down", "BF NOTE DOWN", 24, false)

    char:addByPrefix("hey", "BF HEY!!", 24, false)

    char:addByPrefix("miss left", "BF NOTE LEFT MISS", 24, false)
    char:addByPrefix("miss right", "BF NOTE RIGHT MISS", 24, false)
    char:addByPrefix("miss up", "BF NOTE UP MISS", 24, false)
    char:addByPrefix("miss down", "BF NOTE DOWN MISS", 24, false)
    
    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  12, -6      )
    char:addOffset("right", -38, -7      )
    char:addOffset("up",    -29, 27      )
    char:addOffset("down",  -10, -50      )

    char:addOffset("miss left",  12, 24      )
    char:addOffset("miss right", -30, 21      )
    char:addOffset("miss up",    -29, 27      )
    char:addOffset("miss down",  -11, -19      )

    char:animate("idle", false)

    char.colours = {49,176,209}

    return char
end

function character.girlfriendchristmas(x, y, isEnemy)
    if isEnemy then
        curEnemy = "girlfriend"
    end
    local char = paths.sprite(x or 0, y or 0, "week5/gfChristmas")
    char:addByPrefix("idle", "GF Dancing Beat", 24, false)
    char:addByPrefix("sad", "gf sad", 24, false)
    char:addByPrefix("fear", "GF FEAR ", 24, false)
    char:addByPrefix("cheer", "GF Cheer", 24, false)

    char:addByPrefix("left", "GF left note", 24, false)
    char:addByPrefix("right", "GF Right Note", 24, false)
    char:addByPrefix("up", "GF Up Note", 24, false)
    char:addByPrefix("down", "GF Down Note", 24, false)

    char:addOffset("idle",  0, 0    )
    char:addOffset("sad",  -2, -21  )
    char:addOffset("fear",  -2, -17 )
    char:addOffset("cheer",  3, 0   )

    char:addOffset("left",  0, -19  )
    char:addOffset("right", 0, -20  )
    char:addOffset("up",    0, 4    )
    char:addOffset("down",  0, -20  )

    char:animate("idle", false)

    char.colours = {165,0,77}

    return char
end

function character.monsterchristmas(x, y)
    curEnemy = "monster"
    local char = paths.sprite(x or 0, y or 0, "week5/monsterChristmas")
    char:addByPrefix("idle", "monster idle", 24, false)

    char:addByPrefix("left", "Monster Right note", 24, false)
    char:addByPrefix("right", "Monster left note", 24, false) -- these are also flipped cuz once again, fnf is dumb
    char:addByPrefix("up", "monster up note", 24, false)
    char:addByPrefix("down", "monster down", 24, false)

    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  -51, 0      )
    char:addOffset("right", -30, 0      )
    char:addOffset("up",    -20, 50      )
    char:addOffset("down",  -40, -94      )

    char:animate("idle", false)

    char.colours = {243,255,110}

    return char
end

function character.senpai(x, y) -- fix offsets later
    curEnemy = "senpai"
    local char = paths.sprite(x or 0, y or 0, "week6/senpai")
    char:addByPrefix("idle", "Senpai Idle", 24, false)

    char:addByPrefix("left", "SENPAI LEFT NOTE", 24, false)
    char:addByPrefix("right", "SENPAI RIGHT NOTE", 24, false)
    char:addByPrefix("up", "SENPAI UP NOTE", 24, false)
    char:addByPrefix("down", "SENPAI DOWN NOTE", 24, false)
    
    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  40, 0      )
    char:addOffset("right", 0, 0      )
    char:addOffset("up",    5, 37      )
    char:addOffset("down",  14, 0      )

    char:animate("idle", false)

    char.colours = {255,170,111}

    return char
end

function character.senpaiangry(x, y) -- fix offsets later
    curEnemy = "senpaiangry"
    local char = paths.sprite(x or 0, y or 0, "week6/senpai")
    char:addByPrefix("idle", "Angry Senpai Idle", 24, false)

    char:addByPrefix("left", "Angry Senpai LEFT NOTE", 24, false)
    char:addByPrefix("right", "Angry Senpai RIGHT NOTE", 24, false)
    char:addByPrefix("up", "Angry Senpai UP NOTE", 24, false)
    char:addByPrefix("down", "Angry Senpai DOWN NOTE", 24, false)
    
    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  40, 0      )
    char:addOffset("right", 0, 0      )
    char:addOffset("up",    5, 37      )
    char:addOffset("down",  14, 0      )

    char:animate("idle", false)

    char.colours = {255,170,111}

    return char
end

function character.boyfriendpixel(x, y)
    curPlayer = "boyfriendpixel"
    local char = paths.sprite(x or 0, y or 0, "pixel/bfPixel")
    char:addByPrefix("idle", "BF IDLE", 24, false)

    char:addByPrefix("left", "BF LEFT NOTE", 24, false)
    char:addByPrefix("right", "BF RIGHT NOTE", 24, false)
    char:addByPrefix("up", "BF UP NOTE", 24, false)
    char:addByPrefix("down", "BF DOWN NOTE", 24, false)

    char:addByPrefix("miss left", "BF LEFT MISS", 24, false)
    char:addByPrefix("miss right", "BF RIGHT MISS", 24, false)
    char:addByPrefix("miss up", "BF UP MISS", 24, false)
    char:addByPrefix("miss down", "BF DOWN MISS", 24, false)

    char:addOffset("idle")

    char:addOffset("left")
    char:addOffset("right")
    char:addOffset("up")
    char:addOffset("down")

    char:addOffset("miss left")
    char:addOffset("miss right")
    char:addOffset("miss up")
    char:addOffset("miss down")

    char:animate("idle", false)

    char.colours = {123,214,246}

    return char
end

function character.girlfriendpixel(x, y)
    local char = paths.sprite(x or 0, y or 0, "pixel/gfPixel")
    char:addByPrefix("idle", "GF IDLE", 24, false)

    char:addOffset("idle")

    char:animate("idle", false)

    char.colours = {165,0,77}

    return char
end

function character.bfandgf(x, y)
    curPlayer = "bfandgf"
    local char = paths.sprite(x or 0, y or 0, "week7/bfAndGF")
    char:addByPrefix("idle", "BF idle dance w gf", 24, false)

    char:addByPrefix("left", "BF NOTE LEFT", 24, false)
    char:addByPrefix("right", "BF NOTE RIGHT", 24, false)
    char:addByPrefix("up", "BF NOTE UP", 24, false)
    char:addByPrefix("down", "BF NOTE DOWN", 24, false)

    char:addByPrefix("miss left", "BF NOTE LEFT MISS", 24, false)
    char:addByPrefix("miss right", "BF NOTE RIGHT MISS", 24, false)
    char:addByPrefix("miss up", "BF NOTE UP MISS", 24, false)
    char:addByPrefix("miss down", "BF NOTE DOWN MISS", 24, false)

    char:addOffset("idle")

    char:addOffset("left", 12, 7)
    char:addOffset("right", -41, 23)
    char:addOffset("up", -29, 10)
    char:addOffset("down", -10, -10)

    char:addOffset("miss left", 12, 7)
    char:addOffset("miss right", -41, 23)
    char:addOffset("miss up", -29, 10)
    char:addOffset("miss down", -10, -10)

    char:animate("idle", false)

    char.colours = {49,176,209}

    return char
end

function character.girlfriendtankmen(x, y)
    local char = paths.sprite(x or 0, y or 0, "week7/gfTankmen")
    char:addByPrefix("idle", "GF Dancing at Gunpoint", 24, false)
    char:addByPrefix("sad", "GF Crying at Gunpoint", 24, false)

    char:addOffset("idle")
    char:addOffset("sad", 0, -27)

    char:animate("idle", false)

    char.colours = {165,0,77}

    return char
end

function character.tankman(x, y)
    curEnemy = "tankman"
    local char = paths.sprite(x or 0, y or 0, "week7/tankmanCaptain")
    char:addByPrefix("idle", "Tankman Idle Dance", 24, false)

    char:addByPrefix("left", "Tankman Right Note", 24, false)
    char:addByPrefix("right", "Tankman Note Left", 24, false) -- you would think this would be right anim, but no
    char:addByPrefix("up", "Tankman UP note", 24, false)
    char:addByPrefix("down", "Tankman DOWN note", 24, false)

    char:addByPrefix("ugh", "TANKMAN UGH", 24, false)
    char:addByPrefix("good", "PRETTY GOOD tankman", 24, false)
    
    char:addOffset("idle",  0, 0     )

    char:addOffset("left",  -21, -31      )
    char:addOffset("right", 84, -14      )
    char:addOffset("up",    48, 54      )
    char:addOffset("down",  76, -101      )

    char:animate("idle", false)

    char.colours = {50,50,50}

    return char
end

function character.luigi(x, y)
    local char = paths.sprite(x or 0, y or 0, "luigi")
    char:addByPrefix("idle", "luigi idle", 24, false)

    char:addOffset("idle")

    char:animate("idle", false)

    return char
end

character.list = {
    {"Boyfriend", character.boyfriend},
    {"Girlfriend", character.girlfriend},
    {"Daddy Dearest", character.daddydearest},
    {"Spooky Kids", character.spookykids},
    {"Monster", character.monster},
    {"Pico", character.pico},
    {"Mom Car", character.momcar},
    {"Boyfriend Car", character.boyfriendcar},
    {"Girlfriend Car", character.girlfriendcar},
    {"Dearest Duo", character.dearestduo},
    {"Monster Christmas", character.monsterchristmas},
    {"Senpai", character.senpai},
    {"Senpai Angry", character.senpaiangry},
    {"Boyfriend Pixel", character.boyfriendpixel},
    {"Girlfriend Pixel", character.girlfriendpixel},
    {"Boyfriend and Girlfriend", character.bfandgf},
    {"Girlfriend Tankmen", character.girlfriendtankmen},
    {"Tankman", character.tankman},
    {"Luigi", character.luigi}
}

return character