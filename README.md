# RTOSBot
A small robot that uses my [HobbyOS](https://github.com/jesionaj/HobbyOS/) code.

![Robot](http://i.imgur.com/SrGnT58.jpg)

Parallax's Board of Education shield is the base of the robot, which includes the frame, motors, and encoders. For the brains, I laid out my own PCB with a PIC32MX250F128B chip, which you can find in the hardware folder.

![PCB](http://i.imgur.com/BMcCUML.jpg)

The robot is driven using Wiimote Nunchuck. While it drives, the LCD on top displays encoder data and joystick position, which is also written to an SD card. After the driving is finished, that data can be copied off of the SD card (see below). An included Python script reads this data and reconstructs the robot's path using dead reckoning.

### Build Instructions
1. Run `git clone https://github.com/jesionaj/HobbyOS.git` in the RTOSBot folder.  
2. Open the RTOSBot project in MPLAB and hit build. That's it!

### Dead Reckoning  
The dead reckoning script requires Python 2.7, pygame 1.9.2, and numpy. Data is recorded on the SD card starting at address 0x400.  
1. Open the `python` folder and copy the data off the robot's SD card using (for OSX at least): `sudo dd bs=512 skip=2 if=/dev/rdisk# of=sdcard_data count=20`, where # is the SD card's disk number. Sample data is provided.  
2. Run `python InterpretFile.py sdcard_data`  
3. Before removing the SD card, run `sudo dd bs=512 seek=2 if=/dev/zero of=/dev/rdisk# count=20` to wipe out the old run.  