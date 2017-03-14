// JavaScript Document

function getCallBackDate(param1){
	var d = new Date();
	d.setDate(d.getDate() + param1);
	var curr_date = d.getDate();
	var curr_month = ((d.getMonth()) + 1);
	var curr_year = d.getFullYear();
	return curr_month + '/' + curr_date + "/" + curr_year;
}