# 2015 Adam Jesionowski

# Call with python InterpretFile.py [BinaryFileFromSDCard]

import numpy
import math
import pygame
import sys
from pygame.math import Vector3

SCREEN_WIDTH = 600
SCREEN_HEIGHT = 600

def rad_to_degree(rad):
    return rad * 180.0/math.pi

def cm_to_pixel(cm):
    return 2.5*cm

def encoder_ticks_to_cm(ticks):
    return ticks[0] * 0.325, ticks[1] * 0.325

def cm_to_screen_pos(position):
    return SCREEN_WIDTH/2 + cm_to_pixel(position[0]), SCREEN_HEIGHT/2 + cm_to_pixel(position[1]), position[2]

class Robot(pygame.sprite.Sprite):
    def __init__(self):
        super(Robot, self).__init__()

        self.l = 5.4   # Half distance between wheels
        self.r = 3.31  # Wheel radius

        self.image = pygame.image.load('img/Bot.png')
        self.original_image = self.image

        self.position = Vector3(0, 0, math.pi)
        self.next_position = Vector3(0, 0, math.pi)  # This will be immediately updated

        self.rect = self.image.get_rect()
        screen_pos = cm_to_screen_pos(self.position)
        self.rect.center = screen_pos[0], screen_pos[1]

    def restart(self):
        self.position = Vector3(0, 0, math.pi)
        self.next_position = Vector3(0, 0, math.pi)

        self.rect = self.image.get_rect()
        screen_pos = cm_to_screen_pos(self.position)
        self.rect.center = screen_pos[0], screen_pos[1]

    def update(self, velocity):
        """Given the wheel velocity, find where the robot moved to"""

        # There was some weird issues with copy.copy here, so just set position = next_position manually
        self.position[0] = self.next_position[0]
        self.position[1] = self.next_position[1]
        self.position[2] = self.next_position[2]

        # Based on https://www.rose-hulman.edu/~berry123/Courses/ECE425/Spring07_files/Lecture2%20-%20Kinematics.pdf
        angle = self.position[2]
        r1 = numpy.matrix([[math.cos(angle), math.sin(angle), 0],
                 [-math.sin(angle), math.cos(angle), 0],
                 [0, 0, 1.0]])

        a2 = numpy.matrix([[0.5, 0.5, 0],
                          [0, 0, 1.0],
                          [1/(2.0*self.l), -1/(2.0*self.l), 0]])

        a3 = numpy.matrix([[velocity[0]], [velocity[1]], [0]])

        transform = r1.T*a2*a3

        self.next_position[0] = self.position[0] + transform[0]
        self.next_position[1] = self.position[1] + transform[1]
        self.next_position[2] = self.position[2] + transform[2]

    def render(self, interp):
        """Render the robot moving from position to next_position"""
        lerp_pos = self.position.lerp(self.next_position, interp)

        # Rotate and set image first
        self.image = pygame.transform.rotate(self.original_image, -rad_to_degree(lerp_pos[2]))  # Rotate works cw and we want ccw
        self.rect = self.image.get_rect()

        # Translate cm position to screen position
        screen_pos = cm_to_screen_pos(lerp_pos)
        self.rect.center = screen_pos[0], screen_pos[1]


class Timer(pygame.sprite.Sprite):
    """Displays a running timer"""
    def __init__(self):
        super(Timer, self).__init__()

        self.time = 0.0
        self.font = pygame.font.Font(None, 30)
        self.image = self.font.render('Time: ' + str(self.time) + ' s', 1, (0, 0, 0))

        self.rect = self.image.get_rect()
        self.rect.x = 450
        self.rect.y = 10

    def update(self):
        self.time += 0.1
        self.image = self.font.render('Time: ' + str(self.time) + ' s', 1, (0, 0, 0))

    def restart(self):
        self.time = 0.0

JOYSTICK_X = 450
JOYSTICK_Y = 450

class Joystick(pygame.sprite.Sprite):
    """Displays the black background joystick image"""
    def __init__(self):
        super(Joystick, self).__init__()
        self.image = pygame.image.load('img/Background.png')
        self.rect = self.image.get_rect()
        self.rect.x = JOYSTICK_X
        self.rect.y = JOYSTICK_Y

class JoystickOverlay(pygame.sprite.Sprite):
    """Displays the direction the joystick is being pushed"""
    def __init__(self):
        super(JoystickOverlay, self).__init__()
        self.image = pygame.image.load('img/Center.png')
        self.rect = self.image.get_rect()
        self.rect.x = JOYSTICK_X + 52
        self.rect.y = JOYSTICK_Y + 48

        self.range = 15

    def in_range(self, x_in, y_in, x, y):
        if (x + self.range) > x_in > (x - self.range):
            if (y + self.range) > y_in > (y - self.range):
                return True
        return False

    def update(self, x_in, y_in):
        print x_in, y_in
        if self.in_range(x_in, y_in, 113, 217):
            self.image = pygame.image.load('img/Forward.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 48
            self.rect.y = JOYSTICK_Y + 0
        elif self.in_range(x_in, y_in, 128, 18):
            self.image = pygame.image.load('img/Backward.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 48
            self.rect.y = JOYSTICK_Y + 64
        elif self.in_range(x_in, y_in, 222, 115):
            self.image = pygame.image.load('img/Right.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 72
            self.rect.y = JOYSTICK_Y + 44
        elif self.in_range(x_in, y_in, 19, 128):
            self.image = pygame.image.load('img/Left.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 0
            self.rect.y = JOYSTICK_Y + 44
        elif self.in_range(x_in, y_in, 54, 164) or self.in_range(x_in, y_in, 15, 164):
            self.image = pygame.image.load('img/ForwardLeft.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 0
            self.rect.y = JOYSTICK_Y + 0
        elif self.in_range(x_in, y_in, 176, 153):
            self.image = pygame.image.load('img/ForwardRight.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 73
            self.rect.y = JOYSTICK_Y + 0
        elif self.in_range(x_in, y_in, 54, 52):
            self.image = pygame.image.load('img/BackwardLeft.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 1
            self.rect.y = JOYSTICK_Y + 64
        elif self.in_range(x_in, y_in, 176, 54):
            self.image = pygame.image.load('img/BackwardRight.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 73
            self.rect.y = JOYSTICK_Y + 64
        else:
            self.image = pygame.image.load('img/Center.png')
            self.rect = self.image.get_rect()
            self.rect.x = JOYSTICK_X + 52
            self.rect.y = JOYSTICK_Y + 48


# Read the binary data from the sd card file
moveData = []
f = open(sys.argv[1], "rb")
try:
    values = f.read(4)

    while values:
        # Convert from binary to ints
        ordValues = [ord(x) for x in values]

        # If every value is 0, we reached the end of the saved data
        if ordValues[0] == 0 and ordValues[1] == 0 and ordValues[2] == 0 and ordValues[3] == 0:
            break

        # Left and Right encoder values are signed
        ordValues[2] = numpy.int8(ordValues[2])
        ordValues[3] = numpy.int8(ordValues[3])

        moveData.append(ordValues)

        print "JoyX: ", ordValues[0], "JoyY: ", ordValues[1], "Left: ", ordValues[2], "Right: ", ordValues[3]

        values = f.read(4)
finally:
    f.close()

# Set up pygame
pygame.init()

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption('RTOSBot Dead Reckoning')
clock = pygame.time.Clock()

# Initialize our sprites
robot = Robot()
timer = Timer()
joystick = Joystick()
joystick_overlay = JoystickOverlay()

base_list = pygame.sprite.Group()
overlay_list = pygame.sprite.Group()  # Overlay needs to go on top of base

base_list.add(robot)
base_list.add(timer)
base_list.add(joystick)
overlay_list.add(joystick_overlay)

# Initialize variables for loop
complete = False
move_index = 0
render_frame = 0

# Set next_position before anything runs
robot.update(encoder_ticks_to_cm((moveData[move_index][2], moveData[move_index][3])))

while 1:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            sys.exit()
        elif event.type == pygame.KEYDOWN:
            # Restart if r is pressed
            if event.key == pygame.K_r:
                robot.restart()
                timer.restart()

                complete = False
                move_index = 0
                render_frame = 0

                robot.update(encoder_ticks_to_cm((moveData[move_index][2], moveData[move_index][3])))

    screen.fill((250, 250, 250))

    # Render the robot each and every frame. Every 10 frames, update the next_position.
    if not complete:
        robot.render(render_frame/10.0)
        render_frame += 1

        if render_frame == 10:
            render_frame = 0
            move_index += 1

            # If the index is equal to the length of the data, we're done
            if move_index == len(moveData):
                complete = True
                continue

            # Update our sprites
            joystick_overlay.update(moveData[move_index][0], moveData[move_index][1])
            robot.update(encoder_ticks_to_cm((moveData[move_index][2], moveData[move_index][3])))
            timer.update()

    base_list.draw(screen)
    overlay_list.draw(screen)
    pygame.display.flip()

    clock.tick_busy_loop(100)
