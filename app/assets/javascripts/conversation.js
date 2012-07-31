function switchConversation(x)
{
	$.get('messages/' + x, function(data) {
	  $('.messages').html(data);
	  $('.messages').scrollTop(99999);
	});
}