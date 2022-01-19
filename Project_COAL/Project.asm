TITLE Hotel Management System

INCLUDE Irvine32.inc

BUFFER_SIZE = 25

.data
Welcome BYTE "Welcome to SKBZ Hotels", 0
Welcome2 BYTE "SKBZ Hotels", 0
Welcome3 BYTE "Thanks, come again!", 0
Fill BYTE "----------------------", 0  
Loading BYTE "Please wait...", 0
Menu BYTE "Services Available: ", 0
S1 BYTE "1. Rooms", 0
S2 BYTE "2. Food and Fine Dining", 0
H_Back BYTE "4. Back", 0
Dep BYTE "Wrong Option Selected, Terminating Program........", 0
Count DWORD 0

H BYTE "*----------*Room Packages*----------*", 0 
HS1 BYTE "1. Solo Package (1 Room w/ Single Bed + Breakfast + Lunch + Dinner)                                - PKR 7500 per night", 0 
HS2 BYTE "2. Couple Package (1 Room w/ Double Bed + Breakfast + Lunch + Dinner)                              - PKR 9000 per night", 0 
HS3 BYTE "3. Family Package (2 Rooms w/ Double Bed + Breakfast + Lunch + Dinner + Curricular Activities)     - PKR 15000 per night", 0 
Info1 BYTE "Number of Nights: ", 0
Info2 BYTE "Name: ", 0
Info3 BYTE "Contact Details: ", 0
Print1 BYTE "Payable Amount: ", 0
Total DWORD 0

F BYTE "*---------*Food Categories*---------*", 0 
F_Back BYTE "5. Back", 0
F_Quantity BYTE "Enter Quantity: ", 0
F_Order BYTE "Do you want to order more? ", 0
F_Title BYTE "Confirmation Pop-Up", 0

Food_Menu_1 BYTE "1. Pakistani & Continental Rice", 0  
Food_Menu_2 BYTE "2. BBQ", 0
Food_Menu_3 BYTE "3. Handis & Karahi", 0
Food_Menu_4 BYTE "4. Rotis", 0

Rice_Menu_1 BYTE "1. Biryani - Rs.120", 0
Rice_Menu_2 BYTE "2. Chicken Pulao - Rs.120", 0
Rice_Menu_3 BYTE "3. Matar Pulao - Rs.100", 0
Rice_Menu_4 BYTE "4. Singaporean Rice - Rs.175", 0 
Rice_Menu_5 BYTE "5. Chicken Shashlick w/ Rice - Rs.220", 0

BBQ_Menu_1 BYTE "1. BBQ Tikka - Rs.120", 0
BBQ_Menu_2 BYTE "2. Malai Boti - Rs.345", 0
BBQ_Menu_3 BYTE "3. Bihari Kebab - Rs.320", 0
BBQ_Menu_4 BYTE "4. Reshmi Kebab - Rs.320", 0
BBQ_Menu_5 BYTE "5. Seekh Kebab - Rs.320", 0

Handi_Menu_1 BYTE "1. Chicken Karahi - Rs.1320", 0
Handi_Menu_2 BYTE "2. Beef Karahi - Rs.1500", 0
Handi_Menu_3 BYTE "3. Mutton Karahi - Rs.1500", 0
Handi_Menu_4 BYTE "4. Chicken Handi - Rs.1250", 0
Handi_Menu_5 BYTE "5. Chicken Tikka Karahi - Rs.1400", 0

Roti_Menu_1 BYTE "1. Naan - Rs.15", 0
Roti_Menu_2 BYTE "2. Chapati - Rs.15", 0 
Roti_Menu_3 BYTE "3. Roghni Naan - Rs.35", 0
Roti_Menu_4 BYTE "4. Kandhari Naan - Rs.50", 0
Roti_Menu_5 BYTE "5. Garlic Naan - Rs.45", 0

fileName BYTE "CustomerCopy.txt", 0
fileHandle HANDLE ?
buffer BYTE BUFFER_SIZE DUP(?)
string_len DWORD ?
space BYTE "-->", 0

.code
main PROC

	mov dh, 12
	mov dl, 46
	call Gotoxy
	mov EDX, offset Fill
	call WriteString
	mov dh, 13
	mov dl, 46
	call Gotoxy
	mov EDX, offset Welcome
	call WriteString
	mov dh, 14
	mov dl, 46
	call Gotoxy
	mov EDX, offset Fill
	call WriteString
	mov EAX, 1500
	call Delay
	call Clrscr
	mov dh, 13
	mov dl, 46
	call Gotoxy
	mov EDX, offset Loading
	call WriteString
	mov EAX, 3500
	call Delay

	call Clrscr


	call Crlf
	call Main_Menu

exit
main ENDP

Main_Menu PROC
		
		call clrscr
		call Template

		call crlf
		call Clr

		mov EDX, offset Menu
		call WriteString
		call Crlf
		mov EDX, offset S1
		call WriteString
		call Crlf
		mov EDX, offset S2
		call WriteString
		call Clr
		call Crlf
		call ReadInt
		cmp EAX, 1
		JE Rooms
		cmp EAX, 2
		JE Dining
		call Clr
		call Depart

		Rooms:
			call Hotel

		Dining:
			call Food

Main_Menu ENDP

Hotel PROC
	
	call Clr
	call Clrscr

	call Template
	
	call Clr 


	mov dh, 5
	mov dl, 36
	call Gotoxy
	mov EDX, offset H
	call WriteString
	call crlf
	call crlf
	mov EDX, offset HS1
	call WriteString
	call crlf
	mov EDX, offset HS2
	call WriteString
	call crlf
	mov EDX, offset HS3
	call WriteString
	call crlf
	mov EDX, offset H_Back
	call WriteString
	call crlf
	call ReadInt

	cmp EAX, 1
	JE Solo
	cmp EAX, 2
	JE Couple
	cmp EAX, 3
	JE Family
	cmp EAX, 4
	JE MM
	call Depart

	Solo:
		call Clr

		mov EDX, offset Info1
		call WriteString
		call crlf
		call ReadInt

		mov CX, 7500
		mul CX
		call crlf
		mov EDX, offset Print1
		call WriteString
		call WriteDec
		call crlf
		mov Total, EAX

		call Clr

		mov EDX, offset fileName
		call CreateOutputFile
		mov fileHandle, EAX

		mov EDX, offset Info2
		call WriteString
		mov ECX, BUFFER_SIZE
		mov EDX, offset buffer
		call ReadString
		mov string_len, EAX
		call crlf

		mov EAX, fileHandle
		mov EDX, offset buffer
		mov ECX, string_len
		call WriteToFile

		call Clr 

		mov EAX, fileHandle
		mov EDX, offset space
		mov ECX, 3
		call WriteToFile

		call Clr 

		mov EDX, offset Info3
		call WriteString
		mov ECX, BUFFER_SIZE
		mov EDX, offset buffer
		call ReadString
		mov string_len, EAX
		call crlf

		mov EAX, fileHandle
		mov EDX, offset buffer
		mov ECX, string_len
		call WriteToFile

		call CloseFile
		exit  

	Couple:
		call Clr

		mov EDX, offset Info1
		call WriteString
		call crlf
		call ReadInt

		mov CX, 9000
		mul CX
		call crlf
		mov EDX, offset Print1
		call WriteString
		call WriteDec
		call crlf
		mov Total, EAX

		call Clr

		mov EDX, offset fileName
		call CreateOutputFile
		mov fileHandle, EAX

		mov EDX, offset Info2
		call WriteString
		mov ECX, BUFFER_SIZE
		mov EDX, offset buffer
		call ReadString
		mov string_len, EAX
		call crlf

		mov EAX, fileHandle
		mov EDX, offset buffer
		mov ECX, string_len
		call WriteToFile

		call Clr 

		mov EAX, fileHandle
		mov EDX, offset space
		mov ECX, 3
		call WriteToFile

		call Clr 

		mov EDX, offset Info3
		call WriteString
		mov ECX, BUFFER_SIZE
		mov EDX, offset buffer
		call ReadString
		mov string_len, EAX
		call crlf

		mov EAX, fileHandle
		mov EDX, offset buffer
		mov ECX, string_len
		call WriteToFile

		call CloseFile
		exit 

	Family:
		call Clr

		mov EDX, offset Info1
		call WriteString
		call crlf
		call ReadInt

		mov CX, 15000
		mul CX
		call crlf
		mov EDX, offset Print1
		call WriteString
		call WriteDec
		call crlf
		mov Total, EAX

		call Clr

		mov EDX, offset fileName
		call CreateOutputFile
		mov fileHandle, EAX

		mov EDX, offset Info2
		call WriteString
		mov ECX, BUFFER_SIZE
		mov EDX, offset buffer
		call ReadString
		mov string_len, EAX
		call crlf

		mov EAX, fileHandle
		mov EDX, offset buffer
		mov ECX, string_len
		call WriteToFile

		call Clr 

		mov EAX, fileHandle
		mov EDX, offset space
		mov ECX, 3
		call WriteToFile

		call Clr 

		mov EDX, offset Info3
		call WriteString
		mov ECX, BUFFER_SIZE
		mov EDX, offset buffer
		call ReadString
		mov string_len, EAX
		call crlf

		mov EAX, fileHandle
		mov EDX, offset buffer
		mov ECX, string_len
		call WriteToFile

		call CloseFile
		exit 

		MM:
			call clrscr
			call Main_Menu

Hotel ENDP

Food PROC
	
	Food_Menu:

		call Clr
		call Clrscr

		call Template
	
		call Clr 
		call crlf

		mov dh, 5
		mov dl, 36
		call Gotoxy
		mov EDX, offset F
		call WriteString
		call crlf
		call crlf

		call Clr
	
		mov EDX, offset Food_Menu_1
		call WriteString
		call crlf
		mov EDX, offset Food_Menu_2
		call WriteString
		call crlf
		mov EDX, offset Food_Menu_3
		call WriteString
		call crlf
		mov EDX, offset Food_Menu_4
		call WriteString
		call crlf
		mov EDX, offset F_Back
		call WriteString
		call crlf
		call ReadInt

		cmp EAX, 1
		JE Rice
		cmp EAX, 2
		JE BBQ
		cmp EAX, 3
		JE Handi
		cmp EAX, 4
		JE Rotis
		cmp EAX, 5
		JE M_M
		call Depart

	Rice:
		call Clr
		call Clrscr

		call Template
	
		call Clr 
		call crlf

		mov EDX, offset Rice_Menu_1
		call WriteString
		call crlf
		mov EDX, offset Rice_Menu_2
		call WriteString
		call crlf
		mov EDX, offset Rice_Menu_3
		call WriteString
		call crlf
		mov EDX, offset Rice_Menu_4
		call WriteString
		call crlf
		mov EDX, offset Rice_Menu_5
		call WriteString
		call crlf
		call ReadInt

		cmp EAX, 1
		JE R1
		cmp EAX, 2
		JE R2
		cmp EAX, 3
		JE R3
		cmp EAX, 4
		JE R4
		cmp EAX, 5
		JE R5
		call Depart

		R1:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 120
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		R2:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 120
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		R3:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 100
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		R4:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 175
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		R5:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 220
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

	BBQ:
		call Clr
		call Clrscr

		call Template
	
		call Clr 
		call crlf

		mov EDX, offset BBQ_Menu_1
		call WriteString
		call crlf
		mov EDX, offset BBQ_Menu_2
		call WriteString
		call crlf
		mov EDX, offset BBQ_Menu_3
		call WriteString
		call crlf
		mov EDX, offset BBQ_Menu_4
		call WriteString
		call crlf
		mov EDX, offset BBQ_Menu_5
		call WriteString
		call crlf
		call ReadInt

		cmp EAX, 1
		JE B1
		cmp EAX, 2
		JE B2
		cmp EAX, 3
		JE B3
		cmp EAX, 4
		JE B4
		cmp EAX, 5
		JE B5
		call Depart

		B1:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 120
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		B2:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 345
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		B3:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 320
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		B4:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 320
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		B5:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 320
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt
	exit

	Handi:
		call Clr
		call Clrscr

		call Template
	
		call Clr 
		call crlf

		mov EDX, offset Handi_Menu_1
		call WriteString
		call crlf
		mov EDX, offset Handi_Menu_2
		call WriteString
		call crlf
		mov EDX, offset Handi_Menu_3
		call WriteString
		call crlf
		mov EDX, offset Handi_Menu_4
		call WriteString
		call crlf
		mov EDX, offset Handi_Menu_5
		call WriteString
		call crlf
		call ReadInt

		cmp EAX, 1
		JE H1
		cmp EAX, 2
		JE H2
		cmp EAX, 3
		JE H3
		cmp EAX, 4
		JE H4
		cmp EAX, 5
		JE H5
		call Depart

		H1:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 1320
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		H2:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 1500
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		H3:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 1500
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		H4:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 1250
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		H5:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 1400
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

	exit

	Rotis:
		call Clr
		call Clrscr

		call Template
	
		call Clr 
		call crlf

		mov EDX, offset Roti_Menu_1
		call WriteString
		call crlf
		mov EDX, offset Roti_Menu_2
		call WriteString
		call crlf
		mov EDX, offset Roti_Menu_3
		call WriteString
		call crlf
		mov EDX, offset Roti_Menu_4
		call WriteString
		call crlf
		mov EDX, offset Roti_Menu_5
		call WriteString
		call crlf
		call ReadInt

		cmp EAX, 1
		JE RO1
		cmp EAX, 2
		JE RO2
		cmp EAX, 3
		JE RO3
		cmp EAX, 4
		JE RO4
		cmp EAX, 5
		JE RO5
		call Depart

		RO1:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 15
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		RO2:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 15
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		RO3:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 35
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		RO4:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 50
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt

		RO5:
			call Clr
			call crlf

			mov EDX, offset F_Quantity
			call WriteString
			call ReadDec

			mov CX, 45
			mul CX

			add EAX, Total
			mov Total, EAX

			mov EBX, offset F_Title
			mov EDX, offset F_Order
			call MsgBoxAsk

			cmp EAX, 6
			mov EAX, Total
			JE Food_Menu
			push EAX
			inc Count

		jmp Receipt
	exit

	Receipt:
		call Clr
		call Clrscr

		mov dh, 0
		mov dl, 44
		call Gotoxy
		mov EDX, offset Fill
		call WriteString
		mov dh, 1
		mov dl, 45
		call Gotoxy
		mov EDX, offset Welcome3
		call WriteString
		mov dh, 2
		mov dl, 44
		call Gotoxy
		mov EDX, offset Fill
		call WriteString
	
		call Clr 
		call crlf

		mov EDX, offset Print1
		call WriteString
		POP EAX
		call WriteDec
		exit

	M_M:
		call Main_Menu

Food ENDP

Clr PROC
	mov EAX, 0
	mov EDX, 0
	mov ESI, 0
	mov EBX, 0
	mov ECX, 0
	ret
Clr ENDP

Depart PROC
	mov EDX, offset Dep
	call WriteString
	mov EAX, 2500
	call Delay
	exit
Depart ENDP

Template PROC
		mov dh, 0
		mov dl, 44
		call Gotoxy
		mov EDX, offset Fill
		call WriteString
		mov dh, 1
		mov dl, 50
		call Gotoxy
		mov EDX, offset Welcome2
		call WriteString
		mov dh, 2
		mov dl, 44
		call Gotoxy
		mov EDX, offset Fill
		call WriteString
		ret
Template ENDP

END main