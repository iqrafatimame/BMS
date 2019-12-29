  
INCLUDE Irvine32.inc

.data
lineNo BYTE 1
outputLine BYTE ?
filename BYTE "BLOOD.txt",0
BUFFER_SIZE = 5000
buffer BYTE BUFFER_SIZE DUP(?)
filehandle DWORD ?
bytesWritten dword 1 dup(0)
bytesRead dword 1 dup(0)
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
 arr byte 50 dup(?)
N byte  5 dup(?)
B byte 5 dup(?)
A byte 5 dup(?)
temp dword 0

; Strings for the print function
strName byte "Name: ", 0
strBlood byte "Blood Group: ", 0
strAmount byte "Amount: ", 0
currentOption dword 1
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

	;Read from File
	INVOKE CreateFile,
	ADDR filename, ; ptr to filename
	GENERIC_READ, ; mode = Can read
	DO_NOT_SHARE, ; share mode
	NULL, ; ptr to security attributes
	OPEN_ALWAYS, ; open an existing file
	FILE_ATTRIBUTE_NORMAL, ; normal file attribute
	0 ; not used

	mov filehandle, eax ; Copy handle to variable

	invoke ReadFile,
	filehandle, ; file handle
	addr arr, ; where to read
	50, ; num bytes to read
	addr bytesRead, ; bytes actually read
	0

	invoke CloseHandle, filehandle

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
		mov edx,offset N
		mov ecx,sizeof N
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

		mov eax, temp
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

		 mov eax, temp
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

	mov eax, temp
	 add eax,5
	 mov temp,eax
	 jmp menucard
	
	L2:

		mov esi,0
		mov ecx,50
		mov ebx, 0

		call crlf

		Print:
			
			;Reset value of ebx if its greater than 5
			print_calc:
				cmp ebx, 0
				je print_name
				cmp ebx, 4
				je print_blood
				cmp ebx, 6
				je print_amount
				cmp ebx, 8
				je print_reset
				jmp print_main

			print_reset:
				mov ebx, 0
				jmp print_calc

			;Print Name:
			print_name:
				mov edx, offset strName
				call writestring
				jmp print_main
			;Print Blood Group:

			print_blood:
				mov edx, offset strBlood
				call writestring
				jmp print_main

			;Print Amount:
			print_amount:
				mov edx, offset strAmount
				call writestring
				jmp print_main

			print_main:
				mov al,arr[esi]
				mov edx,offset arr
				call writechar
				inc esi
				inc ebx

		loop Print

		INVOKE CreateFile,
		ADDR filename, ; ptr to filename
		GENERIC_WRITE, ; mode = Can read
		DO_NOT_SHARE, ; share mode
		NULL, ; ptr to security attributes
		OPEN_ALWAYS, ; open an existing file
		FILE_ATTRIBUTE_NORMAL, ; normal file attribute
		0 ; not used

		mov filehandle, eax ; Copy handle to variable

		INVOKE WriteFile,
		filehandle, ; file handle
		addr arr, ; msg to write
		sizeof arr, ; size of bytes to write
		addr bytesWritten,; num bytes written
		0

		call writeint

		invoke CloseHandle,filehandle

	 jmp menucard


	_exit:
		INVOKE ExitProcess, 0

main ENDP


End Main 
