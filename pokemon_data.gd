extends Node


const treecko: Array = ["Treecko", ["Grass"], 40, 45, 35, 65, 55, 70, 65]
const treecko_lernset: Dictionary = {1: ["Pound", "Leer"], 6: ["Absorb"], 11: ["Quick Attack"], 16: ["Pursuit"], 21: ["Screech"], 26: ["Mega Drain"], 31: ["Agility"], 36: ["Slam"], 41: ["Detect"], 46: ["Giga Drain"]}
const grovyle: Array = ["Grovyle", ["Grass"], 50, 65, 45, 85, 65, 95, 141]
const grovyle_lernset: Dictionary = {1: ["Pound", "Leer", "Absorb", "Quick Attack"], 6: ["Absorb"], 11: ["Quick Attack"], 16: ["Fury Cutter"], 17: ["Pursuit"], 23: ["Screech"], 29: ["Leaf Blade"], 35: ["Agility"], 41: ["Slam"], 47: ["Detect"], 53: ["False Swipe"]}
const sceptile: Array = ["Sceptile", ["Grass"], 70, 85, 65, 105, 85, 120, 208]
const sceptile_lernset: Dictionary = {1: ["Pound", "Leer", "Absorb", "Quick Attack"], 6: ["Absorb"], 11: ["Quick Attack"], 16: ["Fury Cutter"], 17: ["Pursuit"], 23: ["Screech"], 29: ["Leaf Blade"], 35: ["Agility"], 43: ["Slam"], 51: ["Detect"], 59: ["False Swipe"]}

const torchic: Array = ["Torchic", ["Fire"], 45, 60, 40, 70, 50, 45, 65]
const torchic_lernset: Dictionary = {1: ["Scratch", "Growl"], 7: ["Focus Energy"], 10: ["Ember"], 16: ["Peck"], 19: ["Sand-Attack"], 25: ["Fire Spin"], 28: ["Quick Attack"], 34: ["Mirror Move"], 43: ["Flamethrower"]}
const combusken: Array = ["Combusken", ["Fire", "Fight"], 60, 85, 60, 85, 60, 55, 142]
const combusken_lernset: Dictionary = {1: ["Scratch", "Growl", "Focus Energy", "Ember"], 7: ["Focus Energy"], 13: ["Ember"], 16: ["Double Kick"], 17: ["Peck"], 21: ["Sand-Attack"], 28: ["Bluk Up"], 32: ["Quick Attack"], 39: ["Slash"], 43: ["Mirror Move"], 50: ["Sky Uppercut"]}
const blaziken: Array = ["Blaziken", ["Fire", "Fight"], 80, 120, 70, 110, 70, 80, 209]
const blaziken_lernset: Dictionary = {1: ["Fire Punch", "Scratch", "Growl", "Focus Energy", "Ember"], 7: ["Focus Energy"], 13: ["Ember"], 16: ["Double Kick"], 17: ["Peck"], 21: ["Sand-Attack"], 28: ["Bulk Up"], 32: ["Quick Attack"], 36: ["Blaze Kick"], 42: ["Slash"], 49: ["Mirror Move"], 59: ["Sky Uppercut"]}

const mudkip: Array = ["Mudkip", ["Water"], 50, 70, 50, 50, 40, 65]
const mudkip_lernset: Dictionary = {1: ["Tackle", "Growl"], 6: ["Mud-Slap"], 10: ["Water Gun"], 15: ["Bide"], 19: ["Foresight"], 24: ["Mud Sport"], 28: ["Take Down"], 33: ["Whirlpool"], 37: ["Protect"], 42: ["Hydro Pump"], 46: ["Endeavor"]}
const marshtomp: Array = ["Marshtomp", ["Water", "Ground"], 70, 85, 70, 50, 70, 50, 143]
const marshtomp_lernset: Dictionary = {1: ["Tackle", "Growl", "Mud-Slap", "Water Gun"], 6: ["Mud-Slap"], 10: ["Water Gun"], 15: ["Bide"], 16: ["Mud Shot"], 20: ["Foresight"], 25: ["Mud Sport"], 31: ["Take Down"], 37: ["Muddy Water"], 42: ["Protect"], 46: ["Earthquake"], 53: ["Endeavor"]}
const swampert: Array = ["Swampert", ["Water", "Ground"], 100, 110, 90, 85, 90, 60, 210]
const swampert_lernset: Dictionary = {1: ["Tackle", "Growl", "Mud-Slap", "Water Gun"], 6: ["Mud-Slap"], 10: ["Water Gun"], 15: ["Bide"], 16: ["Mud Shot"], 20: ["foresight"], 25: ["Mud Sport"], 31: ["Take Down"], 39: ["Muddy Water"], 46: ["Portect"], 52: ["Earthquake"], 61: ["Endeavor"]}

const poochyena: Array = ["Poochyena", ["Dark"], 35, 55, 35, 30, 30, 35, 55]
const poochyena_lernset: Dictionary = {1: ["Tackle"], 5: ["Howl"], 9: ["Sand-Attack"], 13: ["Bite"], 17: ["Odor Sleuth"], 21: ["Roar"], 25: ["Swagger"], 29: ["Scary Face"], 33: ["Take Down"], 41: ["Curnch"], 45: ["Thief"]}
const mightyena: Array = ["Mightyena", ["Dark"], 70, 90, 70, 60, 60, 70, 128]
const mightyena_lernset: Dictionary = {1: ["Tackle", "Howl", "Sand-Attack", "Bite"], 5: ["Howl"], 9: ["Sand-Attack"], 13: ["Bite"], 17: ["Odor Sleuth"], 22: ["Roar"], 27: ["Swagger"], 32: ["Scary Face"], 37: ["Take Down"], 42: ["Taunt"], 47: ["Crunch"], 52: ["Thief"]}

const zigzagoon: Array = ["Zigzagoon", ["Normal"], 38, 30, 41, 30, 41, 60, 60]
const zigzagoon_lernset: Dictionary = {1: ["Tackle", "Growl"], 5: ["Tail Whip"], 9: ["Headbutt"], 13: ["Sand-Attack"], 17: ["Odor Sleuth"], 21: ["Mud Sport"], 25: ["Pin Missile"], 29: ["Covet"], 33: ["Flail"], 37: ["Rest"], 41: ["Belly Drum"]}
const linoone: Array = ["Linoone", ["Normal"], 78, 70, 61, 50, 61, 100, 128]
const linoone_lernset: Dictionary = {1: ["Tackle", "Growl", "Tail Whip", "Headbutt"], 5: ["Tail Whip"], 9: ["Headbutt"], 13: ["Sand-Attack"], 17: ["Odor Sleuth"], 23: ["Mud Sport"], 29: ["Fury Swipes"], 35: ["Covet"], 41: ["Slash"], 47: ["Rest"], 53: ["Belly Drum"]}

const wurmple: Array = ["Wurmple", ["Bug"], 45, 45, 35, 20, 30, 20, 54]
const wurmple_lernset: Dictionary = {1: ["Tackle", "String Shot"], 5: ["Poison Sting"]}
const silcoon: Array = ["Silcoon", ["Bug"], 50, 35, 55, 25, 25, 15, 71]
const silcoon_lernset: Dictionary = {1: ["Harden"], 7: ["Harden"]}
const beautifly: Array = ["Beautifly", ["Bug", "Flying"], 60, 70, 50, 100, 50, 65, 161]
const beautifly_lernset: Dictionary = {1: ["Absorb"], 10: ["Absorb"], 13: ["Gust"], 17: ["Stund Spore"], 20: ["Morning Sun"], 24: ["Mega Drain"], 27: ["Whirlwind"], 31: ["Attract"], 34: ["Silver Wind"], 38: ["Giga Drain"]}
const cascoon: Array = ["Cascoon", ["Bug"], 50, 35, 55, 25, 25, 15, 72]
const cascoon_lernset: Dictionary = {1: ["Harden"], 7: ["Harden"]}
const dustox: Array = ["Dustox", ["Bug", "Poison"], 60, 50, 70, 50, 90, 65, 160]
const dustox_lernset: Dictionary = {1: ["Confusion"], 10: ["Confusion"], 13: ["Gust"], 17: ["Protect"], 20: ["Moonlight"], 24: ["Psybeam"], 27: ["Whirlwind"], 31: ["Light Screen"], 34: ["Silver Wind"], 38: ["Toxic"]}

const lotad: Array = ["Lotad", ["Water", "Grass"], 40, 30, 30, 40, 50, 30, 74]
const lotad_lernset: Dictionary = {1: ["Astonish"], 3: ["Growl"], 7: ["Absorb"], 13: ["Nature Power"], 21: ["Mist"], 31: ["Rain Dance"], 43: ["Mega Drain"]}
const lombre: Array = ["Lombre", ["Water", "Grass"], 60, 50, 50, 60, 70, 50, 141]
const lombre_lernset: Dictionary = {1: ["Astonish"], 3: ["Growl"], 7: ["Absorb"], 13: ["Nature Power"], 19: ["Fake Out"], 25: ["Fury Swipes"], 31: ["Water Sport"], 37: ["Thief"], 43: ["Uproar"], 49: ["Hydro Pump"]}
const ludicolo: Array = ["Ludicolo", ["Water", "Grass"], 80, 70, 70, 90, 100, 70, 181]
const ludicolo_lernset: Dictionary = {1: ["Astonish", "Growl", "Absorb", "Nature Power"]}

const seedot: Array = ["Seedot", ["Grass"], 40, 40, 50, 30, 30, 30, 74]
const seedot_lernset: Dictionary = {1: ["Bide"], 3: ["Harden"], 7: ["Growth"], 13: ["Nature Power"], 21: ["Synethesis"], 31: ["Sunny Day"], 43: ["Explosion"]}
const nuzleaf: Array = ["Nuzleaf", ["Grass", "Drak"], 70, 70, 40, 60, 40, 60, 141]
const nuzleaf_lernset: Dictionary = {1: ["Pound"], 3: ["Harden"], 7: ["Growth"], 13: ["Nature Power"], 19: ["Fake Out"], 25: ["Torment"], 31: ["Faint Attack"], 37: ["Razor Wind"], 43: ["Swagger"], 49: ["Extrasensory"]}

const shiftry: Array = ["Shiftry", ["Grass", "Dark"], 90, 100, 60, 90, 60, 80, 181]
const shiftry_lernset: Dictionary = {1: ["Pound", "Harden", "Growth", "Nature Power"]}

const taillow: Array = ["Taillow", ["Normal", "Flying"], 40, 55, 30, 30, 30, 85, 59]
const taillow_lernset: Dictionary = {1: ["Peck", "Growl"], 4: ["Focus Energy"], 8: ["Quick Attack"], 13: ["Wing Attack"], 19: ["Double Team"], 26: ["Endeavor"], 34: ["Aerial Ace"], 43: ["Agility"]}
const swellow: Array = ["Sellow", ["Normal", "Flying"], 60, 85, 60, 75, 50, 125, 64]
const swellow_lernset: Dictionary = {1: ["Peck", "Growl"], 4: ["Focus Energy"], 8: ["Quick Attack"], 13: ["Wing Attack"], 19: ["Double Team"], 26: ["Endeavor"], 34: ["Aerial Ace"], 43: ["Agility"]}

const wingull: Array = ["Wingull", ["Water", "Flying"], 40, 30, 30, 55, 30, 85, 64]
const wingull_lernset: Dictionary = {1: ["Growl", "Water Gun"], 7: ["Supersonic"], 13: ["Wing Attack"], 21: ["Mist"], 31: ["Quick Attack"], 43: ["Pursuit"], 55: ["Agility"]}
const pelipper: Array = ["Pelipper", ["Water", "Flying"], 60, 50, 100, 95, 70, 65, 164]
const pelipper_lernset: Dictionary = {1: ["Growl", "Water Gun", "Water Sport", "Wing Attack"], 3: ["Water Gun"], 7: ["Supersonic"], 13: ["Wing Attack"], 21: ["Mist"], 25: ["Protect"], 47: ["Spit Up"], 61: ["Hydro Pump"]}

const ralts: Array = ["Ralts", ["Psychic", "Fairy"], 28, 25, 25, 45, 35, 40, 70]
const ralts_lernset: Dictionary = {1: ["Growl"], 6: ["Confusion"], 11: ["Double Team"], 16: ["Teleport"], 21: ["Calm Mind"], 26: ["Psychic"], 31: ["Imprison"], 36: ["Future Sight"], 41: ["Hypnosis"], 46: ["Dream Eater"]}
const kirlia: Array = ["Kirlia", ["Psychic", "Fairy"], 38, 35, 65, 55, 50, 140]
const kirlia_lernset: Dictionary = {1: ["Magical Leaf", "Growl", "Confusion", "Double Team", "Teleport"], 6: ["Confusion"], 11: ["Double Team"], 16: ["Teleport"], 21: ["Clam Mind"], 26: ["Psychic"], 33: ["Imprison"], 40: ["Future Sight"], 47: ["Hypnosis"], 54: ["Dream Eater"]}
const gardevoir: Array = ["Gardevoir", ["Psychic", "Fairy"], 68, 65, 65, 125, 115, 80, 208]
const gardevoir_lernset: Dictionary = {1: ["Growl", "Confusion", "Double Team", "Teleport"], 6: ["Confusion"], 11: ["Double Team"], 16: ["Teleprot"], 21: ["Calm Mind"], 26: ["Psychic"], 33: ["Imprison"], 42: ["Future Sight"], 51: ["Hypnosis"], 60: ["Dream Eater"]}

const surskit: Array = ["Surskit", ["Bug", "Water"], 40, 30, 32, 50, 52, 65, 63]
const surskit_lernset: Dictionary = {1: ["Bubble"], 7: ["Quick Attack"], 13: ["Sweet Scent"], 19: ["Water Sport"], 25: ["BubbleBeam"], 31: ["Agility"], 37: ["Mist", "Haze"]}
const masquerain: Array = ["Masquerain", ["Bug", "Flying"], 70, 60, 62, 100, 82, 80, 128]
const masquerain_lernset: Dictionary = {1: ["Bubble", "Quick Attack", "Sweet Scent", "Water Sport"], 7: ["Quick Attack"], 13: ["Sweet Scent"], 19: ["Water Sprot"], 26: ["Gust"], 33: ["Scary Face"], 40: ["Stun Spore"], 47: ["Silver Wind"], 53: ["Whirlwind"]}

const shroomish: Array = ["Shroomish", ["Grass"], 60, 40, 60, 40, 60, 45, 65]
const shroomish_lernset: Dictionary = {1: ["Absorb"], 4: ["Tackle"], 7: ["Stun Spore"], 10: ["Leech Seed"], 16: ["Mega Drain"], 22: ["Headbutt"], 28: ["PoisonPowder"], 36: ["Growth"], 45: ["Giga Drain"], 54: ["Spore"]}
const breloom: Array = ["Breloom", ["Grass, Fight"], 60, 130, 80, 60, 60, 70, 165]
const breloom_lernset: Dictionary = {1: ["Absrob", "Tackle", "Stun Spore", "Leech Seed"], 4: ["Tackle"], 7: ["Stun Spore"], 10: ["Leech Seed"], 16: ["Mega Drain"], 22: ["Headbutt"], 23: ["Mach Punch"], 28: ["Counter"], 36: ["Sky Uppercut"], 45: ["Mind Reader"], 54: ["DynamicPunch"]}

const slakoth: Array = ["Slakoth", ["Normal"], 60, 60, 60, 35, 35, 30, 83]
const slakoth_lernset: Dictionary = {1: ["Scratch", "Yawn"], 7: ["Encore"], 13: ["Slack Off"], 19: ["Faint Attack"], 25: ["Amnesia"], 31: ["Covet"], 37: ["Counter"], 43: ["Flail"]}
const vigoroth: Array = ["vigoroth", ["Normal"], 80, 80, 80, 55, 55, 90, 126]
const vigoroth_lernset: Dictionary = {1: ["Scratch", "Focus Energy", "Encore", "Uproar"], 7: ["Encore"], 13: ["Uproar"], 19: ["Fury Swipes"], 25: ["Endure"], 31: ["Slash"], 37: ["Counter"], 43: ["Focus Punch"], 49: ["Reversal"]}
const slaking: Array = ["Slaking", ["Normal"], 150, 160, 100, 95, 65, 100, 210]
const slaking_lernset: Dictionary = {1: ["Scratch", "Yawn", "Encore", "Slack Off"], 7: ["Encore"], 13: ["Slack Off"], 19: ["Faint Attack"], 25: ["Amnesia"], 31: ["Covet"], 36: ["Swagger"], 37: ["Counter"], 43: ["Flail"]}

const nicada: Array = ["Nicada", ["Bug", "Ground"], 31, 45, 90, 30, 30, 40, 65]
const nincada_lernset: Dictionary = {1: ["Scratch", "Harden"], 5: ["Leech Life"], 9: ["Sand-Attack"], 14: ["Fury Swipes"], 19: ["Mind Reader"], 25: ["False Swipe"], 31: ["Mud-Slap"], 38: ["Metal Claw"], 45: ["Dig"]}
const ninjask: Array = ["Ninjask", ["Bug", "Flying"], 61, 90, 45, 50, 50, 160, 155]
const ninjask_lernset: Dictionary = {1: ["Scratch", "Harden", "Leech Life", "Sand-Attack"], 5: ["Leech Life"], 9: ["Sand-Attack"], 14: ["Fury Swipes"], 19: ["Mind Reader"], 20: ["Double Team", "Fury Cutter", "Screech"], 25: ["Swords Dance"], 31: ["Slash"], 38: ["Agility"], 45: ["Baton Pass"]}

const shedinja: Array = ["Shedinja", ["Bug", "Ghost"], 1, 90, 45, 30, 30, 40, 95]
const shedinja_lernset: Dictionary = {1: ["Scratch", "Harden"], 5: ["Leech Life"], 9: ["Sand-Attack"], 14: ["Fury Swipes"], 19: ["Mind Reader"], 25: ["Spite"], 31: ["Confuse Ray"], 38: ["Shadow Ball"], 45: ["Grudge"]}

const whismur: Array = ["Whismur", ["Normal"], 64, 51, 2, 51, 23, 28, 68]
const whismur_lernset: Dictionary = {1: ["Pound"], 5: ["Uproar"], 11: ["Astonish"], 15: ["Howl"], 21: ["Supersonic"], 25: ["Stomp"], 31: ["Screech"], 35: ["Roar"], 41: ["Rest", "Sleep Talk"], 45: ["Hyper Voice"]}
const loudred: Array = ["Loudred", ["Normal"], 84, 71, 43, 71, 43, 48, 126]
const loudred_lernset: Dictionary = {1: ["Pound", "Uproar", "Astonish", "Howl"], 5: ["Uproar"], 11: ["Astonish"], 15: ["Howl"], 23: ["Supersonic"], 29: ["Stomp"], 37: ["Screech"], 43: ["Roar"], 51: ["Rest", "Sleep Talk"], 57: ["Hyper Voice"]}
const exploud: Array = ["Exploud", ["Normal"], 104, 91, 63, 91, 73, 68, 184]
const exploud_lernset: Dictionary = {1: ["Pound", "Uproar", "Astonish", "Howl"], 5: ["Uproar"], 11: ["Astonis"], 15: ["Howl"], 23: ["Supersonic"], 29: ["Stomp"], 37: ["Screech"], 40: ["Hyper Beam"], 45: ["Roar"], 55: ["Rest", "Sleep Talk"], 65: ["Hyper Voice"]}

const makuhita: Array = ["Makuhita", ["Fight"], 72, 60, 30, 20, 30, 25, 87]
const makuhita_lernset: Dictionary = {1: ["Tackle", "Focus Energy"], 4: ["Sand-Attack"], 10: ["Arm Thurst"], 13: ["Vital Throw"], 19: ["Fake Out"], 22: ["Whirlwind"], 28: ["Knock Off"], 31: ["SmellinSalt"], 37: ["Belly Drum"], 40: ["Endure"], 46: ["Seismic Toss"], 49: ["Reversal"]}
const hariyama: Array = ["Hariyama", ["Fight"], 144, 120, 60, 40, 60, 50, 184]
const hariyama_lernset: Dictionary = {1: ["Tackle", "Focus Energy"], 4: ["Sand-Attack"], 10: ["Arm Thurst"], 13: ["Vital Throw"], 19: ["Fake Out"], 22: ["Whirlwind"], 28: ["Knock Off"], 31: ["SmellinSalt"], 37: ["Belly Drum"], 40: ["Endure"], 46: ["Seismic Toss"], 49: ["Reversal"]}

const azurill: Array = ["Azurill", ["Normal", "Fairy"], 50, 20, 40, 20, 40, 20, 33]
const azurill_lernset: Dictionary = {1: ["Spalsh"], 3: ["Charm"], 6: ["Tail Whip"], 10: ["Bubble"], 15: ["Slam"], 21: ["Water Gun"]}

const nosepass: Array = ["Nosepass", ["Rock"], 30, 45, 135, 45, 90, 30, 108]
const nosepass_lernset: Dictionary = {1: ["Tackle"], 7: ["Harden"], 13: ["Rock Throw"], 16: ["Block"], 22: ["Thunder Wave"], 28: ["Rock Slide"], 31: ["Sandstrom"], 37: ["Rest"], 43: ["Zap Cannon"], 46: ["Lock-On"]}

const skitty: Array = ["Skitty", ["Normal"], 50, 45, 45, 35, 35, 50, 65]
const skitty_lernset: Dictionary = {1: ["Growl", "Tackle"], 3: ["Tail Whip"], 7: ["Attract"], 13: ["Sing"], 15: ["DoubleSlap"], 19: ["Assist"], 25: ["Charm"], 27: ["Faint Attack"], 31: ["Covet"], 33: ["Heal Bell"], 39: ["Double Edge"]}
const delcatty: Array = ["Delcatty", ["Normal"], 70, 65, 65, 55, 55, 90, 138]
const delcatty_lernset: Dictionary = {1: ["Growl", "Attract", "Sing", "DoubleSlap"]}

const sabyele: Array = ["Sableye", ["Dark", "Ghost"], 50, 75, 75, 65, 65, 50, 98]
const sableye_lernset: Dictionary = {1: ["Scratch", "Leer"], 5: ["Foresight"], 9: ["Night Shade"], 13: ["Astonish"], 17: ["Fury Swipes"], 21: ["Fake Out"], 25: ["Detect"], 29: ["Faint Attack"], 33: ["Knock Off"], 37: ["Confuse Ray"], 41: ["Shadow Ball"], 45: ["Mean Look"]}

const mawile: Array = ["Mawile", ["Steel", "Fairy"], 50, 85, 85, 55, 55, 50, 98]
const mawile_lernset: Dictionary = {1: ["Astonish"], 6: ["Fake Tears"], 11: ["Bite"], 16: ["Sweet Scent"], 21: ["ViceGrip"], 26: ["Faint Attck"], 31: ["Baton Pass"], 36: ["Crunch"], 41: ["Iron Defense"], 46: ["Stockpile", "Swallow", "Spit Up"]}

const aron: Array = ["Aron", ["Steel", "Rock"], 50, 70, 100, 40, 40, 30, 96]
const aron_lernset: Dictionary = {1: ["Tackle"], 4: ["Harden"], 7: ["Mud-Slap"], 10: ["Headbutt"], 13: ["Metal Claw"], 17: ["Iron Defense"], 21: ["Roar"], 25: ["Take Down"], 29: ["Iron Tail"], 34: ["Protect"], 39: ["Metal Sound"], 44: ["Double-Edge"]}
const lairon: Array = ["Lairon", ["Steel", "Rock"], 60, 90, 140, 50, 50, 40, 152]
const lairon_lernset: Dictionary = {1: ["Tackle", "Harden", "Mud-Slap", "Headbutt"], 4: ["Harden"], 7: ["Mud-Slap"], 10: ["Headbutt"], 13: ["Metal Claw"], 17: ["Iron Defense"], 21: ["Roar"], 25: ["Take Down"], 29: ["Iron Tail"], 37: ["Protect"], 45: ["Metal Sound"], 53: ["Double-Edge"]}
const aggron: Array = ["Aggron", ["Steel", "Rock"], 70, 110, 180, 60, 60, 50, 205]
const aggron_lernset: Dictionary = {1: ["Tackle", "Harden", "Mud-Slap",  "Headbutt"], 4: ["Harden"], 7: ["Mud-Slap"], 10: ["Headbutt"], 13: ["Metal Claw"], 17: ["Iron Defense"], 21: ["Roar"], 25: ["Take Down"], 29: ["Iron Tail"], 37: ["Protect"], 50: ["Metal Sound"], 63: ["Double-Edge"]}

const meditite: Array = ["Meditite", ["Fight", "Psychic"], 30, 40, 55, 40, 55, 60, 91]
const meditite_lernset: Dictionary = {1: ["Bide"], 4: ["Meditate"], 9: ["Confusion"], 12: ["Detect"], 17: ["Hidden Power"], 20: ["Swagger"], 25: ["Mind Reader"], 28: ["Calm Mind"], 33: ["Hi Jump Kick"], 36: ["Psych Up"], 41: ["Reversal"], 44: ["Recover"]}
const medicham: Array = ["Medicham", ["Fight", "Psychic"], 60, 60, 76, 60, 76, 80, 153]
const medicahm_lernset: Dictionary = {1: ["Fire Punch", "Ice Punch", "Thunder Punch", "Bide", "Meditate", "Confusion", "Detect"], 4: ["Meditate"], 9: ["Confusion"], 12: ["Detect"], 17: ["Hidden Power"], 20: ["Swagger"], 25: ["Mind Reader"], 28: ["Calm Mind"], 33: ["Hi Jump Kick"], 36: ["Psych Up"], 47: ["Reversal"], 56: ["Recover"]}

const electrike: Array = ["Electrike", ["Electro"], 40, 45, 40, 65, 40, 65, 104]
const electrike_lernset: Dictionary = {1: ["Tackle"], 4: ["Thudner Wave"], 9: ["Leer"], 12: ["Howl"], 17: ["Quick Attack"], 20: ["Spark"], 25: ["Odor Sleuth"], 28: ["Roar"], 33: ["Bite"], 36: ["Thunder"], 41: ["Charge"]}
const menectric: Array = ["Manectric", ["Electro"], 70, 75, 60, 105, 60, 105, 168]
const manectric_lernset: Dictionary = {1: ["Tackle", "Thunder Wave", "Leer", "Howl"], 4: ["Thunder Wave"], 9: ["Leer"], 12: ["Howl"], 17: ["Quick Attack"], 20: ["Spark"], 25: ["Odor Sleuth"], 31: ["Roar"], 39: ["Bite"], 45: ["Thudner"], 53: ["Charge"]}

const plusle: Array = ["Plusle", ["Electro"], 60, 50, 40, 85, 75, 95, 120]
const plusle_lernset: Dictionary = {1: ["Growl"], 4: ["Thunder Wave"], 10: ["Quick Attack"], 13: ["Helping Hand"], 19: ["Spark"], 22: ["Encore"], 28: ["Fake Tear"], 31: ["Charge"], 37: ["Thunder"], 40: ["Baton Pass"], 47: ["Agility"]}
const minun: Array = ["Minun", ["Electro"], 60, 40, 50, 75, 85, 95, 120]
const minun_lernset: Dictionary = {1: ["Growl"], 4: ["Thunder Wave"], 10: ["Quick Attack"], 13: ["Helping Hand"], 19: ["Spark"], 22: ["Encore"], 28: ["Fake Tear"], 31: ["Charge"], 37: ["Thunder"], 40: ["Baton Pass"], 47: ["Agility"]}

const volbeat: Array = ["Volbeat", ["Bug"], 65, 73, 75, 47, 85, 85, 146]
const volbeat_lernset: Dictionary = {1: ["Tackle"], 5: ["Confuse Ray"], 9: ["Double Team"], 13: ["Moonlight"], 17: ["Quick Attack"], 21: ["Tail Glow"], 25: ["Signal Beam"], 29: ["Protect"], 33: ["Helping Hand"], 37: ["Double-Edge"]}
const illumise: Array = ["Illumise", ["Bug"], 65, 47, 75, 73, 85, 85, 146]
const illumise_lernset: Dictionary = {1: ["Tackle"], 5: ["Sweet Scent"], 9: ["Charm"], 13: ["Moonlight"], 17: ["Quick Attack"], 21: ["Wish"], 25: ["Encore"], 29: ["Flatter"], 33: ["Helping Hand"], 37: ["Covet"]}

const roselia: Array = ["Roselia", ["Grass", "Poison"], 50, 60, 45, 100, 80, 65, 152]
const roselia_lernset: Dictionary = {1: ["Absorb"], 5: ["Growth"], 9: ["Poison Sting"], 13: ["Stun Spore"], 17: ["Mega Drain"], 21: ["Leech Seed"], 25: ["Magical Leaf"], 29: ["GrassWhistle"], 33: ["Giga Drain"], 37: ["Sweet Scent"], 41: ["Ingrain"], 45: ["Toxic"], 49: ["Petal Dance"], 53: ["Aromatherapy"], 57: ["Synthesis"]}
const gulpin: Array = ["Gulpin", ["Poison"], 70, 43, 53, 43, 53, 40, 75]
const gulpin_lernset: Dictionary = {1: ["Pound"], 6: ["Yawn"], 9: ["Poison Gas"], 14: ["Sludge"], 17: ["Amnesia"], 23: ["Encore"], 28: ["Toxic"], 34: ["Stockpile", "Spit Up", "Swallow"], 39: ["Sludge Bomb"]}
const swalot: Array = ["Swalot", ["Poison"], 100, 73, 83, 73, 83, 55, 168]
const swalot_lernset: Dictionary = {1: ["Pound", "Yawn", "Poison Gas", "Sludge"], 6: ["Yawn"], 9: ["Poison Gas"], 14: ["Sludge"], 17: ["Amnesia"], 23: ["Encore"], 26: ["Body Slam"], 31: ["Toxic"], 40: ["Stock Pile", "Spit Up", "Swallow"], 48: ["Sludge Bomb"]}

const carvanha: Array = ["Carvanha", ["Water", "Dark"], 45, 90, 20, 65, 20, 65, 88]
const carvanha_lernset: Dictionary = {1: ["Bite", "Leer"], 7: ["Rage"], 13: ["Focus Energy"], 16: ["Scary Face"], 22: ["Crunch"], 28: ["Screech"], 31: ["Take Down"], 37: ["Swagger"], 43: ["Agility"]}

const sharpedo: Array = ["Sharpedo", ["Water", "Dark"], 70, 120, 40, 95, 40, 95, 175]
const sharpedo_lernset: Dictionary = {1: ["Bite", "Leer", "Rage", "Focus Energy"], 7: ["Rage"], 13: ["Focus Energy"], 16: ["Scary FAce"], 22: ["Crunch"], 28: ["Screech"], 33: ["Slash"], 38: ["Taunt"], 43: ["Swagger"], 48: ["Skull Bash"], 53: ["Agility"]}

const wailmer: Array = ["Wailmer", ["Water"], 130, 70, 35, 70, 35, 60, 137]
const wailmer_lernset: Dictionary = {1: ["Slash"], 5: ["Growl"], 10: ["Water Gun"], 14: ["Rollout"], 19: ["Whirlpool"], 23: ["Astonish"], 28: ["Water Pulse"], 32: ["Mist"], 37: ["Rest"], 41: ["Water Spout"], 46: ["Amnesia"], 50: ["Hydro Pump"]}
const wailord: Array = ["Wailord", ["Water"], 170, 90, 45, 90, 45, 60, 206]
const wailord_lernset: Dictionary = {1: ["Splash", "Growl", "Water Gun", "Rollout"], 5: ["Growl"], 10: ["Water gun"], 14: ["Rollout"], 19: ["Whirlpool"], 23: ["Astonish"], 28: ["Water Pulse"], 32: ["Mist"], 37: ["Rest"], 44: ["Water Spout"], 52: ["Amnesia"], 59: ["Hydro Pump"]}

const numel: Array = ["Numel", ["Fire", "Ground"], 60, 60, 40, 65, 45, 35, 88]
const numel_lernset: Dictionary = {1: ["Growl", "Tackle"], 11: ["Ember"], 19: ["Magnitude"], 25: ["Focus Energy"], 29: ["Take Down"], 31: ["Amnesia"], 35: ["Earthquake"], 41: ["Flamethrower"], 49: ["Double-Edge"]}
const camerupt: Array = ["Camerupt", ["Fire", "Ground"], 70, 100, 70, 105, 75, 40, 175]
const camerupt_lernset: Dictionary = {1: ["Growl", "Tackle", "Ember", "Magnitude"], 11: ["Ember"], 19: ["Magnitude"], 25: ["Focus Energy"], 29: ["Take Down"], 31: ["Amnesia"], 33: ["Rock Slide"], 37: ["Earthquake"], 45: ["Eruption"], 55: ["Fissure"]}
const torkoal: Array = ["Torkoal", ["Fire"], 70, 85, 140, 85, 70, 20, 161]
const torkoal_lernset: Dictionary = {1: ["Ember"], 4: ["Smog"], 7: ["Curse"], 14: ["SmokeScreen"], 17: ["Fire Spin"], 20: ["Body Slam"], 27: ["Protect"], 30: ["Flamethrower"], 33: ["Iron Defense"], 40: ["Amnesia"], 43: ["Flail"], 46: ["Heat Wave"]}

const spoink: Array = ["Spoink", ["Psychic"], 60, 25, 35, 70, 80, 60, 89]
const spoink_lernset: Dictionary = {1: ["Spalsh"], 7: ["Psywave"], 10: ["Odor Sleuth"], 16: ["Psybeam"], 19: ["Psych Up"], 25: ["Confuse Ray"], 28: ["Magic Coat"], 34: ["Psychic"], 37: ["Rest", "Snore"], 43: ["Bounce"]}
const grumpig: Array = ["Grumpig", ["Psychic"], 80, 45, 65, 90, 110, 80, 164]
const grumpig_lernset: Dictionary = {1: ["Splash", "Psywave", "Odor Sleuth", "Psybeam"], 7: ["Psywave"], 10: ["Odor Sleuth"], 16: ["Psybeam"], 19: ["Psych Up"], 25: ["Confuse Ray"], 28: ["Magic Coat"], 37: ["Psychic"], 43: ["Rest", "Snore"], 55: ["Bounce"]}

const spinda: Array = ["Spinda", ["Normal"], 60, 60, 60, 60, 60, 60, 85]
const spinda_lernset: Dictionary = {1: ["Tackle"], 5: ["Uproar"], 12: ["Faint Attack"], 16: ["Psybeam"], 23: ["Hypnosis"], 27: ["Dizzy Punch"], 34: ["Teeter Dance"], 38: ["Psych Up"], 45: ["Double-Edge"], 49: ["Flail"], 56: ["Thrash"]}

const trapinch: Array = ["Trapinch", ["Ground"], 45, 100, 45, 45, 45, 10, 73]
const trapinch_lernset: Dictionary = {1: ["Bite"], 9: ["Sand-Attack"], 17: ["Faint Attack"], 25: ["Sand Tomb"], 33: ["Crunch"], 41: ["Dig"], 49: ["Sandstrom"], 57: ["Hyper Beam"]}

const vibrava: Array = ["Vibrava", ["Ground", "Dragon"], 50, 70, 50, 50, 50, 70, 126]
const vibrava_lernset: Dictionary = {1: ["Bite", "Sand-Attack", "Faint Attack", "Sand Tomb"], 9: ["Sand-Attack"], 17: ["Faint Attack"], 25: ["Sand Tomb"], 33: ["Crunch"], 35: ["DragonBreath"], 41: ["Screech"], 49: ["Sandstrom"], 57: ["Hyper Beam"]}
const flygon: Array = ["Flygon", ["Ground", "Dragon"], 80, 100, 80, 80, 80, 100, 197]
const flygon_lernset: Dictionary = {1: ["Bite", "Sand-Attack", "Faint Attack", "Sand Tomb"], 9: ["Sand-Attack"], 17: ["Faint Attack"], 25: ["Sand Tomb"], 33: ["Crunch"], 35: ["DragonBreath"], 41: ["Screech"], 53: ["Sandstrom"], 65: ["Hyper Beam"]}

const cacnea: Array = ["Canea", ["Grass"], 50, 85, 40, 85, 40, 35, 97]
const cacnea_lernset: Dictionary = {1: ["Poison Sting", "Leer"], 5: ["Absorb"], 9: ["Growth"], 13: ["Leech Seed"], 17: ["Sand Attack"], 21: ["Pin Missile"], 25: ["Ingrain"], 29: ["Faint Attack"], 33: ["Spikes"], 37: ["Needle Arm"], 41: ["Cotton Spore"], 45: ["Sandstorm"], 49: ["Destiny Bond"]}
const cacturne: Array = ["Cacturne", ["Grass", "Dark"], 70, 115, 60, 115, 60, 55, 177]
const cacturne_lernset: Dictionary = {1: ["Revenge", "Poison Sting", "Leer", "Absorb", "Growth"], 5: ["Absorb"], 9: ["Growth"], 13: ["Leech Seed"], 17: ["Sand-Attack"], 21: ["Pin Missile"], 25: ["Ingrain"], 29: ["Faint Attack"], 35: ["Spikes"], 41: ["Needle Arm"], 47: ["Cotton Spore"], 53: ["Sandstorm"], 59: ["Destiny Bond"]}

const swablu: Array = ["Swablu", ["Normal", "Flying"], 45, 40, 60, 40, 75, 50, 74]
const swablu_lernset: Dictionary = {1: ["Peck", "Growl"], 8: ["Astonish"], 11: ["Sing"], 18: ["Fry Attack"], 21: ["Safeguard"], 28: ["Mist"], 31: ["Take Down"], 38: ["Mirror Move"], 41: ["Refresh"], 48: ["Perish Song"]}
const altaria: Array = ["Altaria", ["Dragon", "Flying"], 75, 70, 90, 70, 105, 80, 188]
const altaria_lernset: Dictionary = {1: ["Peck", "Growl", "Astonish", "Sing"], 8: ["Astonish"], 11: ["Sing"], 18: ["Fury Attack"], 21: ["Safeguard"], 28: ["Mist"], 31: ["Take Down"], 35: ["DragonBreath"], 40: ["Dragon Dance"], 45: ["Refresh"], 54: ["Perish Song"], 59: ["Sky Attack"]}

const zangoose: Array = ["Zangoose", ["Normal"], 73, 115, 60, 60, 60, 90, 165]
const zangoose_lernset: Dictionary = {1: ["Sratch"], 4: ["Leer"], 7: ["Quick Attack"], 10: ["Swords Dance"], 13: ["Fury Cutter"], 19: ["Slash"], 25: ["Pursuit"], 31: ["Cursh Claw"], 37: ["Taunt"], 46: ["Detect"], 55: ["False Swipe"]}

const seviper: Array = ["Seviper", ["Poison"], 73, 100, 60, 100, 60, 65, 165]
const seviper_lernset: Dictionary = {1: ["Wrap"], 7: ["Lick"], 10: ["Bite"], 16: ["Poison Tail"], 19: ["Screech"], 25: ["Glare"], 28: ["Crunch"], 34: ["Poison Fang"], 37: ["Swagger"], 43: ["Haze"]}

const lunaton: Array = ["Lunatone", ["Rock", "Psychic"], 90, 55, 65, 95, 85, 70, 150]
const lunatone_lernset: Dictionary = {1: ["Tackle", "Harden"], 7: ["Confusion"], 13: ["Rock Throw"], 19: ["Hypnosis"], 25: ["Psywave"], 31: ["Cosmic Power"], 37: ["Psychic"], 43: ["Future Sight"], 49: ["Explosion"]}
const solrock: Array = ["Solrock", ["Rock", "Psychic"], 90, 95, 85, 55, 65, 70, 92]
const solrock_lernset: Dictionary = {1: ["Tackle", "Harden"], 7: ["Confusion"], 13: ["Rock Throw"], 19: ["Fire Spin"], 25: ["Psywave"], 31: ["Cosmic Power"], 37: ["Rock Slide"], 43: ["Solar Beam"], 49: ["Explosion"]}

const barboach: Array = ["Barboach", ["Water", "Ground"], 50, 48, 43, 46, 41, 60, 92]
const barboach_lernset: Dictionary = {1: ["Mud-Slap"], 6: ["Mud Sport", "Water Sport"], 11: ["Water Gun"], 16: ["Magnitude"], 21: ["Amnesia"], 26: ["Rest", "Snore"], 31: ["Earthquake"], 36: ["Future Sight"], 41: ["Fissure"]}

const whiscash: Array = ["Whiscash", ["Water", "Ground"], 110, 78, 73, 76, 71, 60, 158]
const whiscash_lernset: Dictionary = {1: ["Tickle", "Mud-Slap", "Mud Sport", "Water Sport"], 6: ["Mud Sport", "Water Sport"], 11: ["Water Gun"], 16: ["Magnitude"], 21: ["Amnesia"], 26: ["Rest", "Snore"], 36: ["Earthquake"], 46: ["Future Sight"], 56: ["Fissure"]}

const corphish: Array = ["Corphish", ["Water"], 43, 80, 65, 50, 35, 35, 111]
const corphish_lernset: Dictionary = {1: ["Bubble"], 7: ["Harden"], 10: ["ViceGrip"], 13: ["leer"], 19: ["BubbleBeam"], 22: ["Protect"], 25: ["Knock Off"], 31: ["Taunt"], 34: ["Crabhammer"], 37: ["Swords Dance"], 43: ["Crunch"], 46: ["Guillotine"]}
const crawdaunt: Array = ["Crawdaunt", ["Water", "Dark"], 63, 120, 85, 90, 55, 55, 161]
const crawdaunt_lernset: Dictionary = {1: ["Bubble", "Harden", "ViceGrip", "Leer"], 7: ["Harden"], 10: ["ViceGrip"], 13: ["Leer"], 19: ["BubbleBeam"], 22: ["Protect"], 25: ["Knock Off"], 33: ["Taunt"], 38: ["Cramhammer"], 43: ["Swords Dance"], 51: ["Crunch"], 56: ["Guillotine"]}

const baltoy: Array = ["Baltoy", ["Ground", "Psychic"], 40, 40, 55, 40, 70, 55, 58]
const baltoy_lernset: Dictionary = {1: ["Confusion"], 3: ["Harden"], 5: ["Rapid Spin"], 7: ["Mud-Slap"], 11: ["Psybeam"], 15: ["Rock Tomb"], 19: ["Selfdestruct"], 25: ["AncientPower"], 31: ["Sandstrom"], 37: ["Cosmic Power"], 45: ["Explosion"]}

const claydol: Array = ["Claydol", ["Ground", "Psychic"], 60, 70, 105, 70, 120, 75, 189]
const claydol_lernset: Dictionary = {1: ["Teleport", "Confusion", "Harden", "Rapid Spin"], 3: ["Harden"], 5: ["Rapid Spin"], 7: ["Mud-Slap"], 11: ["Psybeam"], 15: ["Rock Tomb"], 19: ["Selfdestruct"], 25: ["AncientPower"], 31: ["Sandstorm"], 36: ["Hyper Beam"], 42: ["Cosmic Power"], 55: ["Explosion"]}

const lileep: Array = ["Lileep", ["Rock", "Grass"], 66, 41, 7, 61, 87, 23, 121]
const lileep_lernset: Dictionary = {1: ["Astonish"], 8: ["Constrict"], 15: ["Acid"], 22: ["Ingrain"], 29: ["Confuse Ray"], 36: ["Amnesia"], 43: ["AncientPower"], 50: ["Stockpile", "Swallow", "Spit Up"]}
const cradily: Array = ["Cradily", ["Rock", "Grass"], 86, 81, 97, 81, 107, 43, 201]
const cradily_lernset: Dictionary = {1: ["Astonish", "Constrict", "Acid", "Ingrain"], 8: ["Constrict"], 15: ["Acid"], 22: ["Ingrain"], 29: ["Confuse Ray"], 36: ["Amnesia"], 48: ["AncientPower"], 60: ["Stockpile", "Swallow", "Spit Up"]}

const anorith: Array = ["Anorith", ["Rock", "Bug"], 45, 95, 50, 40, 50, 75, 119]
const anorith_lernset: Dictionary = {1: ["Scratch"], 7: ["Harden"], 13: ["Mud Sport"], 19: ["Water Gun"], 25: ["Metal Claw"], 31: ["Protect"], 37: ["AncientPower"], 43: ["Fury Cutter"], 49: ["Slash"], 55: ["Rock Blast"]}
const armaldo: Array = ["Armaldo", ["Rock", "Bug"], 75, 125, 100, 70, 80, 45, 200]
const armaldo_lernset: Dictionary = {1: ["Scratch", "Harden", "Mud Sport", "Water Gun"], 7: ["Harden"], 13: ["Mud Sport"], 19: ["Water Gun"], 25: ["Metal Claw"], 31: ["Protect"], 37: ["AncientPower"], 46: ["Fury Cutter"], 55: ["Slash"], 64: ["Rock Blast"]}

const feebas: Array = ["Feebas", ["Water"], 20, 15, 20, 10, 55, 80, 61]
const feebas_lernset: Dictionary = {1: ["Spash"], 15: ["Tackle"], 30: ["Flail"]}

const milotic: Array = ["Milotic", ["Water"], 95, 60, 79, 100, 125, 81, 213]
const milotic_lernset: Dictionary = {1: ["Water Gun"], 5: ["Wrap"], 10: ["Water Sport"], 15: ["Refresh"], 20: ["Water Pulse"], 25: ["Twister"], 30: ["Recover"], 35: ["Rain Dance"], 40: ["Hydro Pump"], 45: ["Attract"], 50: ["Safeguard"]}

const castform: Array = ["Castform", ["Normal"], 70, 70, 70, 70, 70, 70, 145]
const castfrom_lernset: Dictionary = {1: ["Tackle"], 10: ["Water Gun", "Ember", "Powder Snow"], 20: ["Rain Dance", "Sunny Dance", "Hail"], 30: ["Weather Ball"]}

const kecleon: Array = ["Kecleon", ["Normal"], 60, 90, 70, 60, 120, 40, 132]
const kecleon_lernset: Dictionary = {1: ["Thief", "Scratch", "Tail Whip", "Astonish", "Lick"], 4: ["Bind"], 7: ["Faint Attack"], 12: ["Fury Swipes"], 17: ["Psybeam"], 24: ["Sreech"], 31: ["Slash"], 40: ["Substitue"], 49: ["Ancient Power"]}

const shuppet: Array = ["Shppet", ["Ghost"], 44, 75, 35, 63, 33, 45, 97]
const shuppet_lernset: Dictionary = {1: ["Knock Off"], 8: ["Screech"], 13: ["Night Shade"], 20: ["Curse"], 25: ["Spite"], 32: ["Will-O-Whisp"], 37: ["Faint Attack"], 44: ["Shadow Ball"], 49: ["Snatch"], 56: ["Grudge"]}

const banette: Array = ["Banette", ["Ghost"], 64, 115, 65, 83, 63, 65, 179]
const banette_lernset: Dictionary = {1: ["Knock Off", "Screech", "Night Shade", "Curse"], 8: ["Screech"], 13: ["Night Shade"], 20: ["Curse"], 25: ["Spite"], 32: ["Will-O-Wisp"], 39: ["Faint Attack"], 48: ["Shadow Ball"], 55: ["Snatch"], 64: ["Grudge"]}

const duskull: Array = ["Duskull", ["Ghost"], 20, 40, 90, 30, 90, 25, 97]
const duskull_lernset: Dictionary = {1: ["Leer", "Night Shade"], 5: ["Disable"], 12: ["Foresight"], 16: ["Astonish"], 23: ["Confuse Ray"], 27: ["Pursuit"], 34: ["Curse"], 38: ["Will-O-Wisp"], 45: ["Mean Look"], 49: ["Future Sight"]}
const dusclops: Array = ["Dusclops", ["Ghost"], 40, 70, 130, 60, 130, 25, 179]
const dusclops_lernset: Dictionary = {1: ["Bind", "Leer", "Night Shade", "Disable"], 5: ["Disable"], 12: ["Foresight"], 16: ["Astonish"], 23: ["Confuse Ray"], 27: ["Pursuit"], 34: ["Curse"], 37: ["Shadow Punch"], 41: ["Will-O-Wisp"], 51: ["Mean Look"], 58: ["Future Sight"]}

const tropius: Array = ["Tropius", ["Grass", "Flying"], 99, 68, 83, 72, 87, 51, 169]
const tropius_lernset: Dictionary = {1: ["Leer", "gust"], 7: ["Growth"], 11: ["Razor Leaf"], 17: ["Stomp"], 21: ["Sweet Scent"], 27: ["Whirlwind"], 31: ["Magical Leaf"], 37: ["Body Slam"], 41: ["SolarBeam"], 47: ["Synthesis"]}
const chimecho: Array = ["Chimecho", ["Psychic"], 75, 50, 80, 95, 90, 65, 147]
const chimecho_lernset: Dictionary = {1: ["Warp"], 6: ["Growl"], 9: ["Astonish"], 14: ["Confusion"], 17: ["Take Down"], 22: ["Uproar"], 25: ["Yawn"], 30: ["Psywave"], 33: ["Double-Edge"], 38: ["Heal Bell"], 41: ["Safeguard"], 46: ["Psychic"]}

const absol: Array = ["Absol", ["Dark"], 65, 130, 60, 75, 60, 75, 174]
const absol_lernset: Dictionary = {1: ["Scratch"], 5: ["Leer"], 9: ["Taunt"], 13: ["Quick Attack"], 17: ["Razor Wind"], 21: ["Bite"], 26: ["Swords Dance"], 31: ["Double Team"], 36: ["Slash"], 41: ["Future Sight"], 46: ["Perish Song"]}
const wynaut: Array = ["Wynaut", ["Psychic"], 95, 23, 48, 23, 48, 23, 44]
const wynaut_lernset: Dictionary = {1: ["Splash", "Charm", "Encore"], 15: ["Counter", "Mirror Coat", "Safeguard", "Destiny Bond"]}

const snorunt: Array = ["Snorunt", ["Ice"], 50, 50, 50, 50, 50, 50, 74]
const snorunt_lernset: Dictionary = {1: ["Power Snow", "Leer"], 7: ["Double Team"], 10: ["Bite"], 16: ["Icy Wind"], 19: ["Headbutt"], 25: ["Protect"], 28: ["Crunch"], 34: ["Ice Beam"], 37: ["Hail"], 43: ["Blizzard"]}

const glalie: Array = ["Glalie", ["Ice"], 80, 80, 80, 80, 80, 80, 187]
const glalie_lernset: Dictionary = {1: ["Power Snow", "Leer", "Double Team", "Bite"], 7: ["Double Team"], 10: ["Bite"], 16: ["Icy Wind"], 19: ["Headbutt"], 25: ["Protect"], 28: ["Crunch"], 34: ["Ice Beam"], 42: ["Hail"], 53: ["Blizzard"], 61: ["Sheer Cold"]}

const spheal: Array = ["Spheal", ["Ice", "Water"], 70, 40, 50, 55, 50, 25, 75]
const spheal_lernset: Dictionary = {1: ["Power Snow", "Growl", "Water Gun", "Defense Curl"], 7: ["Encore"], 13: ["Ice Ball"], 19: ["Body Slam"], 25: ["Aurora Beam"], 31: ["Hail"], 37: ["Rest", "Snore"], 43: ["Blizzard"], 49: ["Sheer Cold"]}
const sealeo: Array = ["Sealeo", ["Ice", "Water"], 90, 60, 70, 75, 70, 45, 128]
const sealeo_lernset: Dictionary = {1: ["Power Snow", "Growl", "Water Gun", "Encore", "Defense Curl"], 7: ["Encore"], 13: ["Ice Ball"], 19: ["Body Slam"], 25: ["Aurora Beam"], 31: ["Hail"], 39: ["Rest", "Snore"], 47: ["Blizzard"], 55: ["Sheer Cold"]}
const walrein: Array = ["Walrein", ["Ice", "Water"], 110, 80, 90, 95, 90, 65, 192]
const walrein_lernset: Dictionary = {1: ["Power Snow", "Growl", "Water Gun", "Encore", "Defense Curl"], 7: ["Encore"], 13: ["Ice Ball"], 19: ["Body Slam"], 25: ["Aurora Beam"], 31: ["Hail"], 39: ["Rest", "Snore"], 50: ["Blizzard"], 61: ["Sheer Cold"]}

const clamperl: Array = ["Clamperl", ["Water"], 35, 64, 85, 74, 55, 32, 142]
const clamperl_lernset: Dictionary = {1: ["Clamp", "Iron Defense", "Water Gun", "Whirlpool"]}

const huntail: Array = ["Huntail", ["Water"], 55, 104, 105, 94, 75, 52, 178]
const huntail_lernset: Dictionary = {1: ["Whirlpool"], 8: ["Bite"], 15: ["Screech"], 22: ["Water Pulse"], 29: ["Sacry Face"], 36: ["Crunch"], 43: ["Baton Pass"], 50: ["Hydro Pump"]}

const gorebyss: Array = ["Gorebyss", ["Water"], 55, 84, 105, 114, 75, 52, 178]
const gorebyss_lernset: Dictionary = {1: ["Whirlpool"], 8: ["Confusion"], 15: ["Agility"], 22: ["Water Pulse"], 29: ["Amnesia"], 36: ["Psychic"], 43: ["Baton Pass"], 50: ["Hydro Pump"]}

const relicanth: Array = ["Relicanth", ["Water", "Rock"], 100, 90, 130, 45, 65, 55, 198]
const relicanth_lernset: Dictionary = {1: ["Harden", "Tackle"], 8: ["Water Gun"], 15: ["Rock Tomb"], 22: ["Yawn"], 29: ["Take Down"], 36: ["Mud Sport"], 43: ["AncientPower"], 50: ["Rest"], 57: ["Double-Edge"], 64: ["Hydro Pump"]}

const luvdisc: Array = ["Luvdisc", ["Water"], 43, 30, 55, 40, 65, 97, 110]
const luvdisc_lernset: Dictionary = {1: ["Tackle"], 4: ["Charm"], 12: ["Water Gun"], 16: ["Agility"], 24: ["Take Down"], 28: ["Attract"], 36: ["Sweet Kiss"], 40: ["Flail"], 48: ["Safeguard"]}

const bagon: Array = ["Bagon", ["Dragon"], 45, 75, 60, 40, 30, 50, 89]
const bagon_lernset: Dictionary = {1: ["Rage"], 5: ["Bite"], 9: ["Leer"], 17: ["Headbutt"], 21: ["Focus Energy"], 25: ["Ember"], 33: ["DragonBreath"], 37: ["Scray Face"], 41: ["Crunch"], 49: ["Dragon Claw"], 53: ["Double-Edge"]}
const shelgon: Array = ["Shelgon", ["Dragon"], 65, 95, 100, 60, 50, 50, 144]
const shelgon_lernset: Dictionary = {1: ["Rage", "Bite", "Leer", "Headbutt"], 5: ["Bite"], 9: ["Leer"], 17: ["Headbutt"], 21: ["Focus Energy"], 25: ["Ember"], 30: ["Protect"], 38: ["DragonBreath"], 47: ["Scary Face"], 56: ["Crunch"], 69: ["Dragon Claw"], 78: ["Double-Edge"]}
const salamence: Array = ["Salamence", ["Dragon", "Flying"], 95, 135, 80, 110, 80, 100, 218]
const salamence_lernset: Dictionary = {1: ["Rage", "Bite", "Leer", "Headbutt"], 5: ["Bite"], 9: ["Leer"], 17: ["Headbutt"], 21: ["Focus Energy"], 25: ["Ember"], 30: ["Protect"], 38: ["DragonBreath"], 47: ["Scary Face"], 50: ["Fly"], 61: ["Crunch"], 79: ["Dragon Claw"], 93: ["Double-Edge"]}

const beldum: Array = ["Beldum", ["Steel", "Psychic"], 40, 55, 80, 35, 60, 30, 103]
const beldum_lernset: Dictionary = {1: ["Take Down"]}
const metang: Array = ["Metan", ["Steel", "Psychic"], 60, 75, 100, 55, 80, 50, 153]
const metang_lernset: Dictionary = {1: ["Take Down"], 20: ["Confusion", "Metal Claw"], 26: ["Scary Face"], 32: ["Pursuit"], 38: ["Psychic"], 44: ["Iron Defense"], 50: ["Meteor Mash"], 56: ["Agility"], 62: ["Hyper Beam"]}
const metagross: Array = ["Metagross", ["Steel", "Psychic"], 80, 135, 130, 95, 90, 70, 210]
const metagross_lernset: Dictionary = {1: ["Take Down", "Confusion", "Metal Claw", "Scary Face"], 20: ["Confusion", "Metal Claw"], 26: ["Scary Face"], 32: ["Pursuit"], 38: ["Psychic"], 44: ["Iron Defense"], 55: ["Meteor Mash"], 66: ["Agility"], 77: ["Hyper Beam"]}

const regirock: Array = ["Regirock", ["Rock"], 80, 100, 200, 50, 100, 50, 217]
const regirock_lernset: Dictionary = {1: ["Explosion"], 9: ["Rock Throw"], 17: ["Curse"], 25: ["Superpower"], 33: ["Ancient Power"], 41: ["Iron Defense"], 49: ["Zap Cannon"], 57: ["Lock-On"], 65: ["Hyper Beam"]}
const regice: Array = ["Regice", ["Ice"], 80, 50, 100, 100, 200, 50, 216]
const regice_lernset: Dictionary = {1: ["Explosion"], 9: ["Icy Wind"], 17: ["Curse"], 25: ["Superpower"], 33: ["AncientPower"], 41: ["Amnesia"], 49: ["Zap Cannon"], 57: ["Lock-On"], 65: ["Hyper Beam"]}
const registeel: Array = ["Registeel", ["Steel"], 80, 75, 150, 75, 150, 50, 215]
const registeel_lernset: Dictionary = {1: ["Explosion"], 9: ["Metal Claw"], 17: ["Curse"], 25: ["Superpower"], 33: ["AncientPower"], 41: ["Amnesia"], 49: ["Zap Cannon"], 57: ["Lock-On"], 65: ["Hyper Beam"]}

const latias: Array = ["Latias", ["Dragon", "Psychic"], 80, 80, 90, 110, 130, 110, 211]
const latias_lernset: Dictionary = {1: ["Psywave"], 5: ["Wish"], 10: ["Helping Hand"], 15: ["Safeguard"], 20: ["DragonBreath"], 25: ["Water Sport"], 30: ["Refresh"], 35: ["Mist Ball"], 40: ["Psychic"], 45: ["Recover"], 50: ["Charm"]}
const latios: Array = ["Latios", ["Dragon", "Psychic"], 80, 90, 80, 130, 110, 110, 211]
const latios_lernset: Dictionary = {1: ["Psywave"], 5: ["Memento"], 10: ["Helping Hand"], 15: ["Safeguard"], 20: ["DragonBreath"], 25: ["Protect"], 30: ["Refresh"], 35: ["Luster Purge"], 40: ["Psychic"], 45: ["Recover"], 50: ["Dragon Dance"]}

const kyogre: Array = ["Kyogre", ["Water"], 100, 100, 90, 150, 140, 90, 218]
const kyogre_lernset: Dictionary = {1: ["Water Pulse"], 5: ["Scary Face"], 15: ["AncientPower"], 20: ["Body Slam"], 30: ["Calm Mind"], 35: ["Ice Beam"], 45: ["Hydro Pump"], 50: ["Rest"], 60: ["Sheer Cold"], 65: ["Double-Edge"], 75: ["Water Spout"]}

const groudon: Array = ["Ground", ["Ground"], 100, 150, 140, 100, 90, 90, 218]
const groudon_lernset: Dictionary = {1: ["Mud Shot"], 5: ["Scary Face"], 15: ["Ancient Power"], 20: ["Slash"], 30: ["Bulk Up"], 35: ["Earthquake"], 45: ["Fire Balst"], 50: ["Rest"], 60: ["Fissure"], 65: ["SolarBeam"], 75: ["Eruption"]}

const rayquaza: Array = ["Rayquaza", ["Dragon", "Flying"], 105, 150, 90, 150, 90, 95, 220]
const rayquaza_lernset: Dictionary = {1: ["Twister"], 5: ["Scary Face"], 15: ["Ancient Power"], 20: ["Dragon Claw"], 30: ["Dragon Dance"], 35: ["Crunch"], 45: ["Fly"], 50: ["Rest"], 60: ["ExtremeSpeed"], 65: ["Outrage"], 75: ["Hyper Beam"]}

const jirachi: Array = ["Jirachi", ["Steel", "Psychic"], 100, 100, 100, 100, 100, 100, 215]
const jirachi_lernset: Dictionary = {1: ["Wish", "Confusion"], 5: ["Rest"], 10: ["Swift"], 15: ["Helping Hand"], 20: ["Psychic"], 25: ["Refresh"], 30: ["Rest"], 35: ["Double-Edge"], 40: ["Future Sight"], 45: ["Cosmic Power"], 50: ["Doom Desire"]}

const deoxys: Array = ["Deoxys", ["Psychic"], 50, 150, 50, 150, 50, 150, 215]
const deoxys_lernset: Dictionary = {1: ["Leer", "Warp"], 5: ["Night Shade"], 10: ["Teleport"], 15: ["Knock Off"], 20: ["Pursuit"], 25: ["Psychic"], 30: ["Snatch"], 35: ["Cosmic Power"], 40: ["Recover"], 45: ["Psycho Boost"], 50: ["Hyper Beam"]}


const pokemon: Array = [treecko, grovyle, sceptile, torchic, combusken, blaziken, mudkip, marshtomp, swampert, poochyena, mightyena, zigzagoon, linoone, wurmple, silcoon, beautifly, cascoon, dustox, lotad, lombre, ludicolo, seedot, nuzleaf, shiftry, taillow, swellow, wingull, pelipper, ralts, kirlia, gardevoir, surskit, masquerain, shroomish, breloom, slakoth, vigoroth, slaking, nicada, ninjask, shedinja, whismur, loudred, exploud, makuhita, hariyama, azurill, nosepass, skitty, delcatty, sabyele, mawile, aron, lairon, aggron, meditite, medicham, electrike, menectric, plusle, minun, volbeat, illumise, roselia, gulpin, swalot, carvanha, sharpedo, wailmer, wailord, numel, camerupt, torkoal, spoink, grumpig, spinda, trapinch, vibrava, flygon, cacnea, cacturne, swablu, altaria, zangoose, seviper, lunaton, solrock, barboach, whiscash, corphish, crawdaunt, baltoy, claydol, lileep, cradily, anorith, armaldo, feebas, milotic, castform, kecleon, shuppet, banette, duskull, dusclops, tropius, chimecho, absol, wynaut, snorunt, glalie, spheal, sealeo, walrein, clamperl, huntail, gorebyss, relicanth, luvdisc, bagon, shelgon, salamence, beldum, metang, metagross, regirock, regice, registeel, latias, latios, kyogre, groudon, rayquaza, jirachi, deoxys]
const pokemon_lernset: Array = [treecko_lernset, groudon_lernset, sceptile_lernset, torchic_lernset, combusken_lernset, blaziken_lernset, mudkip_lernset, marshtomp_lernset, swampert_lernset, poochyena_lernset, mightyena_lernset, zigzagoon_lernset, linoone_lernset, wurmple_lernset, silcoon_lernset, beautifly_lernset, cascoon_lernset, dustox_lernset, lotad_lernset, lombre_lernset, ludicolo_lernset, seedot_lernset, nuzleaf_lernset, shiftry_lernset, taillow_lernset, swellow_lernset, wingull_lernset, pelipper_lernset, ralts_lernset, kirlia_lernset, gardevoir_lernset, surskit_lernset, masquerain_lernset, shroomish_lernset, breloom_lernset, slakoth_lernset, vigoroth_lernset, slaking_lernset, nincada_lernset, ninjask_lernset, shedinja_lernset, whismur_lernset, loudred_lernset, exploud_lernset, makuhita_lernset, hariyama_lernset, azurill_lernset, nosepass_lernset, skitty_lernset, delcatty_lernset, sableye_lernset, mawile_lernset, aron_lernset, lairon_lernset, aggron_lernset, meditite_lernset, medicahm_lernset, electrike_lernset, manectric_lernset, plusle_lernset, minun_lernset, volbeat_lernset, illumise_lernset, roselia_lernset, gulpin_lernset, swalot_lernset, carvanha_lernset, sharpedo_lernset, wailmer_lernset, wailord_lernset, numel_lernset, camerupt_lernset, torkoal_lernset, spoink_lernset, grumpig_lernset, spinda_lernset, trapinch_lernset, vibrava_lernset, flygon_lernset, cacturne_lernset, swablu_lernset, altaria_lernset, zangoose_lernset, seviper_lernset, lunatone_lernset, solrock_lernset, barboach_lernset, whiscash_lernset, corphish_lernset, crawdaunt_lernset, baltoy_lernset, claydol_lernset, lileep_lernset, cradily_lernset, anorith_lernset, armaldo_lernset, feebas_lernset, milotic_lernset, castfrom_lernset, kecleon_lernset, shuppet_lernset, banette_lernset, duskull_lernset, dusclops_lernset, tropius_lernset, chimecho_lernset, absol_lernset, wynaut_lernset, snorunt_lernset, glalie_lernset, spheal_lernset, walrein_lernset, clamperl_lernset, huntail_lernset, gorebyss_lernset, relicanth_lernset, luvdisc_lernset, bagon_lernset, shelgon_lernset, salamence_lernset, beldum_lernset, metagross_lernset, regirock_lernset, regice_lernset, registeel_lernset, latias_lernset, latios_lernset, kyogre_lernset, rayquaza_lernset, jirachi_lernset, deoxys_lernset]

const pokemon_front_sprite: Array = [preload("res://battle_assets/pokemon/treecko/anim_front.png"), preload("res://battle_assets/pokemon/grovyle/anim_front.png"), preload("res://battle_assets/pokemon/sceptile/anim_front.png"), preload("res://battle_assets/pokemon/torchic/anim_front.png"), preload("res://battle_assets/pokemon/combusken/anim_front.png"), preload("res://battle_assets/pokemon/blaziken/anim_front.png"), preload("res://battle_assets/pokemon/mudkip/anim_front.png"), preload("res://battle_assets/pokemon/marshtomp/anim_front.png"), preload("res://battle_assets/pokemon/swampert/anim_front.png"), preload("res://battle_assets/pokemon/poochyena/anim_front.png"), preload("res://battle_assets/pokemon/mightyena/anim_front.png"), preload("res://battle_assets/pokemon/zigzagoon/anim_front.png"), preload("res://battle_assets/pokemon/linoone/anim_front.png"), preload("res://battle_assets/pokemon/wurmple/anim_front.png"), preload("res://battle_assets/pokemon/silcoon/anim_front.png"), preload("res://battle_assets/pokemon/beautifly/anim_front.png"), preload("res://battle_assets/pokemon/cascoon/anim_front.png"), preload("res://battle_assets/pokemon/dustox/anim_front.png"), preload("res://battle_assets/pokemon/lotad/anim_front.png"), preload("res://battle_assets/pokemon/lombre/anim_front.png"), preload("res://battle_assets/pokemon/ludicolo/anim_front.png"), preload("res://battle_assets/pokemon/seedot/anim_front.png"), preload("res://battle_assets/pokemon/nuzleaf/anim_front.png"), preload("res://battle_assets/pokemon/shiftry/anim_front.png"), preload("res://battle_assets/pokemon/taillow/anim_front.png"), preload("res://battle_assets/pokemon/swellow/anim_front.png"), preload("res://battle_assets/pokemon/wingull/anim_front.png"), preload("res://battle_assets/pokemon/pelipper/anim_front.png"), preload("res://battle_assets/pokemon/ralts/anim_front.png"), preload("res://battle_assets/pokemon/kirlia/anim_front.png"), preload("res://battle_assets/pokemon/gardevoir/anim_front.png"), preload("res://battle_assets/pokemon/surskit/anim_front.png"), preload("res://battle_assets/pokemon/masquerain/anim_front.png"), preload("res://battle_assets/pokemon/shroomish/anim_front.png"), preload("res://battle_assets/pokemon/breloom/anim_front.png"), preload("res://battle_assets/pokemon/slakoth/anim_front.png"), preload("res://battle_assets/pokemon/vigoroth/anim_front.png"), preload("res://battle_assets/pokemon/slaking/anim_front.png"), preload("res://battle_assets/pokemon/nincada/anim_front.png"), preload("res://battle_assets/pokemon/ninjask/anim_front.png"), preload("res://battle_assets/pokemon/shedinja/anim_front.png"), preload("res://battle_assets/pokemon/whismur/anim_front.png"), preload("res://battle_assets/pokemon/loudred/anim_front.png"), preload("res://battle_assets/pokemon/exploud/anim_front.png"), preload("res://battle_assets/pokemon/makuhita/anim_front.png"), preload("res://battle_assets/pokemon/hariyama/anim_front.png"), preload("res://battle_assets/pokemon/azurill/anim_front.png"), preload("res://battle_assets/pokemon/nosepass/anim_front.png"), preload("res://battle_assets/pokemon/skitty/anim_front.png"), preload("res://battle_assets/pokemon/delcatty/anim_front.png"), preload("res://battle_assets/pokemon/sableye/anim_front.png"), preload("res://battle_assets/pokemon/mawile/anim_front.png"), preload("res://battle_assets/pokemon/aron/anim_front.png"), preload("res://battle_assets/pokemon/lairon/anim_front.png"), preload("res://battle_assets/pokemon/aggron/anim_front.png"), preload("res://battle_assets/pokemon/meditite/anim_front.png"), preload("res://battle_assets/pokemon/medicham/anim_front.png"), preload("res://battle_assets/pokemon/electrike/anim_front.png"), preload("res://battle_assets/pokemon/manectric/anim_front.png"), preload("res://battle_assets/pokemon/plusle/anim_front.png"), preload("res://battle_assets/pokemon/minun/anim_front.png"), preload("res://battle_assets/pokemon/volbeat/anim_front.png"), preload("res://battle_assets/pokemon/illumise/anim_front.png"), preload("res://battle_assets/pokemon/roselia/anim_front.png"), preload("res://battle_assets/pokemon/gulpin/anim_front.png"), preload("res://battle_assets/pokemon/swalot/anim_front.png"), preload("res://battle_assets/pokemon/carvanha/anim_front.png"), preload("res://battle_assets/pokemon/sharpedo/anim_front.png"), preload("res://battle_assets/pokemon/wailmer/anim_front.png"), preload("res://battle_assets/pokemon/wailord/anim_front.png"), preload("res://battle_assets/pokemon/numel/anim_front.png"), preload("res://battle_assets/pokemon/camerupt/anim_front.png"), preload("res://battle_assets/pokemon/torkoal/anim_front.png"), preload("res://battle_assets/pokemon/spoink/anim_front.png"), preload("res://battle_assets/pokemon/grumpig/anim_front.png"), preload("res://battle_assets/pokemon/spinda/anim_front.png"), preload("res://battle_assets/pokemon/trapinch/anim_front.png"), preload("res://battle_assets/pokemon/vibrava/anim_front.png"), preload("res://battle_assets/pokemon/flygon/anim_front.png"), preload("res://battle_assets/pokemon/cacnea/anim_front.png"), preload("res://battle_assets/pokemon/cacturne/anim_front.png"), preload("res://battle_assets/pokemon/swablu/anim_front.png"), preload("res://battle_assets/pokemon/altaria/anim_front.png"), preload("res://battle_assets/pokemon/zangoose/anim_front.png"), preload("res://battle_assets/pokemon/seviper/anim_front.png"), preload("res://battle_assets/pokemon/lunatone/anim_front.png"), preload("res://battle_assets/pokemon/solrock/anim_front.png"), preload("res://battle_assets/pokemon/barboach/anim_front.png"), preload("res://battle_assets/pokemon/whiscash/anim_front.png"), preload("res://battle_assets/pokemon/corphish/anim_front.png"), preload("res://battle_assets/pokemon/crawdaunt/anim_front.png"), preload("res://battle_assets/pokemon/baltoy/anim_front.png"), preload("res://battle_assets/pokemon/claydol/anim_front.png"), preload("res://battle_assets/pokemon/lileep/anim_front.png"), preload("res://battle_assets/pokemon/cradily/anim_front.png"), preload("res://battle_assets/pokemon/anorith/anim_front.png"), preload("res://battle_assets/pokemon/armaldo/anim_front.png"), preload("res://battle_assets/pokemon/feebas/anim_front.png"), preload("res://battle_assets/pokemon/milotic/anim_front.png"), preload("res://battle_assets/pokemon/castform/footprint.png"), preload("res://battle_assets/pokemon/kecleon/anim_front.png"), preload("res://battle_assets/pokemon/shuppet/anim_front.png"), preload("res://battle_assets/pokemon/banette/anim_front.png"), preload("res://battle_assets/pokemon/duskull/anim_front.png"), preload("res://battle_assets/pokemon/dusclops/anim_front.png"), preload("res://battle_assets/pokemon/tropius/anim_front.png"), preload("res://battle_assets/pokemon/chimecho/anim_front.png"), preload("res://battle_assets/pokemon/absol/anim_front.png"), preload("res://battle_assets/pokemon/wynaut/anim_front.png"), preload("res://battle_assets/pokemon/snorunt/anim_front.png"), preload("res://battle_assets/pokemon/glalie/anim_front.png"), preload("res://battle_assets/pokemon/spheal/anim_front.png"), preload("res://battle_assets/pokemon/sealeo/anim_front.png"), preload("res://battle_assets/pokemon/walrein/anim_front.png"), preload("res://battle_assets/pokemon/clamperl/anim_front.png"), preload("res://battle_assets/pokemon/huntail/anim_front.png"), preload("res://battle_assets/pokemon/gorebyss/anim_front.png"), preload("res://battle_assets/pokemon/relicanth/anim_front.png"), preload("res://battle_assets/pokemon/luvdisc/anim_front.png"), preload("res://battle_assets/pokemon/bagon/anim_front.png"), preload("res://battle_assets/pokemon/shelgon/anim_front.png"), preload("res://battle_assets/pokemon/salamence/anim_front.png"), preload("res://battle_assets/pokemon/beldum/anim_front.png"), preload("res://battle_assets/pokemon/metang/anim_front.png"), preload("res://battle_assets/pokemon/metagross/anim_front.png"), preload("res://battle_assets/pokemon/regirock/anim_front.png"), preload("res://battle_assets/pokemon/regice/anim_front.png"), preload("res://battle_assets/pokemon/registeel/anim_front.png"), preload("res://battle_assets/pokemon/latias/anim_front.png"), preload("res://battle_assets/pokemon/latios/anim_front.png"), preload("res://battle_assets/pokemon/kyogre/anim_front.png"), preload("res://battle_assets/pokemon/groudon/anim_front.png"), preload("res://battle_assets/pokemon/rayquaza/anim_front.png"), preload("res://battle_assets/pokemon/jirachi/anim_front.png"), preload("res://battle_assets/pokemon/deoxys/anim_front.png")]
const pokemon_back_sprite: Array = [preload("res://battle_assets/pokemon/treecko/back.png"), preload("res://battle_assets/pokemon/grovyle/back.png"), preload("res://battle_assets/pokemon/sceptile/back.png"), preload("res://battle_assets/pokemon/torchic/back.png"), preload("res://battle_assets/pokemon/combusken/back.png"), preload("res://battle_assets/pokemon/blaziken/back.png"), preload("res://battle_assets/pokemon/mudkip/back.png"), preload("res://battle_assets/pokemon/marshtomp/back.png"), preload("res://battle_assets/pokemon/swampert/back.png"), preload("res://battle_assets/pokemon/poochyena/back.png"), preload("res://battle_assets/pokemon/mightyena/back.png"), preload("res://battle_assets/pokemon/zigzagoon/back.png"), preload("res://battle_assets/pokemon/linoone/back.png"), preload("res://battle_assets/pokemon/wurmple/back.png"), preload("res://battle_assets/pokemon/silcoon/back.png"), preload("res://battle_assets/pokemon/beautifly/back.png"), preload("res://battle_assets/pokemon/cascoon/back.png"), preload("res://battle_assets/pokemon/dustox/back.png"), preload("res://battle_assets/pokemon/lotad/back.png"), preload("res://battle_assets/pokemon/lombre/back.png"), preload("res://battle_assets/pokemon/ludicolo/back.png"), preload("res://battle_assets/pokemon/seedot/back.png"), preload("res://battle_assets/pokemon/nuzleaf/back.png"), preload("res://battle_assets/pokemon/shiftry/back.png"), preload("res://battle_assets/pokemon/taillow/back.png"), preload("res://battle_assets/pokemon/swellow/back.png"), preload("res://battle_assets/pokemon/wingull/back.png"), preload("res://battle_assets/pokemon/pelipper/back.png"), preload("res://battle_assets/pokemon/ralts/back.png"), preload("res://battle_assets/pokemon/kirlia/back.png"), preload("res://battle_assets/pokemon/gardevoir/back.png"), preload("res://battle_assets/pokemon/surskit/back.png"), preload("res://battle_assets/pokemon/masquerain/back.png"), preload("res://battle_assets/pokemon/shroomish/back.png"), preload("res://battle_assets/pokemon/breloom/back.png"), preload("res://battle_assets/pokemon/slakoth/back.png"), preload("res://battle_assets/pokemon/vigoroth/back.png"), preload("res://battle_assets/pokemon/slaking/back.png"), preload("res://battle_assets/pokemon/nincada/back.png"), preload("res://battle_assets/pokemon/ninjask/back.png"), preload("res://battle_assets/pokemon/shedinja/back.png"), preload("res://battle_assets/pokemon/whismur/back.png"), preload("res://battle_assets/pokemon/loudred/back.png"), preload("res://battle_assets/pokemon/exploud/back.png"), preload("res://battle_assets/pokemon/makuhita/back.png"), preload("res://battle_assets/pokemon/hariyama/back.png"), preload("res://battle_assets/pokemon/azurill/back.png"), preload("res://battle_assets/pokemon/nosepass/back.png"), preload("res://battle_assets/pokemon/skitty/back.png"), preload("res://battle_assets/pokemon/delcatty/back.png"), preload("res://battle_assets/pokemon/sableye/back.png"), preload("res://battle_assets/pokemon/mawile/back.png"), preload("res://battle_assets/pokemon/aron/back.png"), preload("res://battle_assets/pokemon/lairon/back.png"), preload("res://battle_assets/pokemon/aggron/back.png"), preload("res://battle_assets/pokemon/meditite/back.png"), preload("res://battle_assets/pokemon/medicham/back.png"), preload("res://battle_assets/pokemon/electrike/back.png"), preload("res://battle_assets/pokemon/manectric/back.png"), preload("res://battle_assets/pokemon/plusle/back.png"), preload("res://battle_assets/pokemon/minun/back.png"), preload("res://battle_assets/pokemon/volbeat/back.png"), preload("res://battle_assets/pokemon/illumise/back.png"), preload("res://battle_assets/pokemon/roselia/back.png"), preload("res://battle_assets/pokemon/gulpin/back.png"), preload("res://battle_assets/pokemon/swalot/back.png"), preload("res://battle_assets/pokemon/carvanha/back.png"), preload("res://battle_assets/pokemon/sharpedo/back.png"), preload("res://battle_assets/pokemon/wailmer/back.png"), preload("res://battle_assets/pokemon/wailord/back.png"), preload("res://battle_assets/pokemon/numel/back.png"), preload("res://battle_assets/pokemon/camerupt/back.png"), preload("res://battle_assets/pokemon/torkoal/back.png"), preload("res://battle_assets/pokemon/spoink/back.png"), preload("res://battle_assets/pokemon/grumpig/back.png"), preload("res://battle_assets/pokemon/spinda/back.png"), preload("res://battle_assets/pokemon/trapinch/back.png"), preload("res://battle_assets/pokemon/vibrava/back.png"), preload("res://battle_assets/pokemon/flygon/back.png"), preload("res://battle_assets/pokemon/cacnea/back.png"), preload("res://battle_assets/pokemon/cacturne/back.png"), preload("res://battle_assets/pokemon/swablu/back.png"), preload("res://battle_assets/pokemon/altaria/back.png"), preload("res://battle_assets/pokemon/zangoose/back.png"), preload("res://battle_assets/pokemon/seviper/back.png"), preload("res://battle_assets/pokemon/lunatone/back.png"), preload("res://battle_assets/pokemon/solrock/back.png"), preload("res://battle_assets/pokemon/barboach/back.png"), preload("res://battle_assets/pokemon/whiscash/back.png"), preload("res://battle_assets/pokemon/corphish/back.png"), preload("res://battle_assets/pokemon/crawdaunt/back.png"), preload("res://battle_assets/pokemon/baltoy/back.png"), preload("res://battle_assets/pokemon/claydol/back.png"), preload("res://battle_assets/pokemon/lileep/back.png"), preload("res://battle_assets/pokemon/cradily/back.png"), preload("res://battle_assets/pokemon/anorith/back.png"), preload("res://battle_assets/pokemon/armaldo/back.png"), preload("res://battle_assets/pokemon/feebas/back.png"), preload("res://battle_assets/pokemon/milotic/back.png"), preload("res://battle_assets/pokemon/castform/normal/back.png"), preload("res://battle_assets/pokemon/kecleon/back.png"), preload("res://battle_assets/pokemon/shuppet/back.png"), preload("res://battle_assets/pokemon/banette/back.png"), preload("res://battle_assets/pokemon/duskull/back.png"), preload("res://battle_assets/pokemon/dusclops/back.png"), preload("res://battle_assets/pokemon/tropius/back.png"), preload("res://battle_assets/pokemon/chimecho/back.png"), preload("res://battle_assets/pokemon/absol/back.png"), preload("res://battle_assets/pokemon/wynaut/back.png"), preload("res://battle_assets/pokemon/snorunt/back.png"), preload("res://battle_assets/pokemon/glalie/back.png"), preload("res://battle_assets/pokemon/spheal/back.png"), preload("res://battle_assets/pokemon/sealeo/back.png"), preload("res://battle_assets/pokemon/walrein/back.png"), preload("res://battle_assets/pokemon/clamperl/back.png"), preload("res://battle_assets/pokemon/huntail/back.png"), preload("res://battle_assets/pokemon/gorebyss/back.png"), preload("res://battle_assets/pokemon/relicanth/back.png"), preload("res://battle_assets/pokemon/luvdisc/back.png"), preload("res://battle_assets/pokemon/bagon/back.png"), preload("res://battle_assets/pokemon/shelgon/back.png"), preload("res://battle_assets/pokemon/salamence/back.png"), preload("res://battle_assets/pokemon/beldum/back.png"), preload("res://battle_assets/pokemon/metang/back.png"), preload("res://battle_assets/pokemon/metagross/back.png"), preload("res://battle_assets/pokemon/regirock/back.png"), preload("res://battle_assets/pokemon/regice/back.png"), preload("res://battle_assets/pokemon/registeel/back.png"), preload("res://battle_assets/pokemon/latias/back.png"), preload("res://battle_assets/pokemon/latios/back.png"), preload("res://battle_assets/pokemon/kyogre/back.png"), preload("res://battle_assets/pokemon/groudon/back.png"), preload("res://battle_assets/pokemon/rayquaza/back.png"), preload("res://battle_assets/pokemon/jirachi/back.png"), preload("res://battle_assets/pokemon/deoxys/back.png")]
