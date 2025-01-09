function CheckAddProduct(){
	
	let form = document.newProduct;
	let productId = form.productId.value;
	let pname = form.pname.value;
	let unitPrice = form.unitPrice.value;
	let unitsInStock = form.unitsInStock.value;
	
	//JSON
	let data = {
		"productId":productId,
		"pname":pname,
		"unitPrice":unitPrice,
		"unitsInStock":unitsInStock
	};
	/*
	{"productId": "P1237","pname": "노트북 울트라"
	  ,"unitPrice": "12000","unitsInStock": "1000"}
	*/
	console.log("data : ", data);
	
	//상품 아이디 체크. 
	//1) 첫글자는 P.  2) 숫자를 조합하여 5~12자까지 입력 가능
	let regExpProductId = /^P[0-9]{4,11}$/;
	
	//상품명 체크
	//4~12자까지 입력 가능
	//ex)name.value : 삼성갤러시S22
	//역슬러시s : 스페이스바
	let regExpPname = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\s]{4,12}$/;

	//상품 가격 체크
	//숫자만 입력 가능
	//ex) unitPrice.value : 1200000
	let regExpUnitPrice = /^[0-9]+$/;

	//재고 수 체크
	//숫자만 입력 가능
	//isNaN : 이거숫자니? 
	let regExpUnitsInStoce = /^[0-9]+$/;
	/*
	{"productId": "P1237","pname": "노트북 울트라"
	  ,"unitPrice": "12000","unitsInStock": "1000"}
	*/
	if(!regExpProductId.test(productId)){
		alert("[상품 코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요");
		form.productId.focus();
		return;
	}
	
	if(!regExpPname.test(pname)){
		alert("[상품명]\n최소 4자에서 최대 12자까지 입력하세요");
		form.pname.select();
		return;
	}
	
	if(!regExpUnitPrice.test(unitPrice)){
		alert("[가격]\n숫자만 입력하세요");
		form.unitPrice.select();
		return;
	}
	
	if(!regExpUnitsInStoce.test(unitsInStock)){
		alert("[재고 수]\n숫자만 입력하세요");
		form.unitsInStock.select();
		return;
	}
	
	form.submit();
}