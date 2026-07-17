OptionSelect:
;-----------------------------------------------------------------------------------------------------------
	.sonicandtails:
		cmpi.w	#$1,d0		; have you selected item $1 (sonic and tails)?
		bne.w	.sonic	; if not, go to sonic alone
		move.b	#0,(Player_option).w	; set the character flag to 0 (indicating Sonic and Tails)
		move.b	#SndID_Checkpoint,d0		; put value of Checkpoint sound into d0
		bsr.w	.optionplaysound
;-----------------------------------------------------------------------------------------------------------
	.sonic:
		cmpi.w	#$2,d0		; have you selected item $2 (sonic)?
		bne.w	.tails	; if not, go to tails
		move.b	#1,(Player_option).w	; set the multiple character flag to 1 (indicating Sonic)
		move.b	#SndID_Ring,d0		; put value of ring sound into d0
		bsr.w	.optionplaysound
;-----------------------------------------------------------------------------------------------------------
	.tails:
		cmpi.w	#$3,d0		; have you selected item $2 (tails)?
		bne.w	.greenhill2p	; if not, go to 2p
		move.b	#2,(Player_option).w	; set the multiple character flag to 2 (indicating Tails)
		move.b	#SndID_Spring,d0		; put value of Spring sound into d0
		bsr.w	.optionplaysound
;-----------------------------------------------------------------------------------------------------------
	.greenhill2p:
		cmpi.w	#$6,d0		; have you selected item $4 (2p green hill)?
		bne.w	.dusthill2p	; if not, do nothing
		move.w	#green_hill_zone_act_1,(Current_ZoneAndAct).w
		move.w	#1,(Two_player_mode).w
		jmp	PlayLevel
;-----------------------------------------------------------------------------------------------------------
	.dusthill2p:
		cmpi.w	#$7,d0		; have you selected item $5 (s1 style peelout)?
		bne.w	.casinonight2p	; if not, do nothing
		move.w	#dust_hill_zone_act_1,(Current_ZoneAndAct).w
		move.w	#1,(Two_player_mode).w
		jmp	PlayLevel
;-----------------------------------------------------------------------------------------------------------
	.casinonight2p:
		cmpi.w	#$8,d0		; have you selected item $9 (disable peelout)?
		bne.w	.protozoneorder	; if not, do nothing
		move.w	#casino_night_zone_act_1,(Current_ZoneAndAct).w
		move.w	#1,(Two_player_mode).w
		jmp	PlayLevel
;-----------------------------------------------------------------------------------------------------------
	.protozoneorder:
		cmpi.w	#$B,d0		; have you selected item $8 (enable moves)?
		bne.w	.expandedzoneorder	; if not, go to sound test
		move.b	#0,(Expanded_zone_option).w
		move.b	#SndID_Checkpoint,d0		; put value of Checkpoint sound into d0
		bsr.w	.optionplaysound
;-----------------------------------------------------------------------------------------------------------
	.expandedzoneorder:
		cmpi.w	#$C,d0		; have you selected item $6 (s1 style peelout)?
		bne.w	.startgame	; if not, do nothing
		move.b	#1,(Expanded_zone_option).w
		move.b	#SndID_Ring,d0		; put value of Ring sound into d0
		bsr.w	.optionplaysound
;-----------------------------------------------------------------------------------------------------------
	.startgame:
		cmpi.w	#$19,d0		; have you selected item $13 (start game)?
		bne.w	.soundtest	; if not, go to sound test
		move.w	#0,(Two_player_mode).w
		jmp	PlayLevel
;-----------------------------------------------------------------------------------------------------------
	.soundtest:
		cmpi.w	#$1A,d0		; have you selected item $14 (sound test)?
		bne.w	.donothing	; if not, do nothing
		btst	#button_A,(Ctrl_1_Press).w	;was A pressed?
		bne.s	.donothing		;if not, branch
		btst	#button_A,(Ctrl_2_Press).w	;was A pressed?
		bne.s	.donothing		;if not, branch
		btst	#button_start,(Ctrl_1_Press).w	;was start pressed?
		bne.s	.gototitle		;if not, branch
		btst	#button_start,(Ctrl_2_Press).w	;was A pressed?
		bne.s	.gototitle		;if not, branch
		bra.w	.soundtestsel
	.donothing:
		jmp	LevelSelect_Loop
;-----------------------------------------------------------------------------------------------------------
.optionplaysound:
		jsr	PlaySound	; jump to the subroutine that plays the sound currently in d0
		rts
.soundtestsel:
		jmp	SoundTestSelection
.gototitle:
		jmp	TitleScreen