<!doctype html>
<html lang="en">
<head>

<meta charset="UTF-8">

<link rel="apple-touch-icon" type="image/png" href="https://cpwebassets.codepen.io/assets/favicon/apple-touch-icon-5ae1a0698dcc2402e9712f7d01ed509a57814f994c660df9f7a952f3060705ee.png">
<meta name="apple-mobile-web-app-title" content="CodePen">

<link rel="shortcut icon" type="image/x-icon" href="https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico">

<link rel="mask-icon" type="" href="https://cpwebassets.codepen.io/assets/favicon/logo-pin-8f3771b1072e3c38bd662872f6b673a722f4b3ca2421637d5596661b4e2132cc.svg" color="#111">

<title>CodePen - Demo: Pure CSS corner ribbon</title>

<style>
@import url(https://fonts.googleapis.com/css?family=Lato:700);

body{
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: #f0f0f0;
}
.box{
	position: relative;
	max-width: 600px;
	width: 90%;
	height: 400px;
	background: #fff;
	box-shadow: 0 0 15px rgba(0,0,0,.1);
}

/* common */
.ribbon {
	width: 150px;
	height: 150px;
	overflow: hidden;
	position: absolute;
}
.ribbon::before,
.ribbon::after {
	position: absolute;
	z-index: -1;
	content: '';
	display: block;
	border: 5px solid #2980b9;
}
.ribbon span {
	position: absolute;
	display: block;
	width: 225px;
	padding: 15px 0;
	background-color: #3498db;
	box-shadow: 0 5px 10px rgba(0,0,0,.1);
	color: #fff;
	font: 700 18px/1 'Lato', sans-serif;
	text-shadow: 0 1px 1px rgba(0,0,0,.2);
	text-transform: uppercase;
	text-align: center;
}

/* top left*/
.ribbon-top-left {
	top: -10px;
	left: -10px;
}
.ribbon-top-left::before,
.ribbon-top-left::after {
	border-top-color: transparent;
	border-left-color: transparent;
}
.ribbon-top-left::before {
	top: 0;
	right: 0;
}
.ribbon-top-left::after {
	bottom: 0;
	left: 0;
}
.ribbon-top-left span {
	right: -25px;
	top: 30px;
	transform: rotate(-45deg);
}

/* top right*/
.ribbon-top-right {
	top: -10px;
	right: -10px;
}
.ribbon-top-right::before,
.ribbon-top-right::after {
	border-top-color: transparent;
	border-right-color: transparent;
}
.ribbon-top-right::before {
	top: 0;
	left: 0;
}
.ribbon-top-right::after {
	bottom: 0;
	right: 0;
}
.ribbon-top-right span {
	left: -25px;
	top: 30px;
	transform: rotate(45deg);
}

/* bottom left*/
.ribbon-bottom-left {
	bottom: -10px;
	left: -10px;
}
.ribbon-bottom-left::before,
.ribbon-bottom-left::after {
	border-bottom-color: transparent;
	border-left-color: transparent;
}
.ribbon-bottom-left::before {
	bottom: 0;
	right: 0;
}
.ribbon-bottom-left::after {
	top: 0;
	left: 0;
}
.ribbon-bottom-left span {
	right: -25px;
	bottom: 30px;
	transform: rotate(225deg);
}

/* bottom right*/
.ribbon-bottom-right {
	bottom: -10px;
	right: -10px;
}
.ribbon-bottom-right::before,
.ribbon-bottom-right::after {
	border-bottom-color: transparent;
	border-right-color: transparent;
}
.ribbon-bottom-right::before {
	bottom: 0;
	left: 0;
}
.ribbon-bottom-right::after {
	top: 0;
	right: 0;
}
.ribbon-bottom-right span {
	left: -25px;
	bottom: 30px;
	transform: rotate(-225deg);
}
</style>
</head>
<body>

	<div class="box">
		<div class="ribbon ribbon-top-left"><span>ribbon</span></div>
		<div class="ribbon ribbon-top-right"><span>ribbon</span></div>
		<div class="ribbon ribbon-bottom-left"><span>ribbon</span></div>
		<div class="ribbon ribbon-bottom-right"><span>ribbon</span></div>
	</div>

</body>
</html>
