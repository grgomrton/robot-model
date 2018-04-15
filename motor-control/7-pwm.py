# CamJam EduKit 3 - Robotics
# Worksheet 7 - Controlling the motors with PWM

import RPi.GPIO as GPIO
import time

# Set GPIO modes - TODO what are these?
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# Pins of motors
pinLeftMotorForwards = 10
pinRightMotorForwards = 8
pinLeftMotorBackwards = 9
pinRightMotorBackwards = 7

# The frequency of the PWM signal
Frequency = 20
# 30% of the time pwm signaling time will be the pin on
NormalSpeed = 30
# Setting the duty cycle to 0 means the motors will not turn
Stop = 0

# Set the GPIO Pin mode to be Output
GPIO.setup(pinLeftMotorForwards, GPIO.OUT)
GPIO.setup(pinRightMotorForwards, GPIO.OUT)
GPIO.setup(pinLeftMotorBackwards, GPIO.OUT)
GPIO.setup(pinRightMotorBackwards, GPIO.OUT)

# GPIO pwm setting hooks
setPwmLeftMotorForwards = GPIO.PWM(pinLeftMotorForwards, Frequency)
setPwmRightMotorForwards = GPIO.PWM(pinRightMotorForwards, Frequency)
setPwmLeftMotorBackwards = GPIO.PWM(pinLeftMotorBackwards, Frequency)
setPwmRightMotorBackwards = GPIO.PWM(pinRightMotorBackwards, Frequency)

# Set every duty cycle to zero - motors are not moving
setPwmLeftMotorForwards.start(Stop) # TODO start initializes something?
setPwmLeftMotorBackwards.start(Stop)
setPwmRightMotorForwards.start(Stop)
setPwmRightMotorBackwards.start(Stop)

# Turn both motors forwards with 30 percent duty cycle
setPwmLeftMotorForwards.ChangeDutyCycle(NormalSpeed)
setPwmRightMotorForwards.ChangeDutyCycle(NormalSpeed)

# Wait a little
time.sleep(1)

# Stop every motor
setPwmLeftMotorForwards.ChangeDutyCycle(Stop)
setPwmRightMotorForwards.ChangeDutyCycle(Stop)
setPwmLeftMotorBackwards.ChangeDutyCycle(Stop)
setPwmRightMotorBackwards.ChangeDutyCycle(Stop)

# Cleanup ?
GPIO.cleanup()
