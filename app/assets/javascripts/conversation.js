var prevActive = false;
var intervalID = -1337;

function switchConversation(x)
{
	$('#well-conversation').attr('class', 'well-conversation');
	$('#h2-conversation').html("Conversation with <b>" + x + "</b>");

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

	if (intervalID == -1337)
	{
		intervalID = setInterval(function() {
			$.get('messages/' + x + '?ajaxrefresh=1', function(data) {
			  $('.messages').html(data);
			  $('.messages').scrollTop(99999);
			});},5000);
	}
	else
	{
		clearInterval(intervalID);
		intervalID = setInterval(function() {
			$.get('messages/' + x + '?ajaxrefresh=1', function(data) {
			  $('.messages').html(data);
			  $('.messages').scrollTop(99999);
			});},5000);
	}
	refreshConversation(x);
}

function refreshConversation(x)
{
	$.get('messages/' + x, function(data) {
	  $('#well-conversation').html(data);
	  $('.messages').scrollTop(99999);
	});
}

function sendMessage(address)
{
	var messageToSend = $('#messageToSend').val();
	$('#messageToSend').attr('disabled','disabled');
	$('#messageSendButton').attr('disabled','disabled');
	$.post("outmessages", { "outmessage[message]": messageToSend, "outmessage[destination]": address, ajax_request: true },
	   function(data) {
		  $('#messageToSend').val("");
		  $("#messageToSend").removeAttr("disabled");
		  $("#messageSendButton").removeAttr("disabled");
	   });
}