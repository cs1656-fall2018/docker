var defectAndroid = window.navigator && window.navigator.userAgent.indexOf('534.30') > 0 && window.navigator.userAgent.toLowerCase().match(/android/);

if (defectAndroid) {
   $("html").addClass("default-android");
}

String.prototype.replaceAll = function(search, replacement) {
	var target = this;
	return target.replace(new RegExp(search, 'g'), replacement);
};
Array.prototype.move = function (old_index, new_index) {
	if (new_index >= this.length) {
		var k = new_index - this.length;
		while ((k--) + 1) {
			this.push(undefined);
		}
	}
	this.splice(new_index, 0, this.splice(old_index, 1)[0]);
	return this; // for testing purposes
};

String.prototype.pick = function(min, max) {
	var n, chars = '';

	if (typeof max === 'undefined') {
		n = min;
	} else {
		n = min + Math.floor(Math.random() * (max - min + 1));
	}

	for (var i = 0; i < n; i++) {
		chars += this.charAt(Math.floor(Math.random() * this.length));
	}

	return chars;
};

String.prototype.shuffle = function() {
	var array = this.split('');
	var tmp, current, top = array.length;

	if (top) while (--top) {
		current = Math.floor(Math.random() * (top + 1));
		tmp = array[current];
		array[current] = array[top];
		array[top] = tmp;
	}

	return array.join('');
};

Math.secureRandom = function(){
	var crypto = window.crypto || window.msCrypto;
	if (!crypto) {
		Math.secureRandom = function(){return Math.random();};
		return Math.random();
	} else {
		Math.secureRandom = function(){
			var crypto = window.crypto || window.msCrypto;
			var buffer = new ArrayBuffer(8);

			var ints = new Int8Array(buffer);
			crypto.getRandomValues(ints);

			ints[7] = 63;
			ints[6] |= 0xf0;

			var float = new Float64Array(buffer)[0] - 1;
			return float;
		};
		return Math.secureRandom();
	}
};

String.prototype.securePick = function(min, max) {
	var n, chars = '';

	if (typeof max === 'undefined') {
		n = min;
	} else {
		n = min + Math.floor(Math.secureRandom() * (max - min + 1));
	}

	for (var i = 0; i < n; i++) {
		chars += this.charAt(Math.floor(Math.secureRandom() * this.length));
	}

	return chars;
};

String.prototype.secureShuffle = function() {
	var array = this.split('');
	var tmp, current, top = array.length;

	if (top) while (--top) {
		current = Math.floor(Math.secureRandom() * (top + 1));
		tmp = array[current];
		array[current] = array[top];
		array[top] = tmp;
	}

	return array.join('');
};

$(document).ready(function(){ 
});

(function( win ){
	var doc = win.document;
	// If there's a hash, or addEventListener is undefined, stop here
	if( !location.hash && win.addEventListener ){
		//scroll to 1
		window.scrollTo( 0, 1 );
		var scrollTop = 1,
			getScrollTop = function(){
				return win.pageYOffset || doc.compatMode === "CSS1Compat" && doc.documentElement.scrollTop || doc.body.scrollTop || 0;
			},
			//reset to 0 on bodyready, if needed
			bodycheck = setInterval(function(){
				if( doc.body ){
					clearInterval( bodycheck );
					scrollTop = getScrollTop();
					win.scrollTo( 0, scrollTop === 1 ? 0 : 1 );
				}
			}, 15 );
		win.addEventListener( "load", function(){
			setTimeout(function(){
				//at load, if user hasn't scrolled more than 20 or so...
				if( getScrollTop() < 20 ){
					//reset to hide addr bar at onload
					win.scrollTo( 0, scrollTop === 1 ? 0 : 1 );
				}
			}, 0);
		} );
	}
})( this );

if (!Date.now) {
    Date.now = function() { return new Date().getTime(); }
}

function expandableToggle(elm){
	if($(elm).hasClass('open'))
		expandableClose(elm);
	else
		expandableOpen(elm);
}

function expandableOpen(elm){
	if(!$(elm).hasClass('open')){
		$(elm).height($(elm).children()[0].clientHeight);
		$(elm).addClass('open');
	}
}

function expandableClose(elm){
	if($(elm).hasClass('open')){
		$(elm).height(0);
		$(elm).removeClass('open');
	}
}

function getElementCoords(elem) {
	var box = elem.getBoundingClientRect();

	var body = document.body;
	var docEl = document.documentElement;

	var scrollTop = window.pageYOffset || docEl.scrollTop || body.scrollTop;
	var scrollLeft = window.pageXOffset || docEl.scrollLeft || body.scrollLeft;

	var clientTop = docEl.clientTop || body.clientTop || 0;
	var clientLeft = docEl.clientLeft || body.clientLeft || 0;

	var top  = box.top +  scrollTop - clientTop;
	var left = box.left + scrollLeft - clientLeft;

	return { top: Math.round(top), left: Math.round(left) };
}

function copyTextToClipboard(text) {
  var textArea = document.createElement("textarea");

  //
  // *** This styling is an extra step which is likely not required. ***
  //
  // Why is it here? To ensure:
  // 1. the element is able to have focus and selection.
  // 2. if element was to flash render it has minimal visual impact.
  // 3. less flakyness with selection and copying which **might** occur if
  //    the textarea element is not visible.
  //
  // The likelihood is the element won't even render, not even a flash,
  // so some of these are just precautions. However in IE the element
  // is visible whilst the popup box asking the user for permission for
  // the web page to copy to the clipboard.
  //

  // Place in top-left corner of screen regardless of scroll position.
  textArea.style.position = 'fixed';
  textArea.style.top = 0;
  textArea.style.left = 0;

  // Ensure it has a small width and height. Setting to 1px / 1em
  // doesn't work as this gives a negative w/h on some browsers.
  textArea.style.width = '2em';
  textArea.style.height = '2em';

  // We don't need padding, reducing the size if it does flash render.
  textArea.style.padding = 0;

  // Clean up any borders.
  textArea.style.border = 'none';
  textArea.style.outline = 'none';
  textArea.style.boxShadow = 'none';

  // Avoid flash of white box if rendered for any reason.
  textArea.style.background = 'transparent';


  textArea.value = text;

  document.body.appendChild(textArea);

  textArea.select();

  try {
    var successful = document.execCommand('copy');
    var msg = successful ? 'successful' : 'unsuccessful';
    //console.log('Copying text command was ' + msg);
  } catch (err) {
    console.log('Oops, unable to copy');
  }

  document.body.removeChild(textArea);
}