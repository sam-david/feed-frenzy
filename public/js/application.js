$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  console.log('ready')
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  changeGoogleImage = function(url) {
  	console.log(url);
  }

  // (function(){
  //   var widgetIframe = document.getElementById('sc-widget'),
  //       widget       = SC.Widget(widgetIframe),
  //       newSoundUrl = 'http://api.soundcloud.com/tracks/13692671';

  //   widget.bind(SC.Widget.Events.READY, function() {
  //     // load new widget
  //     widget.bind(SC.Widget.Events.FINISH, function() {
  //       widget.load(newSoundUrl, {
  //         show_artwork: false
  //       });
  //     });
  //   });
  // }());
	
  loadSoundcloudWidget = function(url) {
  	console.log('soundcloud')
  	var widgetIframe = document.getElementById('sc-widget'),
        widget       = SC.Widget(widgetIframe);

     widget.load(url, {
     		show_comments: false
     });

    // widget.bind(SC.Widget.Events.READY, function() {
    //   // load new widget
    //   widget.bind(SC.Widget.Events.FINISH, function() {
    //   	console.log('loading')
    //     widget.load(newSoundUrl, {
    //       show_artwork: true
    //     });
    //   });
    // });
  }

  $('a').click(function(e) {
  	e.preventDefault();
  	console.log(this.id)
  	loadSoundcloudWidget(this.id)
  	console.log('poop');
  	window.scrollTo(0, top); 
  })

  loadSoundcloudWidget('https://api.soundcloud.com/tracks/169327138');

});
