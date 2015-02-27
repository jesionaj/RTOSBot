#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-XC32_PIC32MX250F128B.mk)" "nbproject/Makefile-local-XC32_PIC32MX250F128B.mk"
include nbproject/Makefile-local-XC32_PIC32MX250F128B.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=XC32_PIC32MX250F128B
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=HobbyOS/port/PIC32MX/port.c HobbyOS/port/PIC32MX/interrupt.S HobbyOS/event.c HobbyOS/idleTask.c HobbyOS/list.c HobbyOS/queue.c HobbyOS/rtos.c HobbyOS/timer.c src/blinkLED.c src/encoder.c src/main.c src/motorTask.c src/sdCard.c src/sdCardSPI.c src/serialLCD.c src/user_int.S src/wiimoteI2C.c src/wiimoteTask.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o ${OBJECTDIR}/HobbyOS/event.o ${OBJECTDIR}/HobbyOS/idleTask.o ${OBJECTDIR}/HobbyOS/list.o ${OBJECTDIR}/HobbyOS/queue.o ${OBJECTDIR}/HobbyOS/rtos.o ${OBJECTDIR}/HobbyOS/timer.o ${OBJECTDIR}/src/blinkLED.o ${OBJECTDIR}/src/encoder.o ${OBJECTDIR}/src/main.o ${OBJECTDIR}/src/motorTask.o ${OBJECTDIR}/src/sdCard.o ${OBJECTDIR}/src/sdCardSPI.o ${OBJECTDIR}/src/serialLCD.o ${OBJECTDIR}/src/user_int.o ${OBJECTDIR}/src/wiimoteI2C.o ${OBJECTDIR}/src/wiimoteTask.o
POSSIBLE_DEPFILES=${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d ${OBJECTDIR}/HobbyOS/event.o.d ${OBJECTDIR}/HobbyOS/idleTask.o.d ${OBJECTDIR}/HobbyOS/list.o.d ${OBJECTDIR}/HobbyOS/queue.o.d ${OBJECTDIR}/HobbyOS/rtos.o.d ${OBJECTDIR}/HobbyOS/timer.o.d ${OBJECTDIR}/src/blinkLED.o.d ${OBJECTDIR}/src/encoder.o.d ${OBJECTDIR}/src/main.o.d ${OBJECTDIR}/src/motorTask.o.d ${OBJECTDIR}/src/sdCard.o.d ${OBJECTDIR}/src/sdCardSPI.o.d ${OBJECTDIR}/src/serialLCD.o.d ${OBJECTDIR}/src/user_int.o.d ${OBJECTDIR}/src/wiimoteI2C.o.d ${OBJECTDIR}/src/wiimoteTask.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o ${OBJECTDIR}/HobbyOS/event.o ${OBJECTDIR}/HobbyOS/idleTask.o ${OBJECTDIR}/HobbyOS/list.o ${OBJECTDIR}/HobbyOS/queue.o ${OBJECTDIR}/HobbyOS/rtos.o ${OBJECTDIR}/HobbyOS/timer.o ${OBJECTDIR}/src/blinkLED.o ${OBJECTDIR}/src/encoder.o ${OBJECTDIR}/src/main.o ${OBJECTDIR}/src/motorTask.o ${OBJECTDIR}/src/sdCard.o ${OBJECTDIR}/src/sdCardSPI.o ${OBJECTDIR}/src/serialLCD.o ${OBJECTDIR}/src/user_int.o ${OBJECTDIR}/src/wiimoteI2C.o ${OBJECTDIR}/src/wiimoteTask.o

# Source Files
SOURCEFILES=HobbyOS/port/PIC32MX/port.c HobbyOS/port/PIC32MX/interrupt.S HobbyOS/event.c HobbyOS/idleTask.c HobbyOS/list.c HobbyOS/queue.c HobbyOS/rtos.c HobbyOS/timer.c src/blinkLED.c src/encoder.c src/main.c src/motorTask.c src/sdCard.c src/sdCardSPI.c src/serialLCD.c src/user_int.S src/wiimoteI2C.c src/wiimoteTask.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-XC32_PIC32MX250F128B.mk dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX250F128B
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o: HobbyOS/port/PIC32MX/interrupt.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS/port/PIC32MX 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.ok ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.err 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d" "${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d"  -o ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o HobbyOS/port/PIC32MX/interrupt.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1 -I"HobbyOS/inc" -I"inc" -I"HobbyOS/port/PIC32MX/inc"
	
${OBJECTDIR}/src/user_int.o: src/user_int.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/user_int.o.d 
	@${RM} ${OBJECTDIR}/src/user_int.o 
	@${RM} ${OBJECTDIR}/src/user_int.o.ok ${OBJECTDIR}/src/user_int.o.err 
	@${FIXDEPS} "${OBJECTDIR}/src/user_int.o.d" "${OBJECTDIR}/src/user_int.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/user_int.o.d"  -o ${OBJECTDIR}/src/user_int.o src/user_int.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/user_int.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1 -I"HobbyOS/inc" -I"inc" -I"HobbyOS/port/PIC32MX/inc"
	
else
${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o: HobbyOS/port/PIC32MX/interrupt.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS/port/PIC32MX 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.ok ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.err 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d" "${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.d"  -o ${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o HobbyOS/port/PIC32MX/interrupt.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/HobbyOS/port/PIC32MX/interrupt.o.asm.d",--gdwarf-2 -I"HobbyOS/inc" -I"inc" -I"HobbyOS/port/PIC32MX/inc"
	
${OBJECTDIR}/src/user_int.o: src/user_int.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/user_int.o.d 
	@${RM} ${OBJECTDIR}/src/user_int.o 
	@${RM} ${OBJECTDIR}/src/user_int.o.ok ${OBJECTDIR}/src/user_int.o.err 
	@${FIXDEPS} "${OBJECTDIR}/src/user_int.o.d" "${OBJECTDIR}/src/user_int.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/user_int.o.d"  -o ${OBJECTDIR}/src/user_int.o src/user_int.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/user_int.o.asm.d",--gdwarf-2 -I"HobbyOS/inc" -I"inc" -I"HobbyOS/port/PIC32MX/inc"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o: HobbyOS/port/PIC32MX/port.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS/port/PIC32MX 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d" -o ${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o HobbyOS/port/PIC32MX/port.c   
	
${OBJECTDIR}/HobbyOS/event.o: HobbyOS/event.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/event.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/event.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/event.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/event.o.d" -o ${OBJECTDIR}/HobbyOS/event.o HobbyOS/event.c   
	
${OBJECTDIR}/HobbyOS/idleTask.o: HobbyOS/idleTask.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/idleTask.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/idleTask.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/idleTask.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/idleTask.o.d" -o ${OBJECTDIR}/HobbyOS/idleTask.o HobbyOS/idleTask.c   
	
${OBJECTDIR}/HobbyOS/list.o: HobbyOS/list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/list.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/list.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/list.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/list.o.d" -o ${OBJECTDIR}/HobbyOS/list.o HobbyOS/list.c   
	
${OBJECTDIR}/HobbyOS/queue.o: HobbyOS/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/queue.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/queue.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/queue.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/queue.o.d" -o ${OBJECTDIR}/HobbyOS/queue.o HobbyOS/queue.c   
	
${OBJECTDIR}/HobbyOS/rtos.o: HobbyOS/rtos.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/rtos.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/rtos.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/rtos.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/rtos.o.d" -o ${OBJECTDIR}/HobbyOS/rtos.o HobbyOS/rtos.c   
	
${OBJECTDIR}/HobbyOS/timer.o: HobbyOS/timer.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/timer.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/timer.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/timer.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/timer.o.d" -o ${OBJECTDIR}/HobbyOS/timer.o HobbyOS/timer.c   
	
${OBJECTDIR}/src/blinkLED.o: src/blinkLED.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/blinkLED.o.d 
	@${RM} ${OBJECTDIR}/src/blinkLED.o 
	@${FIXDEPS} "${OBJECTDIR}/src/blinkLED.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/blinkLED.o.d" -o ${OBJECTDIR}/src/blinkLED.o src/blinkLED.c   
	
${OBJECTDIR}/src/encoder.o: src/encoder.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/encoder.o.d 
	@${RM} ${OBJECTDIR}/src/encoder.o 
	@${FIXDEPS} "${OBJECTDIR}/src/encoder.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/encoder.o.d" -o ${OBJECTDIR}/src/encoder.o src/encoder.c   
	
${OBJECTDIR}/src/main.o: src/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	@${FIXDEPS} "${OBJECTDIR}/src/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/main.o.d" -o ${OBJECTDIR}/src/main.o src/main.c   
	
${OBJECTDIR}/src/motorTask.o: src/motorTask.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/motorTask.o.d 
	@${RM} ${OBJECTDIR}/src/motorTask.o 
	@${FIXDEPS} "${OBJECTDIR}/src/motorTask.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/motorTask.o.d" -o ${OBJECTDIR}/src/motorTask.o src/motorTask.c   
	
${OBJECTDIR}/src/sdCard.o: src/sdCard.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/sdCard.o.d 
	@${RM} ${OBJECTDIR}/src/sdCard.o 
	@${FIXDEPS} "${OBJECTDIR}/src/sdCard.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/sdCard.o.d" -o ${OBJECTDIR}/src/sdCard.o src/sdCard.c   
	
${OBJECTDIR}/src/sdCardSPI.o: src/sdCardSPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/sdCardSPI.o.d 
	@${RM} ${OBJECTDIR}/src/sdCardSPI.o 
	@${FIXDEPS} "${OBJECTDIR}/src/sdCardSPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/sdCardSPI.o.d" -o ${OBJECTDIR}/src/sdCardSPI.o src/sdCardSPI.c   
	
${OBJECTDIR}/src/serialLCD.o: src/serialLCD.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/serialLCD.o.d 
	@${RM} ${OBJECTDIR}/src/serialLCD.o 
	@${FIXDEPS} "${OBJECTDIR}/src/serialLCD.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/serialLCD.o.d" -o ${OBJECTDIR}/src/serialLCD.o src/serialLCD.c   
	
${OBJECTDIR}/src/wiimoteI2C.o: src/wiimoteI2C.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/wiimoteI2C.o.d 
	@${RM} ${OBJECTDIR}/src/wiimoteI2C.o 
	@${FIXDEPS} "${OBJECTDIR}/src/wiimoteI2C.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/wiimoteI2C.o.d" -o ${OBJECTDIR}/src/wiimoteI2C.o src/wiimoteI2C.c   
	
${OBJECTDIR}/src/wiimoteTask.o: src/wiimoteTask.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/wiimoteTask.o.d 
	@${RM} ${OBJECTDIR}/src/wiimoteTask.o 
	@${FIXDEPS} "${OBJECTDIR}/src/wiimoteTask.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/wiimoteTask.o.d" -o ${OBJECTDIR}/src/wiimoteTask.o src/wiimoteTask.c   
	
else
${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o: HobbyOS/port/PIC32MX/port.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS/port/PIC32MX 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o.d" -o ${OBJECTDIR}/HobbyOS/port/PIC32MX/port.o HobbyOS/port/PIC32MX/port.c   
	
${OBJECTDIR}/HobbyOS/event.o: HobbyOS/event.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/event.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/event.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/event.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/event.o.d" -o ${OBJECTDIR}/HobbyOS/event.o HobbyOS/event.c   
	
${OBJECTDIR}/HobbyOS/idleTask.o: HobbyOS/idleTask.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/idleTask.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/idleTask.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/idleTask.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/idleTask.o.d" -o ${OBJECTDIR}/HobbyOS/idleTask.o HobbyOS/idleTask.c   
	
${OBJECTDIR}/HobbyOS/list.o: HobbyOS/list.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/list.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/list.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/list.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/list.o.d" -o ${OBJECTDIR}/HobbyOS/list.o HobbyOS/list.c   
	
${OBJECTDIR}/HobbyOS/queue.o: HobbyOS/queue.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/queue.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/queue.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/queue.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/queue.o.d" -o ${OBJECTDIR}/HobbyOS/queue.o HobbyOS/queue.c   
	
${OBJECTDIR}/HobbyOS/rtos.o: HobbyOS/rtos.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/rtos.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/rtos.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/rtos.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/rtos.o.d" -o ${OBJECTDIR}/HobbyOS/rtos.o HobbyOS/rtos.c   
	
${OBJECTDIR}/HobbyOS/timer.o: HobbyOS/timer.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/HobbyOS 
	@${RM} ${OBJECTDIR}/HobbyOS/timer.o.d 
	@${RM} ${OBJECTDIR}/HobbyOS/timer.o 
	@${FIXDEPS} "${OBJECTDIR}/HobbyOS/timer.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/HobbyOS/timer.o.d" -o ${OBJECTDIR}/HobbyOS/timer.o HobbyOS/timer.c   
	
${OBJECTDIR}/src/blinkLED.o: src/blinkLED.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/blinkLED.o.d 
	@${RM} ${OBJECTDIR}/src/blinkLED.o 
	@${FIXDEPS} "${OBJECTDIR}/src/blinkLED.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/blinkLED.o.d" -o ${OBJECTDIR}/src/blinkLED.o src/blinkLED.c   
	
${OBJECTDIR}/src/encoder.o: src/encoder.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/encoder.o.d 
	@${RM} ${OBJECTDIR}/src/encoder.o 
	@${FIXDEPS} "${OBJECTDIR}/src/encoder.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/encoder.o.d" -o ${OBJECTDIR}/src/encoder.o src/encoder.c   
	
${OBJECTDIR}/src/main.o: src/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	@${FIXDEPS} "${OBJECTDIR}/src/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/main.o.d" -o ${OBJECTDIR}/src/main.o src/main.c   
	
${OBJECTDIR}/src/motorTask.o: src/motorTask.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/motorTask.o.d 
	@${RM} ${OBJECTDIR}/src/motorTask.o 
	@${FIXDEPS} "${OBJECTDIR}/src/motorTask.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/motorTask.o.d" -o ${OBJECTDIR}/src/motorTask.o src/motorTask.c   
	
${OBJECTDIR}/src/sdCard.o: src/sdCard.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/sdCard.o.d 
	@${RM} ${OBJECTDIR}/src/sdCard.o 
	@${FIXDEPS} "${OBJECTDIR}/src/sdCard.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/sdCard.o.d" -o ${OBJECTDIR}/src/sdCard.o src/sdCard.c   
	
${OBJECTDIR}/src/sdCardSPI.o: src/sdCardSPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/sdCardSPI.o.d 
	@${RM} ${OBJECTDIR}/src/sdCardSPI.o 
	@${FIXDEPS} "${OBJECTDIR}/src/sdCardSPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/sdCardSPI.o.d" -o ${OBJECTDIR}/src/sdCardSPI.o src/sdCardSPI.c   
	
${OBJECTDIR}/src/serialLCD.o: src/serialLCD.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/serialLCD.o.d 
	@${RM} ${OBJECTDIR}/src/serialLCD.o 
	@${FIXDEPS} "${OBJECTDIR}/src/serialLCD.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/serialLCD.o.d" -o ${OBJECTDIR}/src/serialLCD.o src/serialLCD.c   
	
${OBJECTDIR}/src/wiimoteI2C.o: src/wiimoteI2C.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/wiimoteI2C.o.d 
	@${RM} ${OBJECTDIR}/src/wiimoteI2C.o 
	@${FIXDEPS} "${OBJECTDIR}/src/wiimoteI2C.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/wiimoteI2C.o.d" -o ${OBJECTDIR}/src/wiimoteI2C.o src/wiimoteI2C.c   
	
${OBJECTDIR}/src/wiimoteTask.o: src/wiimoteTask.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/src 
	@${RM} ${OBJECTDIR}/src/wiimoteTask.o.d 
	@${RM} ${OBJECTDIR}/src/wiimoteTask.o 
	@${FIXDEPS} "${OBJECTDIR}/src/wiimoteTask.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -D_SUPPRESS_PLIB_WARNING -I"inc" -I"HobbyOS/inc" -I"HobbyOS/port/PIC32MX/inc" -MMD -MF "${OBJECTDIR}/src/wiimoteTask.o.d" -o ${OBJECTDIR}/src/wiimoteTask.o src/wiimoteTask.c   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mdebugger -D__MPLAB_DEBUGGER_PK3=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}           -mreserve=data@0x0:0x1FC -mreserve=boot@0x1FC00490:0x1FC00BEF -mreserve=boot@0x1FC00490:0x1FC00BEF  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"
	${MP_CC_DIR}\\xc32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/RTOSBot.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/XC32_PIC32MX250F128B
	${RM} -r dist/XC32_PIC32MX250F128B

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
