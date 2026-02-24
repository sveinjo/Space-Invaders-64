# Space-Invaders-64

Space Invaders for Commodore 64

[![Video Thumbnail](https://img.youtube.com/vi/WY0rsY6sZow/0.jpg)](https://www.youtube.com/watch?v=WY0rsY6sZow)

Space Invaders on the original arcade hardware moved objects by directly manipulating pixels. That works, but it’s computationally expensive — and the arcade CPU was twice as fast as the one in a C64. Not exactly a good approach for a port.

So I went with one of the C64’s superpowers: hardware sprites.

These are small graphical objects the system can move around cheaply and efficiently. The C64 only gives us 8 hardware sprites, but through the dark and slightly glitchy arts of sprite multiplexing - exploiting the way the raster beam draws the screen - I can trick it into displaying all 61 moving objects using just those 8 sprites.

Here’s how I’m setting it up:

•	Sprite 0: Player ship + player bullet (they never overlap, so they can share).

•	Sprites 1–4: Enemy clusters, dynamically multiplexed into position with dark raster interrupt magic.

•	Sprite 1 also moonlights as the UFO, sharing time with an enemy cluster that doesn’t need it on that particular raster pass.

•	Sprites 5–7: Enemy bullets - dedicated sprites so they can spawn and fly wherever the action requires.

The video above is an early alpha/demo. To the sharp-eyed among you: yes, it actually runs smoother than the original arcade version.

Right now I’m stress-testing the engine - pushing sprites, timing, and every moving part to make sure it holds up under load. Once the performance foundation is solid, I’ll start building and fine-tuning the core game logic.

First make it run. Then make it fun. 🚀

Tools: TRSE (“Turbo Rascal Syntax error, “;” expected but “BEGIN”)

Music: Courier by Uctumi
