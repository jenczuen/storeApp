
class Test
	constructor: ->
	    source = $("#products-template").html()
	    template = Handlebars.compile(source)
    	data = {author: "Gural", title: "totem"}
    	html = template(data)
    	$("#products-list").append(html)

$(-> new Test)


###
class Main
	constructor: ->
		source   = $("#some-template").html()		
		template = Handlebars.compile(source)
		name = prompt("Podaj imię:","Twoje imię")
		data = {name: name}
		$(".hello").append(template(data))


$(-> new Main())
###