#include <iostream>;
#include <stdio.h>;


bool diodeSignalOne = true;
bool diodeSignalTwo = false;
bool diodeSignalThree = true;
bool diodeSignalFour = true;
bool diodeSignalFive = false;
bool diodeSignalSix = true;

getDiodeSignals(){
    // signals from an ISR when the diodes state changes and then handed off to varables so that 
    // polling doesnt become an issue.
    uint8_t diodeSignal = 0;
    diodeSignal |= diodeSignalSix << 0; // PD1F on PCB
    diodeSignal |= diodeSignalFive << 1; // PD1E on PCB
    diodeSignal |= diodeSignalFour << 2; // PD1D on PCB
    diodeSignal |= diodeSignalThree << 3; // PD1C on PCB
    diodeSignal |= diodeSignalTwo << 4; // PD1B on PCB
    diodeSignal |= diodeSignalOne << 5; // PD1A on PCB

    // binary signal should look like: 
    // 0,0,PD1F,PD1E,PD1D,PD1C,PD1B,PD1A
}

ForwardsRight(){ //this fuction should drive the back right wheel fowards
    uint8_t check = getDiodeSignals(); // polls for signal change -- may needed to be abstracted to higher level 
    uint8_t flag = getDiodeSignals();

    if (check == flag) {
         SETMOTOR(RIGHT_MOTOR,FORWARD,SPEED);
         SETMOTOR(LEFT_MOTOR,FORWARD,0);
         flag = getDiodeSignals();
    }
    else {
        SETMOTOR(RIGHT_MOTOR,FORWARD,0);
         SETMOTOR(LEFT_MOTOR,FORWARD,0);
    }


}

ForwardsLeft(){ //this fuction should drive the back left wheel fowards
    uint8_t check = getDiodeSignals(); // polls for signal change -- may needed to be abstracted to higher level 
    uint8_t flag = getDiodeSignals();

    if (check == flag) {
         SETMOTOR(LEFT_MOTOR,FORWARD,SPEED);
         SETMOTOR(RIGHT_MOTOR,FORWARD,0);
         flag = getDiodeSignals();
    }
    else {
        SETMOTOR(RIGHT_MOTOR,FORWARD,0);
        SETMOTOR(LEFT_MOTOR,FORWARD,0);
    }
}

BackwardsRight(){ //this fuction should drive the back right wheel backwards
    uint8_t check = getDiodeSignals(); // polls for signal change -- may needed to be abstracted to higher level 
    uint8_t flag = getDiodeSignals();

    if (check == flag) {
         SETMOTOR(RIGHT_MOTOR,BACKWARD,SPEED);
         SETMOTOR(LEFT_MOTOR,BACKWARD,0);
         flag = getDiodeSignals();
    }
    else {
        SETMOTOR(RIGHT_MOTOR,BACKWARD,0);
         SETMOTOR(LEFT_MOTOR,BACKWARD,0);
    }
}

BackwardsLeft(){ //this fuction should drive the back left wheel backwards
    uint8_t check = getDiodeSignals(); // polls for signal change -- may needed to be abstracted to higher level 
    uint8_t flag = getDiodeSignals();

    if (check == flag) {
         SETMOTOR(LEFT_MOTOR,BACKWARD,SPEED);
         SETMOTOR(RIGHT_MOTOR,BACKWARD,0);
         flag = getDiodeSignals();
    }
    else {
        SETMOTOR(RIGHT_MOTOR,BACKWARD,0);
        SETMOTOR(LEFT_MOTOR,BACKWARD,0);
    }
}

int main() {
    
// diodeSignal is 8 bits so cases can range from 0 to 255 
// bits 5 & 6 will always be 0 therefore max is 63 
    diodeSignals = getDiodeSignals();
    switch (dioideSignal) {
        case 00000000:
            ForwardsRight() // Left turn right wheel pivot 
            break;

        case 00000000:
            BackwardsRight() //Right turn on left wheel pivot 
            break;

        case 00000000:
            ForwardsLeft() // Right turn on right wheel pivot 
            break;

         case 00000000:
            BackwardsLeft() // Left turn on right wheel pivot.
            break;

        // will be the most common case to occur 
        default:
            break;
        }
    return 0;
}


