function btnClick(e) {
	if(document.getElementById('hostReser')) {
		document.getElementById('hostReser').remove();
	}
	
	var s = "<form action='../reser/hostreservation' method='post' id='hostReser'>";
	s += "<input type='hidden' name='reserNo' value='" + $(e).attr("list-no") + "'>";
	s += "</form>";
	
	$(e).parent().append(s);
	$(e).siblings('form:eq(1)').detach();
	$(e).siblings('form:eq(0)').submit();
}