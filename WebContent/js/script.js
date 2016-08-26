function zipCheck(){
	url = "zipCheck.jsp?check=y";
	window.open(url,"zip","toolbar=no,width=350,height=300,top=200,left=300,status=yes,scrollbar=yes,menubar=no")
	//window.open(열파일,제목,기타옵션)
}

function idCheck(){
	if(regForm.id.value === ""){
		alert("id도 없는 찐따라 잘 안들리는데?")
		regForm.id.focus();
	}else{
		url = "idCheck.jsp?id=" + regForm.id.value;
		window.open(url,"id","width=350,height=300,top=200,left=300");
	}
	
}

function inputCheck(){
	//입력자료 오류검사 생략
	
	document.regForm.submit();
}

//회원수정
function memberUpdate(){
	//입력자료오류검사 생략
	document.updateForm.submit();
}


function memberUpdateCancel(){
	location.href = "../guest/guest_index.jsp";
}

function memberDelete(){
	alert("탈퇴안됌ㅋㅋㅋㅋㅋ")
}




