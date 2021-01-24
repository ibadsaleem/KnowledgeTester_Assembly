INCLUDE irvine32.inc;
fetch_answers PROTO  , target : DWORD
generate_questions PROTO  , target : DWORD
gethelpline1 PROTO, ans : BYTE
gethelpline2 PROTO, ans : BYTE
check_letter PROTO, arraypoint: PTR BYTE,array2point:PTR BYTE,sizes:dword,inputchar:BYTE
PLACE_RAND PROTO arrayword:PTR byte, sizes:dword;
READFILE1 PROTO, filename: PTR BYTE 
FETCH_WORD PROTO  , target : DWORD
IEW PROTO, arryw:ptr byte,sizes1:dword
STRCOPY PROTO, sindex: ptr byte,eindex: ptr byte
printway proto , sindex:PTR BYTE , countsize:dword
printls PROTO
FRONTEND PROTO
Screen3 PROTO;
Screen2 PROTO;
Screen4 PROTO;

SASTAHANGMAN PROTO
print proto, pointer:PTR BYTE,size1:BYTE,colorcode:BYTE
printSpaces proto 
.data
history BYTE "USERS history",0;
endtitle BYTE "WARNING",0;
endmsg BYTE "DO U REALLY WANT TO CLOSE THE APPLICATION", 10,"ALL YOUR PREVIOUS DATA WILL BE LOST",0 

SP1 byte "						",0;
SUCCESS BYTE 10,"YOUR ANSWER IS CORRECT",0;
FAILURE BYTE 10,"YOUR ANSWER IS INCORRECT",0;
scrmsg BYTE "SCORE : ",0;
lifemsg BYTE "LIVE :  ",0;
number DWORD 0;
score DWORD 0;
finalmsg BYTE " YOUR SCORE IS = ",0;
ANSMSG BYTE "AS A FRIEND!!! I THINK THE ANSWER MIGHT BE ",0; 
HELPMSG1 BYTE 10,"TO GET HELPLINE PRESS	",10, "				F->	SKIP Question   -   ",0;
HELPMSG2 BYTE 10,"				R->	FRIEND HELPLINE  -  ",0;
HELPLINE1 BYTE 1;		;initaizlize to 1 evrey time
HELPLINE2 BYTE 1;
FILE_GK BYTE "QuestionsBank.txt",0;
filename1 BYTE "AnswersBank.txt",0;
buffsize_GK =  20000;
buffer BYTE buffsize_GK DUP(0);
answersize = 1000;
question BYTE 10000 DUP(0);
answers BYTE answersize DUP(?);
LIFES_GK DWORD 3;
var DWORD ?;
spaces byte "													",0
spaces1 byte "								",0
words BYTE 1000 DUP(?)
lives dword 3
randword BYTE 15 DUP(?)
count DWORD -1
emptyword BYTE 15 DUP('-')
filep BYTE "HangmanGame.txt",0; 
filehandle dword ?
buffer1 byte 1000 dup(?)
buffsize dword 1000 
hanglife dword 2
scorehang dword 0
scoremsg byte "Score: ",0
livesmsg byte "Lives: ",0
correctmsg byte "CORRECT!",0
incorrectmsg byte "INCORRECT!",0
i dword 1
linen BYTE "____________________________________________________________________________________________________________________",0;
questionData BYTE 2000 DUP(0);
answersData BYTE 200 DUP(0);
username BYTE 30 DUP(?);
LIFES BYTE 3;		;3 lives
GameName BYTE "KNOWLEDGE TESTER",0;
Waitingmsg BYTE "PRESS ANY KEY TO CONTINUE...",0;
Games BYTE 10,"1)	GK KNOWLEDGE",10,10, "2)	HANGAROO	",10, "PRESS ANY KEY TO GO BACK",0 
Emessage BYTE "PRESS E TO EXIT",0;
Members BYTE "GROUP MEMBERS :-",0;
RULESTITLE BYTE "RULES",0;
RULES BYTE "1)Play fairly donot cheat, those who cheat are losers.",10,10,"2)Each player has 3 lives, hence have 3 chances to commit mistake",10,10,"3)Player have 3 help lines",10,10,"4)EACH quetion comprises of 10 points",10,0;
RULES2 BYTE "6)TURN on caps lock for GAME 1",0;
RULES3 BYTE "5)TURN OFF CAPS LOCK FOR HANGAROO (GAME 2) ",0
Member1 BYTE "SHAH TANZEEL AHMED",0;
Member2 BYTE "MUHAMMAD IBAD SALEEM",0;
Member3 BYTE "ALI HAMZA USMANI",0;
PromptMessage BYTE "ENTER YOUR NAME : ",0;
filenamedata BYTE "scores.txt",0;
bufferfile BYTE 100 DUP(0);
handlefile1 DWORD ?;
tempsymbol BYTE ",",10,0;
resultdata BYTE 100 DUP(0);


.code

openfile PROC
push edx;
push eax;
push ecx;
mov edx,OFFSET filenamedata
call OpenInputFile
mov handlefile1, EAX

mov eax, handlefile1 ;assuming handlefile1 contains handle of an open file
mov edx, OFFSET bufferfile ;bufferfile will contain the text read from the file
mov ecx, 100 ;specify how many bytes to read
call ReadFromFile;
mov edx, OFFSET bufferfile ;bufferfile will contain the text read from the file
mov ecx, SIZEOF bufferfile ;
;call WriteString;
pop ecx;
pop eax;
pop edx;
ret;
openfile ENDP;

getdatafromfile1 PROC , scr : BYTE

push esi;
push eax;
push edi;
push ebx;
push ecx;
push edx;

INVOKE str_length , addr bufferfile;

mov ecx , eax;
mov edi , OFFSET bufferfile;
add edi , ecx;





INVOKE str_length , addr username;
mov ecx , eax;
mov esi , OFFSET username;
rep movsb;

mov esi , OFFSET tempsymbol;
movsb;
movzx eax , scr;
cmp eax , 0
je zero;



mov ebx , 10;
L1:
	mov edx , 0;
	cmp eax , 0;
	jle go; 
	div ebx;
	mov ebx , eax;
	mov eax , edx;
	
	add eax , '0';
	
	mov BYTE PTR  [edi] , al;
	mov eax,  ebx;
	
	inc edi;
	mov ebx , 10;
jmp L1;
zero:
mov al , '0';
mov BYTE PTR  [edi] , '-';
inc edi;

jmp go1
go:
dec edi;
mov esi , edi;
sub esi , 1;
mov al  , [esi];
mov bl , [edi];
mov [esi] , bl;
mov [edi] ,al;
add edi , 1;

go1:
mov esi , OFFSET tempsymbol;
inc esi;
movsb;

mov BYTE PTR [edi],0;
call closefile;

pop edx;
pop ecx;
pop ebx;
pop edi
pop eax;
pop esi;

ret;
getdatafromfile1 ENDP;

createfileandput PROC
push edx;
push ecx;

mov edx, offset filenamedata
call CreateOutputfile;
mov handlefile1, eax
mov eax, handlefile1 ; assuming that handlefile1 contains handle of an open file
mov edx, OFFSET bufferfile ;bufferfile from where text will be written to file
mov ecx, 100 ;number of bytes to be written to file from the bufferfile
call WriteToFile
pop ecx;
pop edx;
ret;
createfileandput ENDP;


main PROC


call openfile;
START1:

INVOKE FrontEnd;		;frontend
call ReadChar;
call clrscr;
call crlf;
cmp al , 045h
je end1;
cmp al , 065h;
je end1;
push edx;
push ecx;
mov edx , OFFSET history;
mov ecx , SIZEOF history;
call WriteString;
call crlf;
call crlf;

mov edx , OFFSET bufferfile;
INVOKE str_length , addr bufferfile;
add eax , 1;
mov ecx ,eax;
call WriteString;
pop ecx
pop edx;

INVOKE Screen2;

mov edx , OFFSET username;
mov ecx , SIZEOF username;
call ReadString;

INVOKE Screen3;
call ReadChar;
call clrscr;

INVOKE Screen4;
call ReadInt;
call clrscr;

;user name;
;general knwoldege

cmp eax , 1
jne notfirst;
;call Knowledge tester
call Knowledge_test;
	call clrscr;
	call crlf;
	call crlf;
	call crlf;
	mov edx, OFFSET SP1
	mov ecx , SIZEOF SP1;
	call WriteString;
	mov edx , OFFSET username;
	mov ecx , SIZEOF username;
	call writestring
	mov edx , OFFSET finalmsg;
	mov ecx , SIZEOF finalmsg;
	call WriteString;
	mov eax , score;
	
	call WriteDec;
	call crlf;
	mov eax , score;
	INVOKE getdatafromfile1,al;
	
	mov eax,  2000;
	call Delay;	
	call clrscr;
	
jmp gothere;
notfirst:
cmp eax , 2
jne gothere;
mov lives , 3;
mov scorehang , 0;
	INVOKE SASTAHANGMAN;
	call clrscr;
	call crlf;
	call crlf;
	call crlf;
	mov edx, OFFSET SP1
	mov ecx , SIZEOF SP1;
	call WriteString;
	mov edx , OFFSET username;
	mov ecx , SIZEOF username;
	call writestring
	mov edx , OFFSET finalmsg;
	mov ecx , SIZEOF finalmsg;
	call WriteString;
	mov eax , scorehang;
	
	call WriteDec;
	call crlf;
	mov eax , scorehang;
	INVOKE getdatafromfile1,al;
	mov eax,  2000;
	call Delay;	
	call clrscr;
 ;jmp DEAD;

 gothere:
 call createfileandput;
jmp START1;
;INVOKE print,ADDR GameName,SIZEOF GameName , 4;

	



end1:
push edx;
push ebx;
mov edx , OFFSET endmsg;
mov ebx , OFFSET endtitle;
call msgboxask;
cmp eax , 6
jne START1;
pop ebx;
pop edx;




DEAD:

exit;
main ENDP;



Screen4 PROC
push edx;
call clrscr;
INVOKE print, ADDR GAMES, SIZEOF GAMES , 15;


pop edx;
ret;
Screen4 ENDP;



Screen3 PROC
call clrscr;
push edx;

call skiplines;

call printSpaces;

INVOKE print, ADDR RULESTITLE , SIZEOF RULESTITLE , 2;

call crlf;
INVOKE print, ADDR linen , SIZEOF linen , 2;

call skiplines;
INVOKE print, ADDR RULES , SIZEOF RULES , 2;

INVOKE print, ADDR RULES3 , SIZEOF RULES3 ,6 ;
call crlf;
INVOKE print, ADDR RULES2 , SIZEOF RULES2 ,6 ;

pop edx;
ret;
Screen3 ENDP;

Screen2 PROC
push edx;
push ecx;
call skiplines;
call printSpaces;
mov edx , OFFSET PromptMessage;
mov ecx , SIZEOF PromptMessage;
call WriteString;
 pop ecx;
 pop edx;

ret;
Screen2 ENDP;


FrontEnd PROC
call skiplines;

INVOKE print,ADDR Linen,SIZEOF Linen , 4;
call crlf;

call printSpaces;
INVOKE print,ADDR GameName,SIZEOF GameName , 4;

INVOKE print,ADDR Linen,SIZEOF Linen , 4;
call crlf;

call skiplines;
call printSpaces;
INVOKE print,ADDR Waitingmsg,SIZEOF Waitingmsg,1;
call skiplines;

call printSpaces;
INVOKE print , ADDR Emessage , SIZEOF Emessage,1;
call crlf;
call skiplines;

call printSpaces;
call printSpaces;

INVOKE print , ADDR Members , SIZEOF Members , 2;
call printSpaces;
call printSpaces;

INVOKE print , ADDR Member1 , SIZEOF Member1,2;

call printSpaces;
call printSpaces;

INVOKE print , ADDR Member2 , SIZEOF Member2,2;
call printSpaces;
call printSpaces;
INVOKE print , ADDR Member3 , SIZEOF Member3,2;


ret;
FrontEnd ENDP

skiplines PROC
push ecx;
mov ecx , 3;
L1:
call crlf;
loop L1
pop ecx;
ret;
skiplines ENDP



printSpaces PROC
push ecx;
mov ecx , 5;
L1:
	mov eax ,9;
	call WriteChar;
loop L1
pop ecx;
ret;
printSpaces ENDP

print PROC, pointer:PTR BYTE , size1:BYTE , colorcode : BYTE 
push eax;
push edx;
push ecx;
movzx eax , colorcode;
call SetTextColor;
mov edx ,  pointer;
movzx ecx , size1;
call WriteString;
call crlf;
pop ecx;
pop edx;
pop eax;
ret;
print ENDP


SASTAHANGMAN PROC
INVOKE READFILE1, ADDR filep

l33:

cmp ecx,0
je outerr
push ecx
mov count,0
mov edx,offset buffer1
mov ecx,sizeof buffer1
call Randomize
mov eax,90
call randomrange

INVOKE FETCH_WORD, eax
INVOKE STRCOPY ,edi, esi
;mov al,randword[6]
;call writechar
mov eax,count
;call writedec
call crlf
INVOKE IEW, ADDR emptyword,count
INVOKE PLACE_RAND, ADDR randword,count

INVOKE printway, addr emptyword,count;
mov i,1
wordguesser:
call clrscr

INVOKE printls
mov ecx,5

l12:
call crlf
loop l12
mov edx,offset spaces1
push ecx
mov ecx,sizeof spaces1
call writestring
pop ecx
INVOKE printway, addr emptyword,count;
mov eax,i
cmp lives,0
je outerr
cmp eax,count
je finished
call readchar
INVOKE check_letter, ADDR randword,ADDR emptyword,count,al
mov eax,ebx
add i,ebx
call writedec
call crlf
INVOKE printway, addr emptyword,count;
call crlf
jmp wordguesser
finished:
mov eax,500
call delay
add scorehang,5
mov ecx,5
l13:
call crlf
loop l13

INVOKE printway,addr spaces1,lengthof spaces1
INVOKE printway, addr correctmsg,lengthof correctmsg
pop ecx
DEC ecx
mov eax,1000
call delay
jmp l33
outerr:
call crlf;
mov edx , OFFSET spaces1;
mov ecx, SIZEOF spaces1;
call WriteString;
mov edx , OFFSET randword;
mov ecx, SIZEOF randword;
mov eax , 2000;
call WriteString;

call Delay;

call clrscr
pop ecx;

ret;
SASTAHANGMAN ENDP


printls PROC
push edx 
push ecx
push eax
mov edx,offset scoremsg
mov ecx,sizeof scoremsg
call writestring
mov eax,scorehang
call writedec
mov edx,offset spaces
mov ecx,offset spaces
call writestring
mov edx,offset livesmsg
mov ecx,sizeof livesmsg
call writestring
mov eax,lives
call writedec
pop eax
pop ecx 
pop edx
call crlf
ret
printls endp
check_letter PROC, arraypoint: PTR BYTE,array2point:PTR BYTE,sizes:dword,inputchar:BYTE
LOCAL counts : dword 
push esi
push edi
push ecx
mov counts,0
mov esi, arraypoint	    ;randword
mov edi, array2point	;emptyword
mov ecx,sizes
l1:
mov al,BYTE PTR [esi]
cmp al,inputchar
jne L2
mov BYTE PTR [edi],al
add counts,1
L2:
add esi,TYPE randword
add edi,TYPE emptyword
loop l1 
cmp counts ,0
jne ll
mov ecx,4
l12:
call crlf
loop l12
INVOKE printway,addr spaces1,lengthof spaces1
INVOKE printway, addr incorrectmsg,lengthof incorrectmsg
mov eax,1000
call delay
call crlf
sub lives,1

ll:
mov ebx,counts
pop ecx
pop edi
pop esi
ret
check_letter endp

PLACE_RAND PROC arrayword:PTR byte, sizes:dword
;LOCAL counter:dword
push edx
push esi
push ecx
push eax
push ebx
mov esi, arrayword
mov ecx,sizes
call randomize
mov eax,sizes
call randomrange
mov ebx,eax
mov eax,0
mov edx,eax
l1:

mov eax,0
cmp edx,ebx
jne again
mov al, [esi]
mov emptyword[edx],al
jmp outerr
again:
INC esi
INC edx
loop l1
outerr:
pop ebx
pop eax
pop ecx 
pop esi
pop edx
ret
PLACE_RAND ENDP 

IEW PROC, arryw:ptr byte,sizes1:dword
push ecx
push edi
mov edi,arryw
cld
mov ecx,sizes1
l1:
mov eax,0
mov al,'-';
stosb  
loop l1
pop edi
pop ecx
RET
IEW ENDP

STRCOPY PROC , sindex:ptr byte, eindex:ptr byte
push esi
push edi
push ecx
push ebx
mov ebx, offset randword
mov esi, eindex
mov edi, sindex
L1:
cmp esi,edi
jl LL
mov al, [edi]
mov [ebx],al
add count,1
INC edi
INC ebx
jmp L1
LL:
pop ebx
pop ecx
pop edi
pop esi
dec count
ret
STRCOPY ENDP

;Printing Function

printway proc , sindex:PTR BYTE , countsize:dword 
push esi
push ecx
mov esi, sindex
mov ecx,countsize
printer:
movzx eax ,BYTE PTR[esi]
call writechar
INC esi
loop printer
pop ecx
pop esi
ret
printway endp


READFILE1 PROC, filename: PTR BYTE 
push edx;
push eax;
push ecx;
mov edx ,filename;
call OpenInputFile;
mov filehandle , eax;
mov eax,  filehandle
mov edx , OFFSET buffer1;
mov ecx , buffsize;
call ReadFromFile;
pop ecx;
pop eax;
pop edx;
ret;
READFILE1 ENDP

FETCH_WORD PROC  , target : DWORD

LOCAL q  : DWORD;
mov ecx , buffsize;
mov esi , OFFSET buffer1;
mov eax, 0;
mov eax , 4;
mov ebx , target;		;;random value
mov q , 0;
mov edi , esi;
L1:
	
	mov al , BYTE PTR [esi]
	cmp al ,0Ah;
	jne notsame; 
	inc q;
	cmp q , ebx;			
	je go;
	inc esi;
	mov edi , esi;
	dec esi;
	notsame:

	back:
	inc esi;
loop L1;
go:
call crlf;
mov eax , 0;
mov al , [edi];
dec esi;
mov eax, 0;
mov al , [esi];
ret;
FETCH_WORD ENDP;



SCOREBOARD PROC

push edx;
push ecx;
push eax;
mov edx , OFFSET scrmsg;
mov ecx , SIZEOF scrmsg;
call WriteString;
mov eax , score;
call WriteDec;
mov edx , OFFSET SP1;
mov ecx , SIZEOF SP1;
call WriteString;
mov edx , OFFSET lifemsg;
mov ecx , SIZEOF lifemsg;
call WriteString;
mov eax , LIFES_GK;
call WriteDec;
call crlf;

pop eax;
pop ecx;
pop edx;
ret;


SCOREBOARD ENDP

Knowledge_test PROC
mov LIFES_GK , 3;
mov score ,0;
mov HELPLINE1, 1;
mov HELPLINE2 , 1;
call loaddata;

mov ecx  , 5;

L1:
cmp LIFES_GK , 0;
je GOOUT;
call SCOREBOARD;	
mov edx , OFFSET HELPMSG1;
mov ecx , SIZEOF HELPMSG1;
movzx eax , HELPLINE1;
call WriteString;
call WriteDec;
mov edx , OFFSET HELPMSG2;
mov ecx , SIZEOF HELPMSG2;
movzx eax , HELPLINE2;
call WriteString;
call WriteDec;

call crlf;
call crlf;

push ecx;
;inc number;
;mov eax , number;
;call WriteDec;


call Randomize;	
mov eax , 90;	
call RandomRange;


		
mov var , eax;
INVOKE generate_questions,var ;
call printquestions;

call loadanswers;

INVOKE fetch_answers,var;

;call printquestions;
;ebx
GOBACK:
call ReadChar;
mov bl , al;
cmp al , 046h;
jne nothing
cmp HELPLINE1 , 0
je GOBACK;
sub HELPLINE1 ,1;
call clrscr;
POP ecx;
jmp  L1;
nothing:

cmp al , 052h;
jne notsecondhelplline
cmp HELPLINE2 , 0
je GOBACK;
SUB HELPLINE2 , 1;
push edx;
push ecx;
push eax;
inc edi;
mov edx , OFFSET ANSMSG;
mov ecx , SIZEOF ANSMSG;
call WriteString;
mov al , BYTE PTR [edi];
dec edi;
call WriteChar;
call crlf;
pop eax;
pop ecx;
pop edx;
jmp  GOBACK;
notsecondhelplline:


mov al, BYTE PTR [edi+1]
push eax;
mov al , bl;
call WriteChar;
call crlf;


pop eax;
cmp bl , 045h;
jge GOBACK;
cmp al , bl;
jnz L3 
add score ,2;

mov edx , OFFSET SUCCESS;
mov eax , 47;
jmp L7;
L3:
dec LIFES_GK
mov eax,	79;  
mov edx , OFFSET FAILURE;
L7:

call setTextColor;

mov eax , 1000;
push edx;
mov dh , 20
mov dl , 13
call Gotoxy
pop edx;
call WriteString;

call Delay;
mov eax , 15;
call setTextColor 
call clrscr;
pop ecx;

	





	dec ecx;
jmp L1;
GOOUT:


mov eax, score;
call WriteDec;
call crlf;

ret;
Knowledge_test ENDP;


loaddata PROC
push edx;
push ecx;
push eax;
mov edx , OFFSET FILE_GK;
mov ecx , buffsize_GK;
call OpenInputFile;
mov filehandle , eax;
mov eax,  filehandle
mov edx , OFFSET buffer;
mov ecx , buffsize_GK;
call ReadFromFile;
pop eax;
pop ecx;
pop edx;
ret;
loaddata ENDP;

loadanswers PROC
push eax;
mov edx , OFFSET filename1;
call OpenInputFile;
mov filehandle , eax;
mov eax,filehandle;
mov edx,OFFSET answers;
mov ecx , answersize;
call ReadFromFile;
pop eax;
ret;
loadanswers ENDP;

fetch_answers PROC, target : DWORD;
LOCAL q  : DWORD;
mov ecx , answersize;
mov esi , OFFSET answers;
mov eax, 0;
mov eax , 4;
mov ebx , target;		;;random value
mov q , 0;
mov edi , esi;

L1:
	
	mov al , BYTE PTR [esi]
	cmp al ,10;
	jne notsame; 
	inc q;
	cmp q , ebx;			
	je go;
	inc esi;
	mov edi , esi;
	dec esi;
	notsame:
	
	
	back:
	inc esi;
loop L1;

go:
call crlf;
add edi , 2;
mov eax , 0;
mov al , [edi];
dec esi;
mov eax, 0;
mov al , [esi];

ret;
fetch_answers ENDP;

 
generate_questions PROC  , target : DWORD
LOCAL q  : DWORD;
push ecx;
mov ecx , buffsize_GK;
mov esi , OFFSET buffer;
mov eax, 0;
mov eax , 4;
mov ebx , target;		;;random value
mov q , 0;
mov edi , esi;
L1:
	
	mov al , BYTE PTR [esi]
	cmp al ,',';
	jne notsame; 
	inc q;
	cmp q , ebx;			
	je go;
	inc esi;
	mov edi , esi;
	dec esi;
	notsame:
	
	
	back:
	inc esi;
loop L1;

go:
call crlf;

mov eax , 0;
mov al , [edi];
dec esi;
mov eax, 0;
mov al , [esi];
pop ecx;
ret;
generate_questions ENDP;

printquestions PROC
push eax;
push edi
push esi;
L1:
	cmp esi , edi
	jl getout;
	mov eax , 0;
	mov al , BYTE PTR [edi];
	
	call WriteChar;
	inc edi;
jmp L1;
getout:
call crlf;
dec esi;
pop esi;
pop edi;
pop eax; 

ret;
printquestions ENDP





END main;
