var prevActive = false;

function switchConversation(x)
{
	$.get('messages/' + x, function(data) {
	  $('#well-conversation').html(data);
	  $('#well-conversation').attr('class', 'well-conversation');
	  if (!prevActive)
	  {
	  	$('#' + x + '_nav').attr('class', 'active');
	  	prevActive = '#' + x + '_nav';
	  }
	  else
	  {
	  	$('#' + x + '_nav').attr('class', 'active');
	  	$(prevActive).removeClass('active');
	  	prevActive = '#' + x + '_nav';	
	  }
	  $('#h2-conversation').html("Conversation with <b>" + x + "</b>");
	  $('.messages').scrollTop(99999);
	});
}

function sendMessage(address)
{
	var messageToSend = $('#messageToSend').val();
	$.post("outmessages", { "outmessage[message]": messageToSend, "outmessage[destination]": address, ajax_request: true },
	   function(data) {
		$.get('outmessages/' + data, function(data) {
		  $('#messageToSend').val("");
		  $('.messages').append(data);
		  $('.messages').scrollTop(99999);
		});
	   });
}