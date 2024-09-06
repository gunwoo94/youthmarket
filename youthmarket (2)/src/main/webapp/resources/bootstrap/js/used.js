function getImageFiles(e) {
	const uploadFiles = [];
	const files = e.currentTarget.files;
	const imagePreview = document.querySelector('#used-Infoimage-box');
	const docFrag = new DocumentFragment();

	// 파일 타입 검사
	[...files].forEach(file => {
		if (!file.type.match("image/.*")) {
			alert('이미지 파일만 업로드 가능해요');
			return;
		};

		if ([...files].length < 2) {
			uploadFiles.push(file);
			const reader = new FileReader();
			reader.onload = (e) => {
				const preview = createElement(e, file);
				imagePreview.appendChild(preview);
			};
			reader.readAsDataURL(file);
		}
	});
}

//이미지 미리보기

$("#file").change(function() {
	var imgBox = document.getElementById("used-Infoimage-box");
	if (imgBox.hasChildNodes()) {
		imgBox.removeChild(imgBox.firstElementChild);
	}
	else{
		function createElement(e, file) {
		const preBox = document.createElement('div');
		const img = document.createElement('img');
		img.style.height = "174px";
		img.style.width = "120px";
		img.setAttribute('src', e.target.result);
		img.setAttribute('data-file', file.name);
		preBox.appendChild(img);


		return preBox;
		};
	}
});


function createElement(e, file) {
	const preBox = document.createElement('div');
	const img = document.createElement('img');
	img.style.height = "174px";
	img.style.width = "120px";
	img.setAttribute('src', e.target.result);
	img.setAttribute('data-file', file.name);
	img.style.marginTop = "5px";
	preBox.appendChild(img);

	return preBox;
};



const realUpload = document.querySelector('.real-upload');
const upload = document.querySelector('#used-Infoimage-box');

upload.addEventListener('click', () => realUpload.click());

realUpload.addEventListener('change', getImageFiles);
