var http = require("http");
http.createServer(function(req,res){
    res.end('{"o":123002}'); 
}).listen(8002);
