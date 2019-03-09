import pygame
pygame.init()
win = pygame.display.set_mode((500, 500))

pygame.display.set_caption("ekran")


walkRight = [pygame.image.load('right_1.png'), pygame.image.load('right_2.png'), pygame.image.load('right_3.png'),
             pygame.image.load('right_4.png'), pygame.image.load('right_5.png'), pygame.image.load('right_6.png')]


walkLeft = [pygame.image.load('left_1.png'), pygame.image.load('left_2.png'), pygame.image.load('left_3.png'),
            pygame.image.load('left_4.png'), pygame.image.load('left_5.png'), pygame.image.load('left_6.png')]


bg = pygame.image.load('bg.jpg')

playerStand = pygame.image.load('stop.png')
kim = pygame.image.load('kim.png')

clock = pygame.time.Clock()

x = 50
y = 430
schet = 0

widht= 60
height= 71
speed = 7
count = 0
isjamp =False
jampcount = 10

left = False
right = False
animcount = 0

class prepytstvie:
    def __init__(self, x=370, y=440, widht=100, height=50, speed=10):
        self.x = x
        self.y = y
        self.widht = widht
        self.height = height
        self.speed = speed
        pass
    def show(self):
        return self.x, self.y, self.widht, self.height, self.speed
        pass

    pass

ract = prepytstvie()

print(ract.height)

def drawwindows():
    global animcount
    win.blit(bg, (0,0))
    win.blit(kim, (ract.x, ract.y - 70))


    if animcount +1 >=30:
        animcount = 0

    if left:
        win.blit(walkLeft[animcount // 5], (x, y))
        animcount += 1
    elif right:
        win.blit(walkRight[animcount // 5], (x, y))
        animcount += 1
    else:
        win.blit(playerStand, (x, y))



    pygame.display.update()


quit = True

while quit:
    clock.tick(30)

    ract.x -= ract.speed - 4


    if ract.x <= 5:
        print("привет")
        ract.x = 500
        schet  += 1
        print(schet  )

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            quit = False
    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT] and x>=5:
        x-=speed
        left = True
        right = False
    elif keys[pygame.K_RIGHT] and x<=440:
        x+=speed
        left = False
        right = True
    else:
        left = False
        right = False
        animcount = 0
    if not(isjamp):
        if keys[pygame.K_SPACE]:
            isjamp = True
    else:
        if  jampcount >= -10:
            if jampcount < 0:
                y += (jampcount **2)/2
            else:
                y -= (jampcount **2)/2
            jampcount -= 1
        else:
            isjamp =False
            jampcount = 10
#
    drawwindows()
    if  x + widht <= ract.x + ract.widht and x + widht >= ract.x and y+height >= ract.y - ract.height -20:
        print("ты проиграл")
        quit = False
