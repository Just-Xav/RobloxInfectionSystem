# RobloxInfectionSystem


A modular, scalable infection and mutation system designed for Roblox multiplayer games. Players can be infected, mutate over time, and be cured or killed — with full dev/testing support via chat commands and part-based triggers.

---

## 📁 Features

-  **Tick-Based Mutation:** Players progress through stages every 45 seconds (0 -> 4).
-  **Player Class Logic:** Each infected player is tracked separately with their own timer.
-  **Supports Multiple Players:** Each infection runs independently.
-  **Dev Chat Commands:** `!infect`, `!cure`, and `!kill` (supports "me" or player name).
-  **Infection Part:** Touch a part to get infected (safe logic, no cooldown abuse).
-  **Custom Maid Cleanup:** All tasks, events, and visuals are cleaned on cure/death.
-  **Mock Effects Ready:** Placeholder for particles or sounds at each stage.

---

##  How to Use

1. Place all modules in `ServerScriptService.Modules`
2. Put `InfectionZoneScript` inside a Part (with `TouchInterest`)
3. Put `InfectionController` in `ServerScriptService`
4. Run the game and use chat:
   - `!infect me` or `!infect PlayerName`
   - `!cure me` or `!kill me`

---

##  To-Do / Future Features

- Data saving (persistent infection stages)
- Real particle & sound effects per stage
- Cure conditions (e.g., standing in a healing zone)
- UI for infection stage & timer

---
___   ___      ___   ____    ____ 
\  \ /  /     /   \  \   \  /   / 
 \  V  /     /  ^  \  \   \/   /  
  >   <     /  /_\  \  \      /   
 /  .  \   /  _____  \  \    /    
/__/ \__\ /__/     \__\  \__/     



