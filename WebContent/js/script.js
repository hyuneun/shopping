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

//게스트가 회원수정
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

//관리자에서 회원수정
function memUpdate(id){
	document.updateFrm.id.value = id
	document.updateFrm.submit();
}

function memberUpdateAdmin(){
	document.updateFormAdmin.submit();
}


function memberUpdateCancelAdmin(){
	location.href = "membermanager.jsp";
}

//관리자에서 상품처리
function productDetail(no){
	document.detailFrm.no.value = no
	document.detailFrm.submit();
}

function productUpdate(no){
	document.updateFrm.no.value = no
	document.updateFrm.submit();
}

function productDelete(no){
	document.deleteFrm.no.value = no
	document.deleteFrm.submit();
}