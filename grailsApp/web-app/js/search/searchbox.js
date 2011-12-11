/***************************/
//@Author: Adrian "yEnS" Mato Gondelle & Ivan Guardado Castro
//@website: www.yensdesign.com
//@email: yensamg@gmail.com
//@license: Feel free to use it, but keep this credits please!					
/***************************/

$(document).ready(function(){
	//global vars
	var searchBoxes = $(".text");
	var searchBox1 = $("#search1");
	var searchBox2 = $("#search2");
	var searchBox2Default = "Search the web...";
	
	//Effects for both searchbox
	searchBoxes.focus(function(e){
		$(this).addClass("active");
	});
	searchBoxes.blur(function(e){
		$(this).removeClass("active");
	});
	
	//Searchbox1, set focus when document is ready
	searchBox1.focus();
	
	//Searchbox2 show/hide default text if needed
	searchBox2.focus(function(){
		if($(this).attr("value") == searchBox2Default) $(this).attr("value", "");
	});
	searchBox2.blur(function(){
		if($(this).attr("value") == "") $(this).attr("value", searchBox2Default);
	});
});