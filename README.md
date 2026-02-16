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

13 (left) and 11 (right) pixels buffer besides shield for player movement -> 12 pixels each for symmettry
181 pixels wide movespace for player
PLAYER_MIN_X = 19 Intial player pixel + (4 x 8) - 12 = 39
PLAYER_MAX_X = 238 Intial player pixel - (4 x 8) + 12 = 218

29 char wide playarea, 4 char edge outside symmetrical shields
7 char free
