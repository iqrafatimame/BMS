  
INCLUDE Irvine32.inc

.data
lineNo BYTE 1
outputLine BYTE ?
filename BYTE "BLOOD.txt",0
BUFFER_SIZE = 5000
buffer BYTE BUFFER_SIZE DUP(?)
filehandle DWORD ?
str1 BYTE BUFFER_SIZE DUP(?)
Sspace byte  ".........................................................",0h
space byte "			-------------------------------------------------------------------",0h
string byte "					|	Blood Management System  |		",0h
m1 byte "			1.Add new data ",0h
menu byte "			------- MENU -------",0h
m2 byte "			2.List of Donars",0h
m3 byte "			3.Search Donars",0h
m4 byte "			3.exit",0h
choice byte "			Enter your choice	:	 ",0h
m5 byte "NAME ",0h
m6 byte "AMOUNT OF BLOOD",0h
m7 byte "BLOOD TYPE",0h
choi byte ?
 stringN byte "Enter Your name : ",0h
 stringB byte "Enter Blood Type : ",0h
 StringA byte "Enter Amount of blood you want to donate in kg : ",0h 
 arr byte 50 dup(0)
N byte  5 dup(0)
B byte 5 dup(0)
A byte 5 dup(0)
temp dword 0
.code


main PROC


	mov edx,offset space						; prints "-------------"
	call writestring
	call crlf

	mov edx,offset string						; print BLOOD MANAGEMENT SYSTEM
	call writestring
	call crlf

	mov edx,offset space						; prints "-----------"  again
	call writestring
	call  crlf
	call crlf
	call crlf

	mov edx,offset menu							; prints menu
	call writestring 
	call crlf
	call crlf

	menucard:
		call crlf
		call crlf
		mov edx,offset m1
		call writestring
		call crlf
		mov edx,offset m2
		call writestring
		call crlf
		;mov edx,offset m3
		;call writestring
		;call crlf
		mov edx,offset m4
		call writestring
		call crlf
		call crlf
		call crlf

		mov edx,offset choice 
		call writestring
		call readint
		mov choi,al

		cmp choi,1										; If choice is 1, it jumps to add blood donor
		je add_donor
		cmp choi,2										; If choice is 2, it jumps to show all available donors
		je L2
		cmp choi,3										; If choice is 3, it exits the blood system
		je _exit
		;Je L3

	jmp _exit

	add_donor:
		call crlf
		mov edx,offset stringN
		call writestring
		 call crlf
		 mov edx,offset n
		 mov ecx,sizeof n
		 call readstring
		; call writestring
		 mov eax,temp
		 mov esi,eax
		 mov edx,0
 
		 Nameloop:
			 mov al,N[edx]
			 mov arr[esi],al

			 inc edx
			 inc esi
		 loop Nameloop

		 add eax,5
		 mov temp,eax
		 mov edx,offset stringB
		 call writestring 
 
		 call crlf
		 mov edx,offset B									; Taking Input for Blood Type
		 mov ecx,sizeof b
		 call readstring
		 ;call writestring

		 mov eax,temp
		 mov esi,eax
		 mov edx,0

		 Bloodloop:											; Store Blood type
	 
			 mov al,B[edx]
			 mov arr[esi],al

			 inc edx
			 inc esi
 
		 loop Bloodloop

		 add eax,5
		 mov temp,eax

		mov edx,offset stringA								; Asking for amount of blood
		call writestring
 
		 call crlf
		 mov edx,offset A
		 mov ecx,sizeof A
		 call readstring
		 ;call writestring
		 mov eax,temp
		 mov esi,eax
		 mov edx,0

		 Amountloop:
			 mov al,A[edx]
			 mov arr[esi],al

			 inc edx
			 inc esi 
		 loop Amountloop

	 add eax,5
	 mov temp,eax
	 jmp menucard
	
	L2:

		mov esi,0
		mov ecx,50
		call crlf

		Print:

			mov al,arr[esi]
			mov edx,offset arr
			call writechar
			inc esi

		loop Print

	 jmp menucard


	_exit:
		INVOKE ExitProcess, 0

main ENDP


End Main 
