# CamJam EduKit 3 - Robotics
# Worksheet 3 - Motor Test Code

import RPi.GPIO as GPIO # gpio raspberry pi library
import time 		# timing lib

# GPIO mode
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# Set pins to output
GPIO.setup(7, GPIO.OUT) # Motor B - right motor
GPIO.setup(8, GPIO.OUT)
GPIO.setup(9, GPIO.OUT) # Motor A - left motor
GPIO.setup(10, GPIO.OUT)

# Set everything off
GPIO.output(7, 0)
GPIO.output(8, 0)
GPIO.output(9, 0)
GPIO.output(10, 0)

# Turn the right motor forwards
GPIO.output(7, 0)
GPIO.output(8, 1)

# Turn the left motor forwards
GPIO.output(9, 0)
GPIO.output(10, 1)

# Wait one second
time.sleep(2)

# Stop every motor
GPIO.cleanup()
