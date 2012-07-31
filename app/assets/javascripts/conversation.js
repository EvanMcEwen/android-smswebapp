function switchConversation(x)
{
	$.get('messages/' + x, function(data) {
	  $('#well-conversation').html(data);
	  $('#well-conversation').attr('class', 'well-conversation');
	  $('#h2-conversation').html("Conversation with <b>" + x + "</b>");
	  $('.messages').scrollTop(99999);
	});
}