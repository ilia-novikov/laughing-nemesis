function isBlank(string) {
	if (!string) return true;
	for (var i = 0; i < string.length; i++) {
		if (string[i]!=" ")
			return false;
	}
	return true;
};

function testerBlank(object) {
	var group = $(object).parent().parent();
	var span = $(object).parent().children("span");
	if (isBlank($(object).val())) { 
			//Field is blank
			span.text("Field can't be blank");
			group.addClass("error");
			group.addClass("error-blank");
		} else {
			//Field is OK
			if (!(group.hasClass("error-length"))) {
				span.children("span").text("");
				group.removeClass("error");
				group.removeClass("error-blank");
			}
		}
	};

	function testerLength(object) {
		var group = $(object).parent().parent();
		var span = $(object).parent().children("span");
		if ($(object).val().length >= 50) { 
			//Field is overflowed
			span.text("Value is too long");
			group.addClass("error");
			group.addClass("error-length");
		} else {
			//Field is OK
			if (!(group.hasClass("error-blank"))) {
				span.text("");
				group.removeClass("error");
				group.removeClass("error-length");
			}
		}
	};

	$().ready(function() {
		$(".test-blank").blur(function(e) {
			testerBlank(e.target);
		});

		$(".test-length").blur(function(e) {
			testerLength(e.target);
		});

		$('.dropdown-toggle').dropdown();

		console.debug("Page loaded");
	});