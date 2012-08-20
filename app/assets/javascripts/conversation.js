//This variable holds onto the name of the element in the sidebar which is currently selected
var prevActive = false;
//This holds the unique integer number representing the timer function (for automatic refresh)
var intervalID = -1337;
//The window's page height
var pageHeight = $(window).height();
//How high the main content area should be
var messageHeight = pageHeight - 220;
//How high the navigation sidebar should be
var navHeight = pageHeight - 140;
//On the main content area this represents the horizontal pixel value of the scrollbar
var initalBottomScroll = 0;

$(document).ready(function() {
	//Setup heights
  $('.nav-conversation').css('max-height',navHeight + "px");
});

//Called when the user selects a different conversation from the sidebar
function switchConversation(x)
{
	//Setup the main content area with the new title and make sure it's visible
	$('#well-conversation').attr('class', 'well-conversation');
	$('#h2-conversation').html("Conversation with <b>" + x + "</b>");

	//If this is the first conversation selected setup the styling to highlight the selection
	if (!prevActive)
	{
		$('#' + x + '_nav').attr('class', 'active');
		prevActive = '#' + x + '_nav';
	}
	//Otherwise do the above but also remove the highlighting from the previously selected conversation
	else
	{
		$('#' + x + '_nav').attr('class', 'active');
		$(prevActive).removeClass('active');
		prevActive = '#' + x + '_nav';	
	}

	//If the interval timer hasn't been set, setup a new one
	if (intervalID == -1337)
	{
		intervalID = setInterval(function() {
			$.get('messages/' + x + '?ajaxrefresh=1', function(data) {
			  $('.messages').html(data);
			  //If the user is at the bottom of the scrollpane, automatically move to the bottom
			  //to show the new message
			  if ($('.messages').scrollTop() >= initalBottomScroll)
			  {
			  	$('.messages').scrollTop(99999);
				initalBottomScroll = $('.messages').scrollTop();
			  }
			});},5000);
	}
	//Otherwise remove the old one interval event and create the new one
	else
	{
		clearInterval(intervalID);
		intervalID = setInterval(function() {
			$.get('messages/' + x + '?ajaxrefresh=1', function(data) {
			  $('.messages').html(data);
			  if ($('.messages').scrollTop() >= initalBottomScroll)
			  {
			  	$('.messages').scrollTop(99999);
				initalBottomScroll = $('.messages').scrollTop();
			  }
			});},5000);
	}
	refreshConversation(x);
}

//The function called upon inital conversation load
function refreshConversation(x)
{
	$.get('messages/' + x, function(data) {
	  $('#well-conversation').html(data);
	  $('.messages').css('max-height',messageHeight + "px");
	  $('.messages').scrollTop(99999);
	  initalBottomScroll = $('.messages').scrollTop();
	});
}

//The function called when the user tries to send a message
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