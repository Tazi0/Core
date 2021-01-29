Lang = {}

-- The basic language
Lang["en"] = {
    title = {
        red = "Red",
        green = "Green",
        blue = "Blue"
    }
}

-- The dutch translation
Lang["nl"] = {
    title = "TITEL HIER"
}

-- Global variable, this will be exported for ever script to use
Preference = {
    lang = "en"
}

-- Grabs the fromm preference language then makes that in Lang variable
Lang = Lang[Preference["lang"]]