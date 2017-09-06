
var http = require("http"); 
var url = require("url");
var wait = require('wait.for');
var messages = require("./messages"); 

var handle = {}
handle["/taxonomy"] = messages.taxonomy;
handle["/providers"] = messages.providers;
handle["/shortlist"] = messages.shortlist;
handle["/transaction"] = messages.transaction;

http.createServer(function (request, response) {
	console.log(request.url);	
	//only GET queries
	if (request.method != 'GET'){
		response.writeHead(406, {"Content-Type": "text/plain"});
		response.write("406 Not Acceptable");
		response.end();
		console.log("406");
		return;
	}

	var pathname = url.parse(request.url).pathname; 
	if (typeof handle[pathname] === 'function') {
		
		//allow cross domain requests
		response.setHeader("Access-Control-Allow-Origin", "*");
		
		//adding support for sync calls
		wait.launchFiber(handle[pathname],request,response);
		//handle[pathname](request, response); 
	} else {
		response.writeHead(404, {"Content-Type": "text/plain"});
		response.write("404 Not found");
		response.end();
		console.log("404");
	} 
}).listen(8081);




