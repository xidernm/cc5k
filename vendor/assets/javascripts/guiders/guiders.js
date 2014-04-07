/*!
 * jQuery Plugin: Guider v2.1.0
 * http://www.roydukkey.com/
 *
 * Copyright 2012 roydukkey, Attribution to Optimizely (optimizely.com).
 * Dual licensed under the MIT (http://www.roydukkey.com/mit) and GPL Version 2 (http://www.roydukkey.com/gpl) licenses.
 *
 * Date: 2012-05-03 (Thu, 3 May 2012)
 *
 * NOTE: Please report any improvements to guider@roydukkey.com.
 *       There are still many improvements that can me made to this
 *       script. Thanks to all in the open community.
 * 
 * Setting:
 *{
 *[name: <string>]?
 *[next: <string>]?
 *[className: <string>]?
 *[title: <string>]?
 *[description: <string>]?
 *[width: <number> | <string>]?
 *[overlay: <boolean> | "light" | "dark" |
 *{
 *[color: <string>]?
 *[opacity: <number> | <string>]?
 *}
 *]?
 *[position: "rightTop" | "right" | "rightBottom" | "bottomRight" | "bottom" | "bottomLeft" | "leftBottom" | "left" | "leftTop" | "topLeft" | "top" | "topRight"]?
 *[offset:
 *{
 *[top: <number>]?
 *[left: <number>]?
 *}
 *]?
 *[arrowSize: <number>]?
 *[closable: <boolean>]?
 *[draggable: <boolean>]?
 *[highlight: <boolean>]?
 *[hashable: <boolean>]?
 *[alignButtons: "left" | "center" | "right"]?
 *[buttons: [
 *{
 *[
 *[ Close | Next | Back ]: [ <boolean> | <function> |
 *{
 *[className: <string>]?
 *[click: <boolean> | <function>]?
 *[disabled: <boolean>]?
 *[focus: <boolean>]?
 *}
 *]
 *|
 *<string> : [ <function> |
 *{
 *[className: <string>]?
 *[click: <boolean> | <function>]?
 *[disabled: <boolean>]?
 *[focus: <boolean>]?
 *}
 *]
 *]*
 *}
 *]]?
 *[onShow: <function>]?
 *[onHide: <function>]?
 *}
 */
(function($){
//--
// A: Internal Methods

    // Setting Mutators
    function _set(flags, removeClass){
	if (flags == undefined) return;

	// Draggable
	if (flags & flag_draggable) {
	    _guide.e.draggable && _guide.e.draggable("option", "disabled", !(_guide.s.draggable && (_guide.s.attachTo == undefined || _guide.s.attachTo.length == 0)) )
	}

	// Closable
	if (flags & flag_closable) {
	    _guide.e.find(".jgClose").toggleClass("active", !!_guide.s.closable)
	}

	// ClassName
	if (flags & flag_className) {
	    _guide.e.addClass(_guide.s.className)
	    removeClass != undefined && _guide.e.removeClass(removeClass)
	}

	// Dehighlight
	if (flags & flag_dehighlight) {
	    var element = _guides[_current];
	    element.s.attachTo && element.s.attachTo.removeClass("jGuiderHidden");
	    $(".jGuiderHighlight").remove()
	}

	// Overlay
	if (flags & flag_overlay) {
	    if( _guide.s.overlay ){
		$("#jgOverlay").length === 0 && _overlayHtml.appendTo("body");

		_overlayHtml
		    .toggleClass("jgLight", _guide.s.overlay == "light" || _guide.s.overlay === true)
		    .toggleClass("jgDark", _guide.s.overlay == "dark");

		_guide.s.overlay.color != undefined
		    ? _overlayHtml.css("backgroundColor", _guide.s.overlay.color)
		    : _overlayHtml[0].style.removeProperty
		    ? _overlayHtml[0].style.removeProperty("background-color")
		    : _overlayHtml[0].style.removeAttribute("backgroundColor");
		_guide.s.overlay.opacity != undefined
		    ? _overlayHtml.css("opacity", _guide.s.overlay.opacity)
		    : _overlayHtml[0].style.removeProperty
		    ? _overlayHtml[0].style.removeProperty("opacity")
		    : _overlayHtml[0].style.removeAttribute("filter");

		if(_guide.s.highlight) flags |= flag_highlight;
	    }
	}

	// Highlight
	if (_guide.s.highlight && flags & flag_highlight) {
	    var element = _guide.s.attachTo
	    element.clone()
		.css({
		    width: element.width(),
		    height: element.height(),
		    margin: 0,
		    position: "absolute",
		    top: element.offset().top,
		    left: element.offset().left
		})
		.addClass("jGuiderHighlight")
		.appendTo("body")

	    element
		.addClass("jGuiderHidden")
	}

	// Overlay Hide
	if (flags & flag_overlayHide) {
	    !_omitHiding && _overlayHtml.detach();
	    _omitHiding = false;
	}

	// Align Buttons
	if (flags & flag_alignButtons) {
	    // Validate Input
	    if (_guide.s.alignButtons != "left" && _guide.s.alignButtons != "center" && _guide.s.alignButtons != "right")
		_guide.s.alignButtons = _settings.alignButtons;

	    // Apply
	    _guide.e.find(".jgButtons")
		.toggleClass("jgAlignLeft", _guide.s.alignButtons == "left")
		.toggleClass("jgAlignCenter", _guide.s.alignButtons == "center")
		.toggleClass("jgAlignRight", _guide.s.alignButtons == "right")
	}

	// Width
	if (flags & flag_width) {
	    _guide.e.css("width", _guide.s.width)

	    flags |= flag_recalPositionNotAttached;
	}

	// Title
	if (flags & flag_title) {
	    _guide.e.find(".jgTitle").css("display", !_guide.s.title ? "none" : null).html(_guide.s.title)

	    flags |= flag_recalPositionNotAttached;
	}

	// Description
	if (flags & flag_description) {
	    _guide.e.find(".jgDesc").html(_guide.s.description)

	    flags |= flag_recalPositionNotAttached;
	}

	// Buttons
	if (flags & flag_buttons) {
	    var buttons = _guide.e.find(".jgButtons").find("button").remove().end()

	    for (i in _guide.s.buttons) {
		// Validate Input
		if (typeof _guide.s.buttons[i] == "boolean" || typeof _guide.s.buttons[i] == "function")
		    _guide.s.buttons[i] = {
			click: _guide.s.buttons[i]
		    }

		// Apply
		buttons.append(
		    $("<button>" + i + "</button>")
			.addClass(_guide.s.buttons[i].className)
			.attr("disabled", !!_guide.s.buttons[i].disabled)
			.click(
			    {
				guider: $.isFunction(_guide.s.buttons[i].click)
				? _guide.s.buttons[i].click
				    : -1
			    },
			    typeof _guide.s.buttons[i].click == "boolean"
			    ? 
				i.toLowerCase() == "close" &&
				_plugin.hideAll ||
				i.toLowerCase() == "next" &&
				_plugin.next ||
				i.toLowerCase() == "back" &&
				_plugin.prev
				:
				function(e){
				    return ~e.data.guider && e.data.guider.call(_guide.s.e, e)
				}
			)
		);
	    }

	    flags |= flag_recalPositionNotAttached;
	}

	// Position
	if (flags & flag_position) {

	    // Validate Input
	    _guide.p = (
		_guide.s.position = function(){
		    for (var i = 0; i < _postions.length; i++)
			if (_postions[i].toLowerCase() == _guide.s.position.toLowerCase())
			    return _postions[i]
		}() || _settings.position
	    ).replace(/(.*)[A-Z].*/, "$1," + _guide.s.position).split(",");

	    flags |= flag_recalPositionNotAttached;
	}

	// Recalculate Position
	if (_current == _guide.s.name && flags & (flag_recalPositionAttached | flag_recalPositionNotAttached)) {
	    var height
	    , width
	    , top
	    , left
	    , i

	    height = _guide.e.innerHeight();
	    width = _guide.e.innerWidth();

	    // Not Attached
	    if (_guide.s.attachTo == undefined || _guide.s.attachTo.length == 0) {

		if( flags & flag_recalPositionAttached ) {
		    top = ($(window).height() - height) / 3 + $(window).scrollTop();
		    left = ($(window).width() - width) / 2 + $(window).scrollLeft();
		}
	    }
	    // Attached
	    else {
		// Style Arrow
		var arrow = _guide.e.find(".jgArrow")
		    .removeClass(function(index, className){
			return className.replace("jgArrow");
		    })
		    .addClass("jg-" + _guide.p[_guide.p.length - 1])
		, arrowSize = _guide.s.arrowSize;

		arrow.find("span").add(arrow).css({
		    top: "", right: "", bottom: "", left: "",
		    borderWidth: "",
		    margin: ""
		})

		switch (_guide.p[0]) {
		case "top":
		    arrow.find("span").add(arrow)
			.css("borderWidth", arrowSize + "px " + arrowSize + "px 0 " + arrowSize + "px").end()
			.css("left", -arrowSize);
		    break;
		case "right":
		    arrow.find("span").add(arrow)
			.css("borderWidth", arrowSize + "px " + arrowSize + "px " + arrowSize + "px 0").end()
			.css("top", -arrowSize);
		    break;
		case "bottom":
		    arrow.find("span").add(arrow)
			.css("borderWidth", "0 " + arrowSize + "px " + arrowSize + "px " + arrowSize + "px").end()
			.css("left", -arrowSize);
		    break;
		    //case "left":
		default:
		    arrow.find("span").add(arrow)
			.css("borderWidth", arrowSize + "px 0 " + arrowSize + "px " + arrowSize + "px").end()
			.css("top", -arrowSize)
		}

		i = _guide.s.attachTo.offset();
		top = i.top;
		left = i.left;

		switch (_guide.p[_guide.p.length - 1]) {
		case "top":
		case "bottom":
		    arrow.css("marginLeft", -arrowSize);
		    left += (_guide.s.attachTo.innerWidth() - width) / 2;
		    break;
		case "right":
		case "left":
		    arrow.css("marginTop", -arrowSize);
		    top += (_guide.s.attachTo.innerHeight() - height) / 2;
		    break;
		case "rightTop":
		case "leftTop":
		    arrow.css("top", arrowSize / 1.5);
		    break;
		case "topRight":
		case "bottomRight":
		    arrow.css("right", arrowSize / 1.5);
		    left += _guide.s.attachTo.innerWidth() - width;
		    break;
		case "rightBottom":
		case "leftBottom":
		    arrow.css("bottom", arrowSize / 1.5);
		    top += _guide.s.attachTo.innerHeight() - height;
		    break;
		    //case "topLeft":
		    //case "bottomLeft":
		default:
		    arrow.css("left", arrowSize / 1.5)
		}

		switch (_guide.p[_guide.p.length - 1]) {
		case "topLeft":
		case "top":
		case "topRight":
		    top += -_arrowError - arrowSize - height;
		    break;
		case "rightTop":
		case "right":
		case "rightBottom":
		    left += _arrowError + arrowSize + _guide.s.attachTo.innerWidth();
		    break;
		case "bottomRight":
		case "bottom":
		case "bottomLeft":
		    top += _arrowError + arrowSize + _guide.s.attachTo.innerHeight();
		    break;
		    //case "leftTop":
		    //case "left":
		    //case "leftBottom":
		default:
		    left += -_arrowError + -width - arrowSize
		}

		if( _guide.s.offset != undefined ){
		    top += ~~_guide.s.offset.top;
		    left += ~~_guide.s.offset.left;
		}
	    }

	    _guide.e.css({
		position: _guide.s.attachTo ? "absolute" : "fixed",
		top: top,
		left: left
	    });
	}

    }

    // Throw Error
    function _error( message ){
	throw "Guider " + _plugin.version + ": " + message;
    }

    // Array.indexOf (compatibility)
    function _indexOf( array, searchElement, fromIndex ){
	if (array.indexOf)
	    return array.indexOf(searchElement, fromIndex);
	for (fromIndex = fromIndex || 0; fromIndex < array.length; fromIndex++)
	    if (array[fromIndex] == fromIndex)
		return fromIndex
	return -1;
    }

    // Get guider by name
    function _guideByName( name ){
	if (_guides[name] == undefined) _error("Cannot find a guide with name '" + name + "'");
	return _guides[name]
    }

    // Get or Set Options
    function _option( key, value ){
	var options = ["name", "attachTo"]
	, parts
	, nestedOption
	, i;

	// Disallow Keys
	if (typeof key == "string")
	    value != undefined && ~_indexOf(options, i = key.replace(/\..*/, "")) &&
	    _error("The property '" + i + "' is readonly.")
	else 
	    for (i in key)
		if (~_indexOf(options, i = i.replace(/\..*/, "")))
		    _error("The property '" + i + "' is readonly.");

	// Process Key
	options = key;

	if (typeof key == "string") {
	    // handle nested keys, e.g., "foo.bar" => { foo: { bar: ___ } }
	    options = {};
	    key = (
		parts = key.split(".")
	    ).shift();

	    // Process Nested Keys
	    if (parts.length) {
		nestedOption = options[key] = $.extend({}, _guide.s[key]);

		for (i = 0; i < parts.length - 1; i++)
		    nestedOption = nestedOption[ parts[i] ] = nestedOption[ parts[i] ] || {};

		key = parts.pop();

		if (value === undefined)
		    return nestedOption[key] === undefined ? null : nestedOption[key];

		if (key == "className")
		    i = nestedOption[key]; // Becomes className to remove
		nestedOption[key] = value

		// Process Non-Nested Key
	    } else {
		if (value === undefined)
		    return _guide.s[key] === undefined ? null : _guide.s[key];

		if (key == "className")
		    i = _guide.s[key]; // Becomes className to remove
		options[key] = value
	    }
	}

	// Set Option Map
	// Becomes _set() flags
	nestedOption = 0;
	for (key in options) {
	    _guide.s[key] = options[key];

	    switch (key) {
	    case "alignButtons":
		nestedOption |= flag_alignButtons
		break;
	    case "arrowSize":
	    case "offset":
		nestedOption |= flag_recalPositionNotAttached
		break;
	    case "buttons":
		nestedOption |= flag_buttons
		break;
	    case "className":
		nestedOption |= flag_className
		break;
	    case "closable":
		nestedOption |= flag_closable
		break;
	    case "description":
		nestedOption |= flag_description
		break;
	    case "draggable":
		nestedOption |= flag_draggable
		break;
	    case "highlight":
		nestedOption |= flag_highlight
		break;
	    case "overlay":
		nestedOption |= flag_overlay
		break;
	    case "position":
		nestedOption |= flag_position
		break;
	    case "title":
		nestedOption |= flag_title
		break;
	    case "width":
		nestedOption |= flag_width
	    }
	}

	nestedOption && _set(nestedOption, i);

	return _plugin
    }

    // Displays guider
    function _display(){
	var guideDimension
	, windowDimension
	, scrollDimension
	, i;

	_current != undefined && _plugin.hideAll();
	_current = _guide.s.name

	_guide.e.appendTo("body");

	/*
	  * These are the flags that are passed into _set(). If you need to change the flags passed to
	  * set() uncomment the below and check the console for the value that sould be used.
	  *
	  console.log("Enter, " + (
	  flag_overlay |
	  flag_recalPositionAttached
	  ) + ", as the value in _set() in display().");
	  */
	_set(
	    8224 // Change to reflect the flag combination above, this helps with performance and minification
	);

	// You can use an onShow function to take some action before the guider is shown.
	_guide.s.onShow && _guide.s.onShow.call(_guide.e);

	_guide.e.css("display", "block");

	// Focus Buttons
	for (i in _guide.s.buttons)
	    _guide.s.buttons[i].focus && _guide.e.find(":contains(" + i + ")").focus();

	// Scroll to Guider if bound viewable area
	window.scrollTo(
	    (
		i = _guide.e.offset()
	    ).left - (
		scrollDimension = $(window).scrollLeft()
	    ) < 0
	    ||
		i.left + (
		    guideDimension = _guide.e.width()
		) > scrollDimension + (
		    windowDimension = $(window).width()
		)
		? Math.max(i.left + (guideDimension - windowDimension) / 2, 0)
		: scrollDimension
	    ,
	    i.top - (
		scrollDimension = $(window).scrollTop()
	    ) < 0
	    ||
		i.top + (
		    guideDimension = _guide.e.height()
		) > scrollDimension + (
		    windowDimension = $(window).height()
		)
		? Math.max(i.top + (guideDimension - windowDimension) / 2, 0)
		: scrollDimension
	);
    }
// A: End
//--
//--
// B: Internal Fields
    var
    // Defaults Settings
    _settings = {
	title: "This is a very generic title.",
	description: "Did you forget a description?",
	width: 530,
	position: "rightTop",
	alignButtons: "left",
	overlay: false,
	hashable: false,
	closable: false,
	draggable: true,
	arrowSize: 30
    },

    // Mutator Flags
    flag_draggable= 1,
    flag_closable= 2,
    flag_className= 4,
    flag_highlight= 8,
    flag_dehighlight= 16,
    flag_overlay= 32,
    flag_overlayHide= 64,
    flag_width= 128,
    flag_title= 256,
    flag_description= 512,
    flag_alignButtons= 1024,
    flag_buttons= 2048,
    flag_position= 4096,
    flag_recalPositionAttached= 8192,
    flag_recalPositionNotAttached= 16384,

    // Base HTML
    _baseHtml = '<div class="jGuider" style="display:none;"><div class="jgContent"><div class="jgTitle" /><div class="jgNoDrag"><div class="jgClose" /><div class="jgDesc" /><div class="jgButtons" /></div></div><span class="jgArrow"><span /></span></div>',

    _hashKey = "guider=", // Hash Key
    _guides = [], // All Instantiated of Guides
    _guide, // The Guide being Processed
    _current = null, // Current Guide Name
    _last = null, // Last Guide Name
    _previous = [], // Previous Guides Names

    _omitHiding = false, // Omit Hiding Overlay
    _overlayHtml = $('<div id="jgOverlay" />'), // Overlay HTML

    _arrowError = 10, // arrow's error width and height
    _postions = "topLeft,top,topRight,rightTop,right,rightBottom,bottomRight,bottom,bottomLeft,leftBottom,left,leftTop".split(","), // Position Options

// B: End
//--
//--
// C: Main Pluging Function
    _plugin = $.guider = function(settings, optionName, value) { // $.guider(settings), $.guider(name, optionName), $.guider(name, optionName, value)

	// Determine if we are Setting/Getting Options
	if (typeof settings == "string" && optionName != undefined)
	    return _guide = _guideByName(settings), _option(optionName, value);

	var buttons // Buttons
	, hashKey // Url Hash
	, i = 0;

	// Extend those settings
	_guide = $.extend(true, {}, { s: _settings }, { s: settings })

	// Ensure Correct Values
	if (_guide.name == "length")
	    _error("Guider names must !== 'length'.");

	// Add to list of guiders
	_guides[ _guide.s.name = _last = _guide.s.name || _guides.length || 0 ] = _guide;

	// Button Container and Configure _guide.e
	( _guide.e = $(_baseHtml) )
	    .attr("id", "jGuider_" + _guide.s.name)

	    .find(".jgClose")
	    .click(_plugin.hideAll);

	_guide.e.draggable && _guide.e.draggable({ cancel: ".jgNoDrag" })

	/*
	   * These are the flags that are passed into _set(). If you need to change the flags passed to
	    * set() uncomment the below and check the console for the value that sould be used.
	     *
	     console.log("Enter, " + (
	     flag_draggable |
	     flag_closable |
	     flag_className |
	     flag_width |
	     flag_title |
	     flag_description |
	     flag_alignButtons |
	     flag_buttons |
	     flag_position
	     ) + ", as the value in _set() in $.guider.");
	      */
	_set(
	    8071 // Change to reflect the flag combination above, this helps with performance and minification
	)

	// If the URL of the current window is of the form http://www.myurl.com/mypage.html#guider=id then show this guider.
	_guide.s.hashable &&
	    ~(hashKey = window.location.hash.indexOf(_hashKey)) &&
	    _guide.s.name.toLowerCase() == window.location.hash.substr(hashKey + _hashKey.length).toLowerCase() &&
	    _plugin.show(_guide.s.name);

	return _plugin
    };
// C: End
//--
//--
// D: External Data and Functions
    $.each({
	version: "2.1.0",

	next: function(){
	    _guide = _guides[_current]

	    if (_guide != undefined) {
		_guide = _guide.s.next || null;

		if(_guide !== null && _guide !== ""){
		    _omitHiding = !!(_guide = _guideByName(_guide)).s.overlay;

		    _current != undefined && _previous.push(_current);

		    _display();
		}
	    }
	    return _plugin
	},

	prev: function(){
	    _guide = _guides[_current];

	    if (_guide != undefined && _previous.length) {
		_omitHiding = !!(_guide = _guides[_previous.pop()]).s.overlay;

		_display();
	    }
	    return _plugin
	},

	hideAll: function(){

	    $(".jGuider")
		.filter(":visible")
		.each(function(a, e){
		    var guide = _guideByName($(e).attr("id").replace("jGuider_", ""));
		    guide.s.onHide && guide.s.onHide.call(guide.e)
		})
		    .end()
		.detach();

	    // Remove Highlight And Hide Overlay
	    /*
	       * These are the flags that are passed into _set(). If you need to change the flags passed to
	        * set() uncomment the below and check the console for the value that sould be used.
		 *
		 console.log("Enter, " + (
		 flag_dehighlight |
		 flag_overlayHide
		 ) + ", as the value in _set() in $.guider.hideAll.");
		  */
	    _set(
		80 // Change to reflect the flag combination above, this helps with performance and minification
	    )

	    return _plugin
	},

	show: function(name){
	    _current != undefined && _previous.push(_current);

	    _guide = _guideByName(name != undefined ? name : _last)

	    _display();

	    return _plugin
	}

    }, function(k, v){ _plugin[k] = v });
// D: End
//--
//--
// E: Selectable Plugin Function
    $.fn.guider = function(options){
	options.attachTo = this.eq(0);

	_plugin(options);

	return this
    }
// E: End
//--
//--
// F: Set Up Hash Change Checking
    $(window).on("hashchange", function(){
	var hashKey;

	~(hashKey = window.location.hash.indexOf(_hashKey)) &&
	    _guideByName(
		hashKey = window.location.hash.substr(hashKey + _hashKey.length).toLowerCase()
	    )
	.s.hashable && 
	    _plugin.show(hashKey)
    });
// F: End
//--
})(jQuery);