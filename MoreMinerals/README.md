# MoreMinerals

###### A Mod that adds more mineral variety to your game.

## Features:

- 6 new mineral types!

- 4 new Obonto Trades!

- 

- Multiple minerals per chunk!
  
  - Every mineral chunk has a chance to contain more than one type of mineral.
  - Less pure mineral chunks will tend to contain more of the other minerals.

- 4 Processed cargo hold behaviors (modify in `ship-ctrl.gd`):
  
  - `default`: Standard behavior, increases effective cargo hold of non-combined ships.
  
  - `reduced`: Reduces per-mineral cargo space, maintains effective cargo capacity of non-combined ships.
  
  - `limited`: Limits ships to X types of processed cargo, maintains effective cargo capacity of non-combined ships.
  
  - `dynamic`: Limits ships to X processed cargo bays, that can be dynamically allocated to different types of minerals. Maintains effective cargo capacity of non-combined ships, while increasing versatility.
  
  - `maxCargoTypes`: The number of processed cargo bays the ship will have when using `limited` or `dynamic` behaviors (default: 6).

## Installation:

To install, go to the game's installation directory (the directory containing `Delta-V.pck`), and create a new directory called `mods`. Place the mod `.zip` in this `mods` directory, this must be `MoreMinerals.zip` and not an extracted folder.

To run the game with mods, run it with the `--enable-mods` command-line parameter. If using Steam, you can add the parameter in the game's properties → General → Launch Options.
