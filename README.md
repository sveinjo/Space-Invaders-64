# Space-Invaders-64
Space Invaders for Commodore 64

Sprite List:

1 Base
2 Player explosion 1-2
1 Bullet (4 pixels line, moves 4 pixels per frame)
1 Explosion Enemy (stays for 16 frames)
12 Enemy bullet 1-3 *4 (4 frames per bullet)
1 Ufo
4 Ufo Explosion
1 Enemy bullet Hit explosion

22 Total sprite slots needed

# Arcade
13 (left) and 11 (right) pixels buffer besides shield for player movement -> 12 pixels each for symmettry
181 pixels wide movespace for player

# C64
PLAYER_MIN_X = 19 Intial player pixel + (4 x 8) - 12 = 39
PLAYER_MAX_X = 238 Intial player pixel - (4 x 8) + 12 = 218
179 pixels wide movespace for player 

29 char wide playarea, 4 char edge outside symmetrical shields
7 char free

Initial starting position is 11 drops above player.

8 + 5 = 13 * 11 = 143
226 - 143 = 83 - 13 = 70

8 + 5 = 13 / 2 = 6.5 * 11 = 66 + (8 * 5 + 4 * 5) = 126

226 - 143 = 83

Top invader = 144 + 8 pixels above player base (or 11 + 8 characters)
It will drop 19 times, and then it's game over.

If we drop 19 * 6 pixels = 114, that should make start position be: 226 - 114 = 112

Now drops 17

--

Avarage score of invaders = 12
