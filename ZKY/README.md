ZKYs of Saturn
==============

#### About:

This is a compilation of many smaller ideas, combined together so it is easier for me to develop and maintain. This modpack is not intended to be an improvement over the vanilla game, but rather a way to experiment and try new things. Options are provided so users can easily adjust things to their liking. 

As I am continuing to expand and develop this mod, there are aspects that are not yet fully finished. These will be disabled by default, and marked as WIP in this file. These aspects are likely to change drastically, or even be removed entirely. While you are free to enable them, do not depend on their continued existence in future versions.

Note: I am developing this as a learning experience. This mod *will* be less efficient and stable than the base game, use at your own risk. 

###### Installation:

To install, go to the game's installation directory (the directory containing `Delta-V.pck`), and create a new directory called `mods`. Place the mod `.zip` in this `mods` directory, this must be `ZKY.zip` and not an extracted folder.

To run the game with mods, run it with the `--enable-mods` command-line parameter. If using Steam, you can add the parameter in the game's properties → General → Launch Options.

###### Before You Use:

Make sure you back up your saves before using/updating, while I plan on maintaining compatibility as much as possible, I will be changing a lot of things as I learn and develop the mod. Additionally, some modded items will cause the game to crash if you try to load the save on a vanilla installation, you may be able to sidestep this by selling the items before you load the save in a vanilla copy.

###### Mod Compatability:

This mod changes *alot* of things, and will likely conflict with other mods. If you do use other mods, ZKY should always be loaded first, as it needs to modify things in a very specific order. ZKY has a `MOD_PRIORITY` of -100, which should cause it to load before nearly any other mod.

#### Settings:

When first launching the game, the mod will create a configuration file in your savegame directory called `ZKYsettings.cfg`. This file will lets you adjust settings as well as selectively enable/disable parts of the mod. I recommend you use the default settings for most things, but feel free to adjust as you desire.

- The `[modSettings]` and `[modTesting]` categories are for testing/debug and should not be touched unless you know what you're doing.

- `[gameTweaks]` is general adjustments to game behavior that don't have their own category.

- `[additions]` will add things to the game, such as ships, equipment, or events.

- `[cargoTweaks]` will affect the behavior of your processed cargo hold.

- `[eventTweaks]` affects event spawning and behavior.

- `[sillyStuff]` adds things that aren't necessarily good or balanced, but are funny/interesting. I recommend you leave these disabled for a more balanced/vanilla experience. Note: These options assume you have the standard `additions` enabled, and may exhibit unexpected behavior if you do not.

- `[inputs]` lets you customize controls added by the mod.

#### Features:

Items/mechanics added by the mod, relevent settings indicated like this: (`settingName:parameterType`). Please be careful to only use the specified data types, or you may get unexpected behavior.

- 1 New transponder format (`addTransponders:bool`).
- 2 New ship variants in the dealership (`addShips:bool`).
  - `ATK225 "Atlas"`: A variant of the ATK225 that sacrifices the four rear docking bays for two high-stress mounts on the side, the required modifications also remove two of the RCS positions.
  - `OCP-209 (mono-refit)`: A variant of the OCP-209 with a single centrally mounted high-stress hardpoint, two additional drone/cargo mounts are on the back of the cargo bay.
- 6 New minerals to mine (`addMinerals:bool`).
- 4 New Obonto trades (`addMinerals:bool` and `addEvents:bool`) .
- 4 Processed cargo hold behaviors (`processedBehavior:string`):  
  - `default`: Standard behavior, doubles effective cargo hold of non-combined ships.
  - `reduced`: Reduces per-mineral cargo space, maintains effective cargo capacity of non-combined ships.
  - `limited`: Limits ships to X types of processed cargo, maintains effective cargo capacity of non-combined ships.
  - `dynamic`: Limits ships to X processed cargo bays, that can be dynamically allocated to different types of minerals. Maintains effective cargo capacity of non-combined ships, while increasing versitility.
  - `processedTypes:int`: The number of processed cargo bays the ship will have when using `limited` or `dynamic` behaviors (default: 6).
- Dump processed cargo by disabling minerals on the MPU in the geologist menu (`canDumpProcessed:bool`).
- (WIP) Added the ability to keep processed cargo in your ship after a dive (`canKeepProcessed:bool`).
- Click on a mineral in the geologist menu to invert selection (`canToggleColumn:bool`).
- Added the ability to adjust the frequency of events (`oddityAdjust:float`).
- Added the ability to adjust how quickly miners appear at the rim (`diggerAdjust:float`). NOTE: These will naturally decay over the course of gameplay, this option will NOT override that behavior.
- Added a toggle for astrogation being canceled by opening the OMS (`menuStopsAstro:bool`)
- Added the ability to adjust the emergency escape velocity (`escapeVelocity:float`) and when the warning appears (`escapeVelocityWarning:float`).
- Added the ability to remove the map boundries (`disableMapBoundries:bool`).
- Added the ability to adjust the value of minerals, both modded `(modMineralPriceAdjust:float)` and vanilla `(vanillaMineralPriceAdjust:float)`.
- Added the ability to adjust the rate crew gains experience `(xpAdjust:float)`.
- Added a button (default: "R") to flip the autopilot heading 180 degrees, for easier "turn & burn" manuvers `(autopilot_flip_heading:key)`. Thanks to @cxcorp for the original implementation.

#### Silly Features:

- 2 New ship variants:
  
  - `ATK222222225`: A truly monsterous abomination, 50% longer then the  standard K225. This behemoth has 10 cargo bays, 14 RCS, and a custom HUD to show ship status. 
  - `ATK225 "Actiorione"`: This unholy creation can wield 4 High-Stress Hardpoints, sacrificing every other hardpoint to do so. You should totally equip 4 ARMs, that's a great idea !
