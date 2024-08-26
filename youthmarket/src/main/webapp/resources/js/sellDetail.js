function storeProduct(sellNo, imgSrc) {
    // localStorage에서 "products" 키 값으로 가져온다.
    let products = localStorage.getItem("products");

    // 만약 products가 undefined가 아니라면, JSON.parse(products)를 통해서 JSON Array를 만들고,
    // 그게 아니라면 list 변수를 새로운 배열로 생성한다.
    let list = products ? JSON.parse(products) : [];

    // 날짜를 실시간으로 얻기
    let date = new Date();
    let year = date.getFullYear(); // 2024출력

    let month = date.getMonth() + 1; // 0부터 시작하니 + 1 해줘서 현재 월을 출력
    month = month < 10 ? "0" + month : month; // 4월 또는 8월을 04월, 08월로 출력

    let day = date.getDate();
    day = day < 10 ? "0" + day : day;

    let hour = date.getHours();
    hour = hour < 10 ? "0" + hour : hour;

    let minute = date.getMinutes();
    minute = minute < 10 ? "0" + minute : minute;

    let second = date.getSeconds();
    second = second < 10 ? "0" + second : second;

    let dateString = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;

    // JSP 표현식을 자바스크립트로 전달하기 위해, 문자열을 사용
    let item = {
        sellNo: sellNo,
        imgSrc: imgSrc,
        createDate: dateString
    };

    // 리스트에 아이템 추가
    list.unshift(item);

    // localStorage에 "products" 키로 리스트를 저장
    localStorage.setItem("products", JSON.stringify(list));
}